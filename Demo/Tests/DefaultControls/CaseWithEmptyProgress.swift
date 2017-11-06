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

class CaseSeekbarWithEmtyProgress: SnapshotTest{
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        
        controller.props = DefaultControlsViewController.Props.player(
            DefaultControlsViewController.Props.Player { player in
                player.playlist = DefaultControlsViewController.Props.Player.Playlist()
                player.playlist?.prev = nop
                player.item = DefaultControlsViewController.Props.Player.Item.playable(
                    DefaultControlsViewController.Props.Player.Item.Controls { controls in
                        
                controls.title = "Some title very very very very very very very very very long"
                controls.seekbar = .init()
                
                controls.seekbar?.duration = 36543
                controls.seekbar?.currentTime = 0
                controls.seekbar?.progress = 0
                controls.seekbar?.buffered = 0
                
                controls.live.isHidden = true
                controls.playbackAction.play = nop
                
                controls.camera = DefaultControlsViewController.Props.Player.Item.Controls.Camera()
                controls.camera?.angles.horizontal = 1.57
                controls.camera?.angles.vertical = 1.57
                
                controls.settings = .enabled(nop)
                controls.legible = .external(external: .available(state: .active(text: "Let me tell you some very very very very very exiting story.")), control: DefaultControlsViewController.Props.Player.Item.Controls.MediaGroupControl())
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

