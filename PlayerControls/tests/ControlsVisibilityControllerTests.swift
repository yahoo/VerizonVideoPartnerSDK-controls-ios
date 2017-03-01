//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import Quick
@testable import PlayerControls

class ControlsVisibilityControllerTests: QuickSpec {
    override func spec() { //swiftlint:disable:this function_body_length
        describe("ControlsVisibilityController") {
            let recorder = Recorder()
            let controls = ControlsPresentationController.Controls(
                show: recorder.hook("show controls"),
                hide: recorder.hook("hide controls"))
            let timer = ControlsPresentationController.Timer(
                start: recorder.hook("start timer"),
                stop: recorder.hook("end timer"))
            
            beforeEach { recorder.clean() }
            
            var controller: ControlsPresentationController!
            
            it("should setup initial state") {
                recorder.record {
                    controller = ControlsPresentationController(controls: controls, timer: timer)
                }
                
                recorder.verify {
                    controls.show()
                }
            }
            
        
            beforeEach {
                controller = ControlsPresentationController(controls: controls, timer: timer)
            }
            
            it("should hide controls on tap") {
                recorder.record { controller.tap() }
                recorder.verify { controls.hide() }
            }
            
            it("should start timer on play") {
                recorder.record { controller.play() }
                recorder.verify { timer.start() }
            }
            
            context("playing") {
                beforeEach { controller.play() }
                
                it("should hide on timer fire") {
                    recorder.record { controller.timerFired() }
                    recorder.verify { controls.hide() }
                }
                
                it("should stop timer on pause") {
                    recorder.record { controller.pause() }
                    recorder.verify { timer.stop() }
                }
                
                it("should hide and stop on tap") {
                    recorder.record { controller.tap() }
                    recorder.verify {
                        timer.stop()
                        controls.hide()
                    }
                }
            }
            
            context("paused and hidden") {
                beforeEach { controller.tap() }
                
                it("should show controls by tap") {
                    recorder.record { controller.tap() }
                    recorder.verify { controls.show() }
                }
                
                it("should start playing video") {
                    recorder.record { controller.play() }
                    recorder.verify { }
                }
            }
            
            context("playing and hidden") {
                beforeEach { controller.tap(); controller.play() }
                
                it("should show controls on pause") {
                    recorder.record { controller.pause() }
                    recorder.verify { controls.show() }
                }
                
                it("should start timer and show on tap") {
                    recorder.record { controller.tap() }
                    recorder.verify {
                        controls.show()
                        timer.start()
                    }
                }
            }
        }
    }
}

/*
 init -> controls.show
    tap -> controls.hide
        tap -> controls.show
        play -> ()
    play -> controls.show, timer.start
        pause -> controls.hide, timer.stop
        timer -> controls.hide
        tap -> controls.hide, timer.stop
            tap -> controls.show, timer.start
            pause -> controls.show
 */
