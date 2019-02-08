//  Copyright 2019, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import PlayerControls

typealias Props = ContentControlsViewController.Props

extension Controls {
    static let content: ContentControlsViewController = {
        let vc = DefaultControlsViewController()
        vc.props = contentProps()
        vc.sidebarProps = sideBarProps
        vc.view.backgroundColor = .red
        vc.view.tintColor = .blue
        if #available(iOS 10.0, *) {
            var progress: CGFloat = 0.0
            Foundation.Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true) { (timer) in
                if vc.props.player?.item.playable?.seekbar?.progress.value == 1.0  {
                    progress = 0
                }
                progress += 0.01
                vc.props = contentProps(progress: ContentControlsViewController.Props.Progress(progress))
            }
        }
        return vc
    }()
    
    private static func contentProps(progress: Props.Progress = 0) -> Props {
        func backgroundColor() {
            guard let view = UIApplication.shared.windows.first?.rootViewController?.view else { return }
            switch view.backgroundColor {
            case UIColor.red?:
                view.backgroundColor = .blue
                view.tintColor = .red
            case UIColor.blue?:
                view.backgroundColor = .red
                view.tintColor = .blue
            default:
                break
            }
        }
        
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
                legible: Props.MediaGroupControl(options: []),
                live: Props.Live(
                    isHidden: true,
                    dotColor: nil),
                loading: false,
                pictureInPictureControl: .possible(.nop),
                playbackAction: .play(.nop),
                seekbar: Props.Seekbar(
                    duration: 3600,
                    currentTime: 1800,
                    progress: progress,
                    buffered: 1,
                    seeker: Props.Seeker(
                        cuePoints: [0, 0.5, 0.9, 1],
                        seekTo: .nop,
                        state: Props.State(
                            start: .nop,
                            update: .nop,
                            stop: .nop))),
                settings: .enabled(.nop),
                sideBarViewHidden: false,
                thumbnail: nil,
                title: "Title",
                animationsEnabled: true,
                contentFullScreen: .init(action: backgroundColor),
                brandedContent: Props.BrandedContent {
                    $0.advertisementText = "Short text"
                    $0.action = .nop
            }))
        ))
    }
    
    
    private static let sideBarProps: [SideBarView.ButtonProps] = {
        
        let shareIcons = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-share", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-share-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
        
        let share = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: shareIcons,
            handler: .nop,
            accessibility: SideBarView.ButtonProps.Accessibility.empty)
        
        let addIcon = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-add", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-add-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
        
        let add = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: addIcon,
            handler: .nop,
            accessibility: SideBarView.ButtonProps.Accessibility.empty)
        
        let favoriteIcon = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-fav", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-fav-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
        
        let favorite = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: favoriteIcon,
            handler: .nop,
            accessibility: SideBarView.ButtonProps.Accessibility.empty)
        
        let laterIcon = SideBarView.ButtonProps.Icons(
            normal: UIImage(named: "icon-later", in: Bundle(for: SideBarView.self), compatibleWith: nil)!,
            selected: nil,
            highlighted: UIImage(named: "icon-later-active", in: Bundle(for: SideBarView.self), compatibleWith: nil))
        
        let later = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: laterIcon,
            handler: .nop,
            accessibility: SideBarView.ButtonProps.Accessibility.empty)
        
        return [later, favorite, share, add]
    }()
}
