//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import Foundation

/// Prism extension for custom content video controls
public extension ContentControlsViewController.Props {
    public var noPlayer: Bool {
        guard case .noPlayer = self else { return false }
        return true
    }
    
    public var player: Player? {
        guard case let .player(player) = self else { return nil }
        return player
    }
    
    public var pictureInPicture: Bool {
        guard case .pictureInPicture = self else { return false }
        return true
    }
}

public extension ContentControlsViewController.Props.Player.Item {
    public var contorls: Controls? {
        guard case let .playable(controls) = self else { return nil }
        return controls
    }
    
    public var nonplayableReason: String? {
        guard case let .nonplayable(nonplayableReason) = self else { return nil }
        return nonplayableReason
    }
}

public extension ContentControlsViewController.Props.Player.Item.Controls.Playback {
    public var none: Bool {
        guard case .none = self else { return false }
        return true
    }
    
    public var play: Action<Void>? {
        guard case let .play(play) = self else { return nil }
        return play
    }
    
    public var pause: Action<Void>? {
        guard case let .pause(pause) = self else { return nil }
        return pause
    }
    
    public var replay: Action<Void>? {
        guard case let .replay(replay) = self else { return nil }
        return replay
    }
}

public extension ContentControlsViewController.Props.Player.Item.Controls.Subtitles {
    public var none: Bool {
        guard case .none = self else { return false }
        return true
    }
    
    public var unavailable: Bool {
        guard case .unavailable = self else { return false }
        return true
    }
    
    public var available: (toggle: Action<Void>, state: State)? {
        guard case let .available(available) = self else { return nil }
        return available
    }
}

public extension ContentControlsViewController.Props.Player.Item.Controls.Subtitles.State {
    public var active: String? {
        guard case let .active(active) = self else { return nil }
        return active
    }
    
    public var loading: Bool {
        guard case .loading = self else { return false }
        return true
    }
    
    public var inactive: Bool {
        guard case .loading = self else { return false }
        return true
    }
    
    public var error: Bool {
        guard case .loading = self else { return false }
        return true
    }
}

public extension ContentControlsViewController.Props.Player.Item.Controls.Thumbnail {
    public var url: URL? {
        guard case let .url(url) = self else { return nil }
        return url
    }
    
    public var image: UIImage? {
        guard case let .image(image) = self else { return nil }
        return image
    }
}

public extension ContentControlsViewController.Props.Player.Item.Controls.PictureInPictureControl {
    public var unsupported: Bool {
        guard case .unsupported = self else { return false }
        return true
    }
    
    public var impossible: Bool {
        guard case .impossible = self else { return false }
        return true
    }
    
    public var possible: Action<Void>? {
        guard case let .possible(possible) = self else { return nil }
        return possible
    }
}
