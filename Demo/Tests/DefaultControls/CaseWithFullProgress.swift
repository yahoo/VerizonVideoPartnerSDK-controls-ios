//
//  CaseWithThumbnail.swift
//  DefaultControls
//
//  Created by rtysiachnik on 11/6/17.
//  Copyright © 2017 One by AOL : Publishers. All rights reserved.
//
import UIKit
import SnapshotTest
@testable import PlayerControls


class CaseSeekbarWithFullProgress: SnapshotTest  {
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        
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
        verify(controller, for: iPhone.X.portrait)
        
        verify(controller, for: iPhone.X.landscapeRight)
        
        verify(controller, for: iPad.Pro9_7.Portrait.fullScreen)
    }
}
