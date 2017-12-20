//
//  Inits.swift
//  PlayerControls
//
//  Created by Andrey Doroshko on 12/21/17.
//  Copyright © 2017 One by AOL : Publishers. All rights reserved.
//

import Foundation
private typealias Props = ContentControlsViewController.Props

extension Props.Player {
    public init(playlist: Props.Playlist?, item: Props.Item) {
        self.playlist = playlist
        self.item = item
    }
}

extension Props.Playlist {
    public init(next: Command?, prev: Command?) {
        self.next = next
        self.prev = prev
    }
}

extension Props.Controls {
    public init(airplay: Props.AirPlay,
                audible: Props.MediaGroupControl?,
                camera: Props.Camera?,
                error: Props.Error?,
                legible: Props.Subtitles,
                live: Props.Live,
                loading: Bool,
                pictureInPictureControl: Props.PictureInPictureControl,
                playbackAction: Props.Playback,
                seekbar: Props.Seekbar,
                settings: Props.Settings,
                sideBarViewHidden: Bool,
                thumbnail: Props.Thumbnail?,
                title: String) {
        self.title = title
        self.thumbnail = thumbnail
        self.sideBarViewHidden = sideBarViewHidden
        self.settings = settings
        self.seekbar = seekbar
        self.playbackAction = playbackAction
        self.pictureInPictureControl = pictureInPictureControl
        self.loading = loading
        self.live = live
        self.legible = legible
        self.camera = camera
        self.error = error
        self.audible = audible
        self.airplay = airplay
    }
}

extension Props.Angles {
    public init(horizontal: Float, vertical: Float) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}

extension Props.Camera {
    public init(angles: Props.Angles, moveTo: CommandWith<Props.Angles>) {
        self.angles = angles
        self.moveTo = moveTo
    }
}

extension Props.Error {
    public init(message: String, retryAction: Command?) {
        self.message = message
        self.retryAction = retryAction
    }
}

extension Props.Live {
    public init(isHidden: Bool, dotColor: UIColor?) {
        self.isHidden = isHidden
        self.dotColor = dotColor
    }
}

extension Props.MediaGroupControl {
    public init(options: [Props.Option]) {
        self.options = options
    }
}

extension Props.Option {
    public init(name: String ,
                selected: Bool,
                select: Command) {
        self.name = name
        self.selected = selected
        self.select = select
    }
}

extension Props.Seekbar {
    public init(duration: Props.Seconds, currentTime: Props.Seconds, progress: Props.Progress, buffered: Props.Progress, seeker: Props.Seeker) {
        self.duration = duration
        self.currentTime = currentTime
        self.progress = progress
        self.buffered = buffered
        self.seeker = seeker
    }
}

extension Props.State {
    public init(start: CommandWith<Props.Progress>,
                update: CommandWith<Props.Progress>,
                stop: CommandWith<Props.Progress>) {
        self.start = start
        self.update = update
        self.stop = stop
    }
}

extension Props.Seeker {
    public init(seekTo: CommandWith<Props.Seconds>?, state: Props.State) {
        self.seekTo = seekTo
        self.state = state
    }
}
