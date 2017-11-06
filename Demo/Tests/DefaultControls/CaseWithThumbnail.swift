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

class CaseWithThumbnail: SnapshotTest{
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        
        controller.props = DefaultControlsViewController.Props.player(
            DefaultControlsViewController.Props.Player { player in
                player.playlist = DefaultControlsViewController.Props.Player.Playlist()
                player.playlist?.next = nop
                player.item = DefaultControlsViewController.Props.Player.Item.playable(
                    DefaultControlsViewController.Props.Player.Item.Controls { controls in
                
                controls.seekbar = .init()
                
                controls.live.isHidden = false
                controls.live.dotColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                controls.sideBarViewHidden = false
                controls.playbackAction.pause = nop
                
                controls.camera = nil
                controls.loading = true
                
                controls.settings = .hidden
                controls.pictureInPictureControl = .unsupported
                
                controls.legible = .`internal`(nil)
                controls.title = "SOME TITLE"
                controls.thumbnail = DefaultControlsViewController.Props.Player.Item.Controls.Thumbnail.image(UIImage(named: "cat")!)
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
