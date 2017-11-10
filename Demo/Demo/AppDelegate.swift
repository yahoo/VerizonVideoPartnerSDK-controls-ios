//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import PlayerControls

func nop() {}

typealias Props = ContentControlsViewController.Props
func props() -> Props {
    return Props.player(Props.Player { player in
        player.item = Props.Player.Item.playable(Props.Player.Item.Controls { controls in
            controls.title = "Some title very very very very very very very very very long"
            controls.live.isHidden = true
            controls.seekbar = .init()
            controls.playbackAction.pause = nop
            controls.camera = Props.Player.Item.Controls.Camera()
            controls.settings = .hidden
            controls.pictureInPictureControl = .unsupported
            controls.legible = .`internal`(nil)
            controls.title = ""
            controls.airplay = .enabled
        })
    })
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        let vc = DefaultControlsViewController()
        vc.view.backgroundColor = .green
        vc.view.tintColor = .blue
        vc.props = props()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}

