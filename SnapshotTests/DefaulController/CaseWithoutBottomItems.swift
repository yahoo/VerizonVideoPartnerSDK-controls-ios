//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import SnappyShrimp
@testable import PlayerControls

class CaseWithoutBottomItems: SnapshotTest  {
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        controller.view.backgroundColor = .red
        controller.view.tintColor = .blue
        
        controller.props = DefaultControlsViewController.Props.player(
            DefaultControlsViewController.Props.Player { player in
                player.playlist = nil
                player.item = DefaultControlsViewController.Props.Item.playable(
                    ContentControlsViewController.Props.Controls { controls in
                        
                        controls.seekbar = .init()
                        controls.seekbar?.duration = 3600
                        controls.seekbar?.currentTime = 3600
                        controls.seekbar?.progress = 1
                        controls.seekbar?.buffered = 1
                        
                        controls.live.isHidden = true
                        controls.playbackAction = .replay(.nop)
                        
                        controls.camera = nil
                        
                        controls.settings = .hidden
                        controls.pictureInPictureControl = .unsupported
                        controls.airplay = .hidden
                        
                        controls.legible = .`internal`(nil)
                })
        })
        
        return controller
    }
    
    func test() {
        if #available(iOS 10.0, *) {
            verify(controller, for: Device.iPadPro9.portrait.fullScreen)
        }
        if #available(iOS 11.0, *) {
            verify(controller, for: Device.iPhoneX.portrait)
            verify(controller, for: Device.iPhoneX.landscapeRight)
        }
    }
}
