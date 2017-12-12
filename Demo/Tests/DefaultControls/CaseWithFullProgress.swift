//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import SnappyShrimp
@testable import PlayerControls


@available(iOS 11.0, *)
class CaseSeekbarWithFullProgress: SnapshotTest  {
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        controller.view.backgroundColor = .red
        
        controller.props = DefaultControlsViewController.Props.player(
            DefaultControlsViewController.Props.Player { player in
                player.item = DefaultControlsViewController.Props.Player.Item.playable(
                    DefaultControlsViewController.Props.Player.Item.Controls { controls in
                        controls.seekbar = .init()
                        
                        controls.seekbar?.duration = 3600
                        controls.seekbar?.currentTime = 3600
                        controls.seekbar?.progress = 1
                        controls.seekbar?.buffered = 1
                        
                        controls.live.isHidden = true
                        controls.playbackAction.replay = nop
                        
                        controls.camera = nil
                        
                        controls.settings = .disabled
                        controls.pictureInPictureControl = .impossible
                        controls.airplay = .hidden
                        
                        controls.legible = .`internal`(nil)
                })
        })
        
        return controller
    }
    
    func test() {
        verify(controller, for: Device.iPadPro9.portrait.fullScreen)
        
        verify(controller, for: Device.iPhoneX.portrait)
        
        verify(controller, for: Device.iPhoneX.landscapeRight)
    }
}
