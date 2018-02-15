// Copyright © 2017 Oath. All rights reserved.

import SnappyShrimp
@testable import PlayerControls

class CaseSeekbarWithAllControls: SnapshotTest {
    
    var controller: DefaultControlsViewController {
        let controller = DefaultControlsViewController()
        controller.view.backgroundColor = .red
        controller.view.tintColor = .blue
        
        controller.props = DefaultControlsViewController.Props.player(
            DefaultControlsViewController.Props.Player { player in
                player.playlist = DefaultControlsViewController.Props.Playlist()
                player.playlist?.next = nil
                player.playlist?.prev = nil
                player.item = DefaultControlsViewController.Props.Item.playable(
                    ContentControlsViewController.Props.Controls { controls in
                        
                        controls.title = "SOME VERY LONG LONG LONG LONG TITLE"
                        controls.seekbar = .init()
                        controls.seekbar?.duration = 3600
                        controls.seekbar?.currentTime = 1800
                        controls.seekbar?.progress = 0
                        controls.seekbar?.buffered = 0.75
                        controls.seekbar?.seeker.seekTo = .nop
                        
                        controls.live.isHidden = true
                        controls.playbackAction = .pause(.nop)
                        
                        controls.sideBarViewHidden = false
                        
                        controls.camera = DefaultControlsViewController.Props.Camera()
                        controls.camera?.angles.horizontal = 3.14
                        controls.camera?.angles.vertical = 3.14
                        controls.camera?.moveTo = .nop
                        
                        controls.settings = .enabled(.nop)
                        controls.pictureInPictureControl = .possible(.nop)
                        controls.airplay = .enabled
                        
                        controls.legible = .`internal`(nil)
                })
        })
        controller.sidebarProps = sideProps()
        return controller
    }
    
    func test() {
        if #available(iOS 11.0, *) {
            verify(controller, for: Device.iPhoneX.portrait)
            verify(controller, for: Device.iPhoneX.landscapeLeft)
            verify(controller, for: Device.iPhoneX.landscapeRight)
            
            verify(controller, for: Device.iPhone8.portrait)
            
            verify(controller, for: Device.iPhone8Plus.landscape)
        }
        verify(controller, for: Device.iPhoneSE.portrait)
        verify(controller, for: Device.iPhoneSE.landscape)
        if #available(iOS 11.0, *) {
            verify(controller, for: Device.iPadPro9.portrait.oneThird)
            verify(controller, for: Device.iPadPro9.portrait.twoThirds)
            
            verify(controller, for: Device.iPadPro9.landscape.oneThird)
            verify(controller, for: Device.iPadPro9.landscape.twoThird)
            verify(controller, for: Device.iPadPro9.landscape.half)
            
            verify(controller, for: Device.iPadPro10.landscape.half)
        }
        verify(controller, for: Device.iPadPro12.landscape.half)
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
        
        let addIcon = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-add", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-add-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
        
        let add = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: addIcon,
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
        
        let laterIcon = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-later", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-later-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
        
        let later = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: laterIcon,
            handler: .nop,
            accessibility: .empty)
        
        return [later, favorite, share, add]
    }
}


