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
                        
                        controls.title = "SOME TITLE"
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
                        
                        controls.settings = .enabled(nop())
                        controls.pictureInPictureControl = .possible(nop())
                        controls.airplay = .hidden
                        
                        controls.legible = .`internal`(nil)
                })
        })
        
        return controller
    }
    
    func test() {
        verify(controller, for: iPhone.X.portrait)
        verify(controller, for: iPhone.X.landscapeLeft)
        verify(controller, for: iPhone.X.landscapeRight)
        
        verify(controller, for: iPhone.Eight.portrait)
        verify(controller, for: iPhone.Eight.landscape)
        
        verify(controller, for: iPhone.EightPlus.portrait)
        verify(controller, for: iPhone.EightPlus.landscape)
        
        verify(controller, for: iPhone.SE.portrait)
        verify(controller, for: iPhone.SE.landscape)
        
        verify(controller, for: iPad.Pro9_7.Portrait.fullScreen)
        verify(controller, for: iPad.Pro9_7.Portrait.OneThirds)
        verify(controller, for: iPad.Pro9_7.Portrait.TwoThirds)
        verify(controller, for: iPad.Pro9_7.Landscape.fullScreen)
        verify(controller, for: iPad.Pro9_7.Landscape.oneThird)
        verify(controller, for: iPad.Pro9_7.Landscape.twoThird)
        verify(controller, for: iPad.Pro9_7.Landscape.half)
        
        verify(controller, for: iPad.Pro10_5.Portrait.fullScreen)
        verify(controller, for: iPad.Pro10_5.Portrait.OneThirds)
        verify(controller, for: iPad.Pro10_5.Portrait.TwoThirds)
        verify(controller, for: iPad.Pro10_5.Landscape.fullScreen)
        verify(controller, for: iPad.Pro10_5.Landscape.oneThird)
        verify(controller, for: iPad.Pro10_5.Landscape.twoThird)
        verify(controller, for: iPad.Pro10_5.Landscape.half)
        
        verify(controller, for: iPad.Pro12_9.Portrait.fullScreen)
        verify(controller, for: iPad.Pro12_9.Portrait.oneThirds)
        verify(controller, for: iPad.Pro12_9.Portrait.twoThirds)
        verify(controller, for: iPad.Pro12_9.Landscape.fullScreen)
        verify(controller, for: iPad.Pro12_9.Landscape.oneThird)
        verify(controller, for: iPad.Pro12_9.Landscape.twoThird)
        verify(controller, for: iPad.Pro12_9.Landscape.half)
    }
}
