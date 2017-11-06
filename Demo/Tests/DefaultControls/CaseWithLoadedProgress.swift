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

class CaseSeekbarWithLoadedProgress: SnapshotTest {
    
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
                
                controls.settings = .hidden
                controls.pictureInPictureControl = .unsupported
                
                controls.legible = .`internal`(nil)
            })
        })
        return controller
    }
    
    func testPortrait() {
        verify(controller, in: .portrait)
    }
    
    func testLandscape() {
        verify(controller, in: .landscape)
    }
}
