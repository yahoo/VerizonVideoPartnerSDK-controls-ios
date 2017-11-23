//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import PlayerControls

typealias Props = ContentControlsViewController.Props
func props() -> Props {
    return Props.player(
        DefaultControlsViewController.Props.Player { player in
            player.playlist = DefaultControlsViewController.Props.Player.Playlist()
            player.playlist?.next = nop
            player.playlist?.prev = nop
            player.item = DefaultControlsViewController.Props.Player.Item.playable(
                DefaultControlsViewController.Props.Player.Item.Controls { controls in
                    
                    controls.title = "Some not very long title"
                    controls.seekbar = .init()
                    controls.seekbar?.duration = 3600
                    controls.seekbar?.currentTime = 1800
                    controls.seekbar?.progress = 0.5
                    controls.seekbar?.buffered = 0.75
                    controls.seekbar?.seeker.seekTo = nop()
                    controls.seekbar?.seeker.state.start = nop()
                    
                    controls.playbackAction.pause = nop
                    
                    controls.live.isHidden = true
                    controls.camera = DefaultControlsViewController.Props.Player.Item.Controls.Camera()
                    
                    controls.camera?.angles.horizontal = 3.14
                    controls.camera?.angles.vertical = 3.14
                    controls.camera?.moveTo = nop()
                    
                    controls.sideBarViewHidden = false
                    
                    controls.settings = .enabled(nop())
                    controls.pictureInPictureControl = .possible(nop())
                    controls.airplay = .enabled
                    
                    controls.legible = .external(external: .available(state: .active(text: "Don't you ever give up")), control: DefaultControlsViewController.Props.Player.Item.Controls.MediaGroupControl())
            })
    })
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
        highlighted: UIImage(named: "icon-fav-active", in: Bundle(identifier: "com.aol.one.PlayerControls"), compatibleWith: nil)))
    
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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let vc = DefaultControlsViewController()
        vc.view.backgroundColor = .green
        vc.view.tintColor = .blue
        vc.props = props()
        
        vc.sidebarProps = sideProps()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}

func nop<T>() -> Action<T> {
    return { _ in }
}

func nop<T>(t: T) { }

func nop() { }
