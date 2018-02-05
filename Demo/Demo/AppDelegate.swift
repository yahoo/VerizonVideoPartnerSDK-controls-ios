//  Copyright © 2018 Oath. All rights reserved.

import UIKit
import PlayerControls

typealias Props = ContentControlsViewController.Props
func props() -> Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: .nop,
            prev: .nop),
        item: .playable(Props.Controls(
            airplay: .enabled,
            audible: Props.MediaGroupControl(options: []),
            camera: Props.Camera(
                angles: Props.Angles(
                    horizontal: 0.0,
                    vertical: 0.0),
                moveTo: .nop),
            error: nil,
            legible: .external(
                external: .available(state: .active(text: "Something not very short")),
                control: Props.MediaGroupControl(options: [Props.Option(
                    name: "Option1",
                    selected: true,
                    select: .nop)])),
            live: Props.Live(
                isHidden: true,
                dotColor: nil),
            loading: false,
            pictureInPictureControl: .possible(.nop),
            playbackAction: .play(.nop),
            seekbar: Props.Seekbar(
                duration: 3600,
                currentTime: 1800,
                progress: 0.5,
                buffered: 0.7,
                seeker: Props.Seeker(
                    seekTo: .nop,
                    state: Props.State(
                        start: .nop,
                        update: .nop,
                        stop: .nop))),
            settings: .enabled(.nop),
            sideBarViewHidden: false,
            thumbnail: nil,
            title: "Title")),
        animationsEnabled: true))
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let vc = DefaultControlsViewController()
        vc.view.backgroundColor = .red
        vc.view.tintColor = .blue
        vc.props = props()
        vc.sidebarProps = sideProps()
        
        vc.animationsDuration = 0.4
        
        let propsDirector = PropsDirector()
        propsDirector.endlessLoop = true
        propsDirector.propsArray.append(props())
        propsDirector.propsArray.append(contentsOf: seekerAndBotomItemsTransitionsScript())
        propsDirector.propsArray.append(noPlayerCase())
        
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { (timer) in
                guard let updatedProps = propsDirector.updateProps() else { timer.invalidate(); vc.props = props(); return }
                vc.props = updatedProps
            }
        }

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        
        return true
    }
}

func seekerAndBotomItemsTransitionsScript() -> [DefaultControlsViewController.Props] {
    return [everythingEmpty(),
            onlySeekerVisible(),
            bottomViewAndSeekerVisible(),
            onlyBottomItemsViewVisible(),
            bottomViewAndSeekerVisible(),
            onlySeekerVisible(),
            onlyBottomItemsViewVisible(),
            onlySeekerVisible(),
            everythingEmpty(),
            onlyBottomItemsViewVisible(),
            everythingEmpty(),
            bottomViewAndSeekerVisible()
    ]
}

func seekerFadeAnimationScript() -> [DefaultControlsViewController.Props] {
    return [bottomViewAndSeekerVisible(),
            onlyBottomItemsViewVisible(),
            bottomViewAndSeekerVisible()
    ]
}

func noPlayerCase() -> DefaultControlsViewController.Props {
    return Props.player(Props.Player(
        playlist: nil,
        item: Props.Item.nonplayable("Eror 404 player not found"),
        animationsEnabled: true))
}

func everythingEmpty() -> DefaultControlsViewController.Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: .nop,
            prev: .nop),
        item: .playable(Props.Controls(
            airplay: .hidden,
            audible: Props.MediaGroupControl(options: []),
            camera: Props.Camera(
                angles: Props.Angles(
                    horizontal: 0.0,
                    vertical: 0.0),
                moveTo: .nop),
            error: nil,
            legible: .external(
                external: .available(state: .active(text: "Something not very short")),
                control: Props.MediaGroupControl(options: [Props.Option(
                    name: "Option1",
                    selected: true,
                    select: .nop)])),
            live: Props.Live(
                isHidden: true,
                dotColor: nil),
            loading: false,
            pictureInPictureControl: .unsupported,
            playbackAction: .play(.nop),
            seekbar: nil,
            settings: .hidden,
            sideBarViewHidden: false,
            thumbnail: nil,
            title: "")),
        animationsEnabled: true))
}

