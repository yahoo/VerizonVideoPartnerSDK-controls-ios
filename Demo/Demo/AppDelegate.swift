//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import PlayerControls

func nop() {}

typealias Props = ContentControlsViewController.Props
func props() -> Props {
    return Props.player(Props.Player { player in
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
                
                controls.live.isHidden = true
                controls.playbackAction.pause = nop
                
                controls.sideBarViewHidden = false
                
                controls.camera = DefaultControlsViewController.Props.Player.Item.Controls.Camera()
                
                controls.settings = .enabled(nop)
                controls.pictureInPictureControl = .possible(nop)
                controls.airplay = .enabled
                
                controls.legible = .`internal`(nil)
        })
    })
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        let vc = DefaultControlsViewController()
        vc.view.backgroundColor = .red
        vc.view.tintColor = .blue
        vc.props = props()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
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
            handler: {})
        
        let addIcon = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-add", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-add-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
        
        let add = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: addIcon,
            handler: {})
        
        let favoriteIcon = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-fav", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-fav-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
        
        let favorite = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: favoriteIcon,
            handler: {})
        
        let laterIcon = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-later", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-later-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
        
        let later = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: laterIcon,
            handler: {})
        
        return [later, favorite, share, add]
    }
}

