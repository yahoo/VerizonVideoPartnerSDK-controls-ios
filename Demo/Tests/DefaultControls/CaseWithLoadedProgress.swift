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
                        controls.title = ""
                        
                        controls.seekbar = .init()
                        controls.seekbar?.duration = 1800
                        controls.seekbar?.currentTime = 3600
                        controls.seekbar?.progress = 0.5
                        controls.seekbar?.buffered = 0.75
                        
                        controls.live.isHidden = true
                        controls.playbackAction.pause = nop()
                        
                        controls.camera = nil
                        
                        controls.settings = .enabled(nop())
                        controls.pictureInPictureControl = .possible(nop())
                        controls.airplay = .enabled
                        
                        controls.legible = .`internal`(nil)
                })
        })
        return controller
    }
    
    func test() {
        verify(controller, for: Presentation.iPhone.X.portrait)
        verify(controller, for: Presentation.iPhone.X.landscapeLeft)
        verify(controller, for: Presentation.iPhone.X.landscapeRight)
        
        verify(controller, for: Presentation.iPhone.Eight.portrait)
        verify(controller, for: Presentation.iPhone.Eight.landscape)
        
        verify(controller, for: Presentation.iPhone.EightPlus.portrait)
        verify(controller, for: Presentation.iPhone.EightPlus.landscape)
        
        verify(controller, for: Presentation.iPhone.SE.portrait)
        verify(controller, for: Presentation.iPhone.SE.landscape)
        
        verify(controller, for: Presentation.iPad.Pro9_7.Portrait.fullScreen)
        verify(controller, for: Presentation.iPad.Pro9_7.Portrait.OneThirds)
        verify(controller, for: Presentation.iPad.Pro9_7.Portrait.TwoThirds)
        verify(controller, for: Presentation.iPad.Pro9_7.Landscape.fullScreen)
        verify(controller, for: Presentation.iPad.Pro9_7.Landscape.oneThird)
        verify(controller, for: Presentation.iPad.Pro9_7.Landscape.twoThird)
        verify(controller, for: Presentation.iPad.Pro9_7.Landscape.half)
        
        verify(controller, for: Presentation.iPad.Pro10_5.Portrait.fullScreen)
        verify(controller, for: Presentation.iPad.Pro10_5.Portrait.OneThirds)
        verify(controller, for: Presentation.iPad.Pro10_5.Portrait.TwoThirds)
        verify(controller, for: Presentation.iPad.Pro10_5.Landscape.fullScreen)
        verify(controller, for: Presentation.iPad.Pro10_5.Landscape.oneThird)
        verify(controller, for: Presentation.iPad.Pro10_5.Landscape.twoThird)
        verify(controller, for: Presentation.iPad.Pro10_5.Landscape.half)
        
        verify(controller, for: Presentation.iPad.Pro12_9.Portrait.fullScreen)
        verify(controller, for: Presentation.iPad.Pro12_9.Portrait.oneThirds)
        verify(controller, for: Presentation.iPad.Pro12_9.Portrait.twoThirds)
        verify(controller, for: Presentation.iPad.Pro12_9.Landscape.fullScreen)
        verify(controller, for: Presentation.iPad.Pro12_9.Landscape.oneThird)
        verify(controller, for: Presentation.iPad.Pro12_9.Landscape.twoThird)
        verify(controller, for: Presentation.iPad.Pro12_9.Landscape.half)
    }
}
