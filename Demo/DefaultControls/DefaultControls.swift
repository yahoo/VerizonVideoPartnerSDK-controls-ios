//
//  DefaultControls.swift
//  DefaultControls
//
//  Created by rtysiachnik on 11/3/17.
//  Copyright © 2017 One by AOL : Publishers. All rights reserved.
//


import UIKit
import SnapshotTest
@testable import PlayerControls

typealias Props = DefaultControlsViewController.Props

class CaseWithThumbnail: SnapshotTest{
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        
        controller.props = Props.player(Props.Player { player in
            player.playlist = Props.Player.Playlist()
            player.playlist?.next = nop
            player.item = Props.Player.Item.playable(Props.Player.Item.Controls { controls in
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
                controls.thumbnail = Props.Player.Item.Controls.Thumbnail.image(UIImage(named: "cat")!)
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

class CaseSeekbarWithEmtyProgress: SnapshotTest{
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        
        controller.props = Props.player(Props.Player { player in
            player.playlist = Props.Player.Playlist()
            player.playlist?.prev = nop
            player.item = Props.Player.Item.playable(Props.Player.Item.Controls { controls in
                controls.title = "Some title very very very very very very very very very long"
                controls.seekbar = .init()
                
                controls.seekbar?.duration = 36543
                controls.seekbar?.currentTime = 0
                controls.seekbar?.progress = 0
                controls.seekbar?.buffered = 0
                
                controls.live.isHidden = true
                controls.playbackAction.play = nop
                
                controls.camera = Props.Player.Item.Controls.Camera()
                controls.camera?.angles.horizontal = 1.57
                controls.camera?.angles.vertical = 1.57
                
                controls.settings = .enabled(nop)
                controls.legible = .external(external: .available(state: .active(text: "Let me tell you some very very very very very exiting story.")), control: Props.Player.Item.Controls.MediaGroupControl())
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

class CaseSeekbarWithConectedProgressAndBuffer: SnapshotTest {
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        
        controller.props = Props.player(Props.Player { player in
            player.playlist = Props.Player.Playlist()
            player.playlist?.next = nop
            player.playlist?.prev = nop
            player.item = Props.Player.Item.playable(Props.Player.Item.Controls { controls in
                controls.seekbar = .init()
                
                controls.seekbar?.duration = 600
                controls.seekbar?.currentTime = 300
                controls.seekbar?.progress = 0.25
                controls.seekbar?.buffered = 0.25
                controls.seekbar?.seeker.seekTo = nop()
                controls.seekbar?.seeker.state.start = nop()
                
                controls.live.isHidden = true
                controls.playbackAction.pause = nop
                
                controls.camera = Props.Player.Item.Controls.Camera()
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

class CaseSeekbarWithLoadedProgress: SnapshotTest {
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        
        controller.props = Props.player(Props.Player { player in
            player.item = Props.Player.Item.playable(Props.Player.Item.Controls { controls in
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

class CaseSeekbarWithFullProgress: SnapshotTest  {
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        
        controller.props = Props.player(Props.Player { player in
            player.item = Props.Player.Item.playable(Props.Player.Item.Controls { controls in
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

// ??? Is there a point to leave this case?
//class NoPlayer: SnapshotTest  {
//
//    var controller: DefaultControlsViewController {
//        let controller = DefaultControlsViewController()
//
//        controller.props = Props.noPlayer
//
//        return controller
//    }
//
//    func testPortrait() {
//        verify(controller, in: .portrait)
//    }
//
//    func testLandscape() {
//        verify(controller, in: .landscape)
//    }
// }


