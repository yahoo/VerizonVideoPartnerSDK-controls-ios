// Copyright © 2017 Oath. All rights reserved.

import SnappyShrimp
@testable import PlayerControls

class CaseWithAirplayActive: SnapshotTest {
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        controller.view.backgroundColor = .red
        controller.view.tintColor = .blue
        
        controller.props = DefaultControlsViewController.Props.player(
            DefaultControlsViewController.Props.Player { player in
                player.playlist = DefaultControlsViewController.Props.Playlist()
                player.playlist?.next = .nop
                player.playlist?.prev = .nop
                player.item = DefaultControlsViewController.Props.Item.playable (
                    DefaultControlsViewController.Props.Controls { controls in
                        
                        controls.title = "Not very long title"
                        controls.seekbar = .init()
                        controls.seekbar?.duration = 360
                        controls.seekbar?.currentTime = 180
                        controls.seekbar?.progress = 0.5
                        controls.seekbar?.buffered = 0.5
                        
                        controls.live.isHidden = true
                        controls.playbackAction = .play(.nop)
                        
                        controls.sideBarViewHidden = false
                        
                        controls.camera = DefaultControlsViewController.Props.Camera()
                        
                        controls.settings = .disabled
                        controls.pictureInPictureControl = .impossible
                        
                        controls.airplay = .active
                        
                        controls.legible = .`internal`(nil)
                })
        })
        controller.sidebarProps = sideProps()
        return controller
    }
    
    func test() {
        if #available(iOS 11.0, *) {
            verify(controller, for: Device.iPhoneX.landscapeRight)
        }
        if #available(iOS 11.0, *) {
            verify(controller, for: Device.iPadPro9.portrait.oneThird)
            verify(controller, for: Device.iPadPro10.portrait.oneThird)
            
            verify(controller, for: Device.iPadPro10.landscape.oneThird)
        }
    }
    
    func sideProps() -> [SideBarView.ButtonProps]{
        
        let shareIcons = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-share", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-share-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
        
        let share = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: shareIcons,
            handler: .nop,
            accessibility: .empty)
        
        let favoriteIcon = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-fav", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-fav-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
        
        let favorite = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: favoriteIcon,
            handler: .nop,
            accessibility: .empty)
        
        return [favorite, share]
    }
}

