//  Copyright © 2017 Oath. All rights reserved

import Foundation

extension ContentControlsViewController.Props.Player {
    public init(playlist: ContentControlsViewController.Props.Playlist?,
                item: ContentControlsViewController.Props.Item,
                animationsEnabled: Bool) {
        self.playlist = playlist
        self.item = item
        self.animationsEnabled = animationsEnabled
    }
}

extension ContentControlsViewController.Props.Playlist {
    public init(next: Command?, prev: Command?) {
        self.next = next
        self.prev = prev
    }
}

extension ContentControlsViewController.Props.Controls {
    public init(airplay: ContentControlsViewController.Props.AirPlay,
                audible: ContentControlsViewController.Props.MediaGroupControl?,
                camera: ContentControlsViewController.Props.Camera?,
                error: ContentControlsViewController.Props.Error?,
                legible: ContentControlsViewController.Props.Subtitles,
                live: ContentControlsViewController.Props.Live,
                loading: Bool,
                pictureInPictureControl: ContentControlsViewController.Props.PictureInPictureControl,
                playbackAction: ContentControlsViewController.Props.Playback,
                seekbar: ContentControlsViewController.Props.Seekbar?,
                settings: ContentControlsViewController.Props.Settings,
                sideBarViewHidden: Bool,
                thumbnail: ContentControlsViewController.Props.Thumbnail?,
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

extension ContentControlsViewController.Props.Angles {
    public init(horizontal: Float, vertical: Float) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}

extension ContentControlsViewController.Props.Camera {
    public init(angles: ContentControlsViewController.Props.Angles, moveTo: CommandWith<ContentControlsViewController.Props.Angles>) {
        self.angles = angles
        self.moveTo = moveTo
    }
}

extension ContentControlsViewController.Props.Error {
    public init(message: String, retryAction: Command?) {
        self.message = message
        self.retryAction = retryAction
    }
}

extension ContentControlsViewController.Props.Live {
    public init(isHidden: Bool, dotColor: UIColor?) {
        self.isHidden = isHidden
        guard let color = dotColor else { self.dotColor = nil; return }
        self.dotColor = Color(color)
    }
}

extension ContentControlsViewController.Props.MediaGroupControl {
    public init(options: [ContentControlsViewController.Props.Option]) {
        self.options = options
    }
}

extension ContentControlsViewController.Props.Option {
    public init(name: String ,
                selected: Bool,
                select: Command) {
        self.name = name
        self.selected = selected
        self.select = select
    }
}

extension ContentControlsViewController.Props.Seekbar {
    public init(duration: ContentControlsViewController.Props.Seconds,
                currentTime: ContentControlsViewController.Props.Seconds,
                progress: ContentControlsViewController.Props.Progress,
                buffered: ContentControlsViewController.Props.Progress,
                seeker: ContentControlsViewController.Props.Seeker) {
        self.duration = duration
        self.currentTime = currentTime
        self.progress = progress
        self.buffered = buffered
        self.seeker = seeker
    }
}

extension ContentControlsViewController.Props.State {
    public init(start: CommandWith<ContentControlsViewController.Props.Progress>,
                update: CommandWith<ContentControlsViewController.Props.Progress>,
                stop: CommandWith<ContentControlsViewController.Props.Progress>) {
        self.start = start
        self.update = update
        self.stop = stop
    }
}

extension ContentControlsViewController.Props.Seeker {
    public init(seekTo: CommandWith<ContentControlsViewController.Props.Seconds>?, state: ContentControlsViewController.Props.State) {
        self.seekTo = seekTo
        self.state = state
    }
}
