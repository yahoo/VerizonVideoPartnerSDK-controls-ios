//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import SnappyShrimp
@testable import PlayerControls

class CaseWithCustomSeekerColorsAndCuePoints: SnapshotTest {
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        controller.view.backgroundColor = .red
        
        controller.props = DefaultControlsViewController.Props.player(
            DefaultControlsViewController.Props.Player { player in
                player.playlist = DefaultControlsViewController.Props.Playlist()
                player.item = DefaultControlsViewController.Props.Item.playable(
                    ContentControlsViewController.Props.Controls { controls in
                        
                        controls.title = "I am so colorfull"
                        
                        controls.seekbar = .init()
                        
                        controls.seekbar?.seekbarColors = ContentControlsViewController.Props.SeekbarColors(
                            currentTimeColor: Color(.white),
                            progressColor: Color(.cyan),
                            bufferedColor: Color(.black),
                            fillerColor: Color(.green),
                            cuePointsColor: Color(.yellow),
                            dragControlColor: Color(.magenta))
                        
                        controls.seekbar?.duration = 36543
                        controls.seekbar?.currentTime = 10
                        controls.seekbar?.progress = 0.25
                        controls.seekbar?.buffered = 0.5
                        controls.seekbar?.seeker.state.stop = .nop
                        controls.seekbar?.seeker.cuePoints = [0, 0.5, 0.9, 1]
                        
                        controls.live.isHidden = true
                        controls.playbackAction = .replay(.nop)
                        
                        controls.camera = nil
                        
                        controls.settings = .enabled(.nop)
                        controls.pictureInPictureControl = .unsupported
                        controls.airplay = .hidden
                })
                
        })
        return controller
    }
    
    func test() {
        if #available(iOS 11.0, *) {
            verify(controller, for: Device.iPhoneX.landscapeLeft)
        }
        verify(controller, for: Device.iPhoneSE.portrait)
        if #available(iOS 10.0, *) {
            verify(controller, for: Device.iPadPro9.landscape.oneThird)
        }
    }
}
