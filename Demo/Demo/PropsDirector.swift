//
//  PropsDirector.swift
//  Demo
//
//  Created by rtysiachnik on 1/31/18.
//  Copyright © 2018 One by AOL : Publishers. All rights reserved.
//

import Foundation
//  Copyright © 2018 One by AOL : Publishers. All rights reserved.

import Foundation
import PlayerControls

struct ButtonsProps {
    let settingsState: DefaultControlsViewController.Props.Settings
    let airplayState: DefaultControlsViewController.Props.AirPlay
    let pipState: DefaultControlsViewController.Props.PictureInPictureControl
    let seekerState: DefaultControlsViewController.Props.Seekbar?
    let titleState: String
}

class PropsDirector {
    
    var buttonProps: [ButtonsProps]
    var index = 0
    var endlessLoop: Bool = true
    
    
    init() {
        let seekerState = DefaultControlsViewController.Props.Seekbar(
            duration: 3600,
            currentTime: 1800,
            progress: 0.5,
            buffered: 0.7,
            seeker: Props.Seeker(
                seekTo: .nop,
                state: Props.State(
                    start: .nop,
                    update: .nop,
                    stop: .nop)))
        buttonProps = [ButtonsProps(settingsState: .enabled(.nop), airplayState: .enabled, pipState: .possible(.nop), seekerState: seekerState, titleState: "Title")]
    }
    
    func updateProps() -> DefaultControlsViewController.Props {
        let props = setProps(buttonProps: buttonProps[index])
        let maxIndex = buttonProps.count-1
        if index == maxIndex { index = 0 } else { index += 1 }
        return props
    }
    
    func setProps(buttonProps: ButtonsProps) -> DefaultControlsViewController.Props {
        return Props.player(Props.Player(
            playlist: Props.Playlist(
                next: .nop,
                prev: .nop),
            item: .playable(Props.Controls(
                airplay: buttonProps.airplayState,
                audible: Props.MediaGroupControl(options: []),
                camera: Props.Camera(
                    angles: Props.Angles(
                        horizontal: 0.0,
                        vertical: 0.0),
                    moveTo: .nop),
                error: nil,
                legible: .external(
                    external: .available(state: .active(text: "Somthing short")),
                    control: Props.MediaGroupControl(options: [Props.Option(
                        name: "Option1",
                        selected: true,
                        select: .nop)])),
                live: Props.Live(
                    isHidden: false,
                    dotColor: nil),
                loading: false,
                pictureInPictureControl: buttonProps.pipState,
                playbackAction: .play(.nop),
                seekbar: buttonProps.seekerState,
                settings: buttonProps.settingsState,
                sideBarViewHidden: false,
                thumbnail: nil,
                title: buttonProps.titleState))))
    }
}
