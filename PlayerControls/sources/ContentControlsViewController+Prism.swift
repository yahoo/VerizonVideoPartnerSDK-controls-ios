//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import Foundation

/// Prism extension for custom content video controls
public extension ContentControlsViewController.Props {
    public var isNoPlayer: Bool {
        get {
            guard case .noPlayer = self else { return false }
            return true
        }
        set {
            guard newValue else { fatalError("Setting false value forbidden") }
            self = .noPlayer
        }
    }
    
    public var player: Player? {
        get {
            guard case let .player(player) = self else { return nil }
            return player
        }
        set {
            guard let newValue = newValue else { fatalError("Setting nil value forbidden") }
            self = .player(newValue)
        }
    }
    
    public var isPictureInPicture: Bool {
        get {
            guard case .pictureInPicture = self else { return false }
            return true
        }
        set {
            guard newValue else { fatalError("Setting false value forbidden") }
            self = .pictureInPicture
        }
    }
}

public extension ContentControlsViewController.Props.Player.Item {
    public var contorls: Controls? {
        get {
            guard case let .playable(controls) = self else { return nil }
            return controls
        }
        set {
            guard let newValue = newValue else { fatalError("Setting nil value forbidden") }
            self = .playable(newValue)
        }
    }
    
    public var nonplayableReason: String? {
        get {
            guard case let .nonplayable(nonplayableReason) = self else { return nil }
            return nonplayableReason
        }
        set {
            guard let newValue = newValue else { fatalError("Setting nil value forbidden") }
            self = .nonplayable(newValue)
        }
    }
}

public extension ContentControlsViewController.Props.Player.Item.Controls.Playback {
    public var isNone: Bool {
        get {
            guard case .none = self else { return false }
            return true
        }
        set {
            guard newValue else { fatalError("Setting false value forbidden") }
            self = .none
        }
    }
    
    public var play: Action<Void>? {
        get {
            guard case let .play(play) = self else { return nil }
            return play
        }
        set {
            guard let newValue = newValue else { fatalError("Setting nil value forbidden") }
            self = .play(newValue)
        }
    }
    
    public var pause: Action<Void>? {
        get {
            guard case let .pause(pause) = self else { return nil }
            return pause
        }
        set {
            guard let newValue = newValue else { fatalError("Setting nil value forbidden") }
            self = .pause(newValue)
        }
    }
    
    public var replay: Action<Void>? {
        get {
            guard case let .replay(replay) = self else { return nil }
            return replay
        }
        set {
            guard let newValue = newValue else { fatalError("Setting nil value forbidden") }
            self = .replay(newValue)
        }
    }
}

public extension ContentControlsViewController.Props.Player.Item.Controls.Subtitles {
    public var isNone: Bool {
        get {
            guard case .none = self else { return false }
            return true
        }
        set {
            guard newValue else { fatalError("Setting false value forbidden") }
            self = .none
        }
    }
    
    public var isUnavailable: Bool {
        get {
            guard case .unavailable = self else { return false }
            return true
        }
        set {
            guard newValue else { fatalError("Setting false value forbidden") }
            self = .unavailable
        }
    }
    
    public var available: (toggle: Action<Void>, state: State)? {
        get {
            guard case let .available(available) = self else { return nil }
            return available
        }
        set {
            guard let newValue = newValue else { fatalError("Setting nil value forbidden") }
            self = .available(toggle: newValue.toggle, state: newValue.state)
        }
    }
}

public extension ContentControlsViewController.Props.Player.Item.Controls.Subtitles.State {
    public var active: String? {
        get {
            guard case let .active(active) = self else { return nil }
            return active
        }
        set {
            guard let newValue = newValue else { fatalError("Setting nil value forbidden") }
            self = .active(text: newValue)
        }
    }
    
    public var isLoading: Bool {
        get {
            guard case .loading = self else { return false }
            return true
        }
        set {
            guard newValue else { fatalError("Setting false value forbidden") }
            self = .loading
        }
    }
    
    public var isInactive: Bool {
        get {
            guard case .inactive = self else { return false }
            return true
        }
        set {
            guard newValue else { fatalError("Setting false value forbidden") }
            self = .inactive
        }
    }
    
    public var isError: Bool {
        get {
            guard case .error = self else { return false }
            return true
        }
        set {
            guard newValue else { fatalError("Setting false value forbidden") }
            self = .error
        }
    }
}

public extension ContentControlsViewController.Props.Player.Item.Controls.Thumbnail {
    public var url: URL? {
        get {
            guard case let .url(url) = self else { return nil }
            return url
        }
        set {
            guard let newValue = newValue else { fatalError("Setting nil value forbidden") }
            self = .url(newValue)
        }
    }
    
    public var image: UIImage? {
        get {
            guard case let .image(image) = self else { return nil }
            return image
        }
        set {
            guard let newValue = newValue else { fatalError("Setting nil value forbidden") }
            self = .image(newValue)
        }
    }
}

public extension ContentControlsViewController.Props.Player.Item.Controls.PictureInPictureControl {
    public var isUnsupported: Bool {
        get {
            guard case .unsupported = self else { return false }
            return true
        }
        set {
            guard newValue else { fatalError("Setting false value forbidden") }
            self = .unsupported
        }
    }
    
    public var isImpossible: Bool {
        get {
            guard case .impossible = self else { return false }
            return true
        }
        set {
            guard newValue else { fatalError("Setting false value forbidden") }
            self = .impossible
        }
    }
    
    public var possible: Action<Void>? {
        get {
            guard case let .possible(possible) = self else { return nil }
            return possible
        }
        set {
            guard let newValue = newValue else { fatalError("Setting nil value forbidden") }
            self = .possible(newValue)
        }
    }
}
