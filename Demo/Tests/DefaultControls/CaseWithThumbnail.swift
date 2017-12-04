//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import SnapshotTest
@testable import PlayerControls


@available(iOS 11.0, *)
class CaseWithThumbnail: SnapshotTest{
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        
        controller.props = DefaultControlsViewController.Props.player(
            DefaultControlsViewController.Props.Player { player in
                player.playlist = DefaultControlsViewController.Props.Player.Playlist()
                player.playlist?.next = nop
                player.item = DefaultControlsViewController.Props.Player.Item.playable(
                    DefaultControlsViewController.Props.Player.Item.Controls { controls in
                        
                        controls.title = "SOME TITLE"
                        controls.seekbar = .init()
                        controls.seekbar?.seeker.state.stop = nop
                        
                        controls.live.isHidden = false
                        controls.live.dotColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                        controls.sideBarViewHidden = false
                        controls.playbackAction.isNone = true
                        
                        controls.camera = nil
                        controls.loading = true
                        
                        controls.settings = .hidden
                        controls.pictureInPictureControl = .unsupported
                        
                        controls.legible = .`internal`(nil)
                        controls.thumbnail = DefaultControlsViewController.Props.Player.Item.Controls.Thumbnail.image(UIImage(named: "brackets")!)
                })
        })
        return controller
    }
    
    func test() {
        verify(controller, for: Device.iPhone_X.portrait)
        verify(controller, for: Device.iPhone_X.landscapeLeft)
        verify(controller, for: Device.iPhone_X.landscapeRight)

        verify(controller, for: Device.iPhone_8.portrait)
        
        verify(controller, for: Device.iPhone_8Plus.landscape)
        
        verify(controller, for: Device.iPhone_SE.portrait)
        
        verify(controller, for: Device.iPad_Pro9_7.Portrait.fullScreen)
        verify(controller, for: Device.iPad_Pro9_7.Portrait.oneThird)
        verify(controller, for: Device.iPad_Pro9_7.Landscape.twoThird)
        
        verify(controller, for: Device.iPad_Pro10_5.Portrait.twoThirds)
        verify(controller, for: Device.iPad_Pro10_5.Landscape.oneThird)
        
        verify(controller, for: Device.iPad_Pro12_9.Portrait.oneThird)
        verify(controller, for: Device.iPad_Pro12_9.Landscape.fullScreen)
    }
}
