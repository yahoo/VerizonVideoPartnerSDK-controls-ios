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

class CaseSeekbarWithConectedProgressAndBuffer: SnapshotTest {
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        
        controller.props = DefaultControlsViewController.Props.player(
            DefaultControlsViewController.Props.Player { player in
                player.playlist = DefaultControlsViewController.Props.Player.Playlist()
                player.playlist?.next = nop
                player.playlist?.prev = nop
                player.item = DefaultControlsViewController.Props.Player.Item.playable(
                    DefaultControlsViewController.Props.Player.Item.Controls { controls in
                        
                controls.seekbar = .init()
                
                controls.seekbar?.duration = 600
                controls.seekbar?.currentTime = 300
                controls.seekbar?.progress = 0.25
                controls.seekbar?.buffered = 0.25
                controls.seekbar?.seeker.seekTo = nop()
                controls.seekbar?.seeker.state.start = nop()
                
                controls.live.isHidden = true
                controls.playbackAction.pause = nop
                
                controls.camera = DefaultControlsViewController.Props.Player.Item.Controls.Camera()
                controls.camera?.angles.horizontal = 3.14
                controls.camera?.angles.vertical = 3.14
                controls.camera?.moveTo = nop()
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
