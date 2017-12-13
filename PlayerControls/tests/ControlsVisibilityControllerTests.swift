//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import XCTest
@testable import PlayerControls

class ControlsVisibilityControllerTests: XCTestCase {
    let recorder = Recorder()
    var controls: ControlsPresentationController.Controls!
    var timer: ControlsPresentationController.Timer!
    var controller: ControlsPresentationController!
    
    override func setUp() {
        super.setUp()
        controls = ControlsPresentationController.Controls(
            show: CommandWith { [weak self] in self?.recorder.hook("show controls")() },
            hide: CommandWith { [weak self] in self?.recorder.hook("hide controls")() })
        timer = ControlsPresentationController.Timer(
            start: CommandWith { [weak self] in self?.recorder.hook("start timer")() },
            stop: CommandWith { [weak self] in self?.recorder.hook("end timer")() })
        controller = ControlsPresentationController(controls: controls, timer: timer)
    }
    
    override func tearDown() {
        recorder.clean()
        
        super.tearDown()
    }
    
    func testInitialState() {
        recorder.record {
            controller = ControlsPresentationController(controls: controls, timer: timer)
        }
        
        recorder.verify {
            controls.show.perform()
        }
    }
    
    
    func testHideOnTap() {
        recorder.record { controller.tap() }
        recorder.verify { controls.hide.perform() }
    }
    
    func testStartTimerOnPlay() {
        recorder.record { controller.play() }
        recorder.verify { timer.start.perform() }
    }
    
    func testPlayingShouldHideOnTimerFire() {
        controller.play()
        recorder.record { controller.timerFired() }
        recorder.verify { controls.hide.perform() }
    }
    
    func testPlayingShouldStopTimerOnPause() {
        controller.play()
        recorder.record { controller.pause() }
        recorder.verify { timer.stop.perform() }
    }
    
    func testPlayingShouldHideAndStopOnTap() {
        controller.play()
        recorder.record { controller.tap() }
        recorder.verify {
            timer.stop.perform()
            controls.hide.perform()
        }
    }
    
    func testPausedAndHiddenShouldShowControlsByTap() {
        controller.tap()
        recorder.record { controller.tap() }
        recorder.verify { controls.show.perform() }
    }
    
    func testPausedAndHiddenShouldStartPlayingVideo() {
        controller.tap()
        recorder.record { controller.play() }
        recorder.verify { }
    }
            
    func testPlayingAndHiddenShouldShowControlsOnPause() {
        controller.tap()
        controller.play()
        recorder.record { controller.pause() }
        recorder.verify { controls.show.perform() }
    }
    
    func testPlayingAndHiddenShouldStartTimerAndShowOnTap() {
        controller.tap()
        controller.play()
        recorder.record { controller.tap() }
        recorder.verify {
            controls.show.perform()
            timer.start.perform()
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
