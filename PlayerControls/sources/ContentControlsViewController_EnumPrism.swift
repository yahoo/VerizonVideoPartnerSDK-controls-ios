//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

public extension AdVideoControls.Props.AdSkipState {
    var isUnavailable: Bool {
        guard case .unavailable = self else { return false }
        return true
    }
    
    var available:  Command?  {
        guard case let .available(available) = self else { return nil }
        return available
    }
    
    
    var awaiting:  Int?  {
        guard case let .awaiting(awaiting) = self else { return nil }
        return awaiting
    }
}
public extension AdVideoControls.Props.MainAction {
    
    var play:  Command?  {
        guard case let .play(play) = self else { return nil }
        return play
    }
    
    var pause:  Command?  {
        guard case let .pause(pause) = self else { return nil }
        return pause
    }
}
public extension ContentControlsViewController.Props {
    var isNoplayer: Bool {
        guard case .noPlayer = self else { return false }
        return true
    }
    
    var player:  Player?  {
        guard case let .player(player) = self else { return nil }
        return player
    }
    
    var isPictureinpicture: Bool {
        guard case .pictureInPicture = self else { return false }
        return true
    }
}
public extension ContentControlsViewController.Props.AirPlay {
    var isHidden: Bool {
        guard case .hidden = self else { return false }
        return true
    }
    
    var isEnabled: Bool {
        guard case .enabled = self else { return false }
        return true
    }
    
    var isActive: Bool {
        guard case .active = self else { return false }
        return true
    }
}
public extension ContentControlsViewController.Props.External {
    var isNone: Bool {
        guard case .none = self else { return false }
        return true
    }
    
    var isUnavailable: Bool {
        guard case .unavailable = self else { return false }
        return true
    }
    
    var available:  State?  {
        guard case let .available(available) = self else { return nil }
        return available
    }
}
public extension ContentControlsViewController.Props.External.State {
    
    var isLoading: Bool {
        guard case .loading = self else { return false }
        return true
    }
    
    var isInactive: Bool {
        guard case .inactive = self else { return false }
        return true
    }
    
    var isError: Bool {
        guard case .error = self else { return false }
        return true
    }
}
public extension ContentControlsViewController.Props.Item {
    
    var playable:  ContentControlsViewController.Props.Controls?  {
        guard case let .playable(playable) = self else { return nil }
        return playable
    }
    
    var nonplayable:  String?  {
        guard case let .nonplayable(nonplayable) = self else { return nil }
        return nonplayable
    }
}
public extension ContentControlsViewController.Props.PictureInPictureControl {
    var isUnsupported: Bool {
        guard case .unsupported = self else { return false }
        return true
    }
    
    var isImpossible: Bool {
        guard case .impossible = self else { return false }
        return true
    }
    
    var possible:  Command?  {
        guard case let .possible(possible) = self else { return nil }
        return possible
    }
}
public extension ContentControlsViewController.Props.Playback {
    var isNone: Bool {
        guard case .none = self else { return false }
        return true
    }
    
    var play:  Command?  {
        guard case let .play(play) = self else { return nil }
        return play
    }
    
    var pause:  Command?  {
        guard case let .pause(pause) = self else { return nil }
        return pause
    }
    
    var replay:  Command?  {
        guard case let .replay(replay) = self else { return nil }
        return replay
    }
}
public extension ContentControlsViewController.Props.Settings {
    var isHidden: Bool {
        guard case .hidden = self else { return false }
        return true
    }
    
    var isDisabled: Bool {
        guard case .disabled = self else { return false }
        return true
    }
    
    var enabled:  Command?  {
        guard case let .enabled(enabled) = self else { return nil }
        return enabled
    }
}
public extension ContentControlsViewController.Props.Thumbnail {
    
    var url:  URL?  {
        guard case let .url(url) = self else { return nil }
        return url
    }
    
    var image:  UIImage?  {
        guard case let .image(image) = self else { return nil }
        return image
    }
}
