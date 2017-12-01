//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

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
                        
                        controls.title = "SOME VERY LONG LONG LONG LONG TITLE"
                        controls.seekbar = .init()
                        controls.seekbar?.duration = 3600
                        controls.seekbar?.currentTime = 1800
                        controls.seekbar?.progress = 0.5
                        controls.seekbar?.buffered = 0.75
                        controls.seekbar?.seeker.seekTo = nop()
                        controls.seekbar?.seeker.state.start = nop()
                        
                        controls.live.isHidden = true
                        controls.playbackAction.pause = nop
                        
                        controls.sideBarViewHidden = false
                        
                        controls.camera = DefaultControlsViewController.Props.Player.Item.Controls.Camera()
                        controls.camera?.angles.horizontal = 3.14
                        controls.camera?.angles.vertical = 3.14
                        controls.camera?.moveTo = nop()
                        
                        controls.settings = .enabled(nop())
                        controls.pictureInPictureControl = .possible(nop())
                        controls.airplay = .enabled
                        
                        controls.legible = .`internal`(nil)
                })
        })
        controller.sidebarProps = sideProps()
        return controller
    }
    
    func test() {
        verify(controller, for: iPhone.X.portrait)
        verify(controller, for: iPhone.X.landscapeLeft)
        verify(controller, for: iPhone.X.landscapeRight)
        
        verify(controller, for: iPhone.Eight.portrait)
        
        verify(controller, for: iPhone.EightPlus.landscape)
        
        verify(controller, for: iPhone.SE.portrait)
        verify(controller, for: iPhone.SE.landscape)
        
        
        verify(controller, for: iPad.Pro9_7.Portrait.OneThirds)
        verify(controller, for: iPad.Pro9_7.Portrait.TwoThirds)
        
        verify(controller, for: iPad.Pro9_7.Landscape.oneThird)
        verify(controller, for: iPad.Pro9_7.Landscape.twoThird)
        verify(controller, for: iPad.Pro9_7.Landscape.half)
        
        verify(controller, for: iPad.Pro10_5.Portrait.OneThirds)
        
        verify(controller, for: iPad.Pro12_9.Portrait.oneThirds)
    }
    
    func sideProps() -> [SideBarView.ButtonProps]{
        
        let shareIcons = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-share", in: Bundle(identifier: "com.aol.one.PlayerControls"), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-share-active", in: Bundle(identifier: "com.aol.one.PlayerControls"), compatibleWith: nil))
        
        let share = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: shareIcons,
            handler: {})
        
        let addIcon = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-add", in: Bundle(identifier: "com.aol.one.PlayerControls"), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-add-active", in: Bundle(identifier: "com.aol.one.PlayerControls"), compatibleWith: nil))
        
        let add = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: addIcon,
            handler: {})
        
        let favoriteIcon = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-fav", in: Bundle(identifier: "com.aol.one.PlayerControls"), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-fav-active", in: Bundle(identifier: "com.aol.one.PlayerControls"), compatibleWith: nil))
        
        let favorite = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: favoriteIcon,
            handler: {})
        
        let laterIcon = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-later", in: Bundle(identifier: "com.aol.one.PlayerControls"), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-later-active", in: Bundle(identifier: "com.aol.one.PlayerControls"), compatibleWith: nil))
        
        let later = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: laterIcon,
            handler: {})
        
        return [later, favorite, share, add]
    }
}