func bottomViewAndSeekerVisible() -> DefaultControlsViewController.Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: .nop,
            prev: .nop),
        item: .playable(Props.Controls(
            airplay: .enabled,
            audible: Props.MediaGroupControl(options: []),
            camera: Props.Camera(
                angles: Props.Angles(
                    horizontal: 0.0,
                    vertical: 0.0),
                moveTo: .nop),
            error: nil,
            legible: .external(
                external: .available(state: .active(text: "Something not very short")),
                control: Props.MediaGroupControl(options: [Props.Option(
                    name: "Option1",
                    selected: true,
                    select: .nop)])),
            live: Props.Live(
                isHidden: true,
                dotColor: nil),
            loading: false,
            pictureInPictureControl: .possible(.nop),
            playbackAction: .play(.nop),
            seekbar: Props.Seekbar(
                duration: 3600,
                currentTime: 1800,
                progress: 0.5,
                buffered: 0.7,
                seeker: Props.Seeker(
                    seekTo: .nop,
                    state: Props.State(
                        start: .nop,
                        update: .nop,
                        stop: .nop))),
            settings: .enabled(.nop),
            sideBarViewHidden: false,
            thumbnail: nil,
            title: "Title")),
        animationsEnabled: true))
}

func onlySeekerVisible() -> DefaultControlsViewController.Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: .nop,
            prev: .nop),
        item: .playable(Props.Controls(
            airplay: .hidden,
            audible: Props.MediaGroupControl(options: []),
            camera: Props.Camera(
                angles: Props.Angles(
                    horizontal: 0.0,
                    vertical: 0.0),
                moveTo: .nop),
            error: nil,
            legible: .external(
                external: .available(state: .active(text: "Something not very short")),
                control: Props.MediaGroupControl(options: [Props.Option(
                    name: "Option1",
                    selected: true,
                    select: .nop)])),
            live: Props.Live(
                isHidden: true,
                dotColor: nil),
            loading: false,
            pictureInPictureControl: .unsupported,
            playbackAction: .play(.nop),
            seekbar: Props.Seekbar(
                duration: 3600,
                currentTime: 1800,
                progress: 0.5,
                buffered: 0.7,
                seeker: Props.Seeker(
                    seekTo: .nop,
                    state: Props.State(
                        start: .nop,
                        update: .nop,
                        stop: .nop))),
            settings: .hidden,
            sideBarViewHidden: false,
            thumbnail: nil,
            title: "")),
        animationsEnabled: true))
}

func onlyBottomItemsViewVisible() -> DefaultControlsViewController.Props {
    return Props.player(Props.Player(
        playlist: Props.Playlist(
            next: .nop,
            prev: .nop),
        item: .playable(Props.Controls(
            airplay: .enabled,
            audible: Props.MediaGroupControl(options: []),
            camera: Props.Camera(
                angles: Props.Angles(
                    horizontal: 0.0,
                    vertical: 0.0),
                moveTo: .nop),
            error: nil,
            legible: .external(
                external: .available(state: .active(text: "Something not very short")),
                control: Props.MediaGroupControl(options: [Props.Option(
                    name: "Option1",
                    selected: true,
                    select: .nop)])),
            live: Props.Live(
                isHidden: true,
                dotColor: nil),
            loading: false,
            pictureInPictureControl: .possible(.nop),
            playbackAction: .play(.nop),
            seekbar: nil,
            settings: .enabled(.nop),
            sideBarViewHidden: false,
            thumbnail: nil,
            title: "Title")),
        animationsEnabled: true))
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
        handler: .nop)
    
    let addIcon = SideBarView.ButtonProps.Icons(
        normal: UIImage(named: "icon-add", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
        selected: nil,
        highlighted: UIImage(named: "icon-add-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
    
    let add = SideBarView.ButtonProps(
        isEnabled: true,
        isSelected: false,
        icons: addIcon,
        handler: .nop)
    
    let favoriteIcon = SideBarView.ButtonProps.Icons(
        normal: UIImage(named: "icon-fav", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
        selected: nil,
        highlighted: UIImage(named: "icon-fav-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
    
    let favorite = SideBarView.ButtonProps(
        isEnabled: true,
        isSelected: false,
        icons: favoriteIcon,
        handler: .nop)
    
    let laterIcon = SideBarView.ButtonProps.Icons(
        normal: UIImage(named: "icon-later", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
        selected: nil,
        highlighted: UIImage(named: "icon-later-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
    
    let later = SideBarView.ButtonProps(
        isEnabled: true,
        isSelected: false,
        icons: laterIcon,
        handler: .nop)
    
    return [later, favorite, share, add]
}
