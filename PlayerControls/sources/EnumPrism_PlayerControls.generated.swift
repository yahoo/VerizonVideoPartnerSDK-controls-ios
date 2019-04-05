// Generated using Sourcery 0.16.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

/*Creates value type of the form (foo: Type1, boo: Type2) with given case*/

/*Creates set value of the form (foo: newValue.foo, boo: newValue.boo) with given case and newValue*/

/*Creates set value of the form newValue*/

/*Creates tuple var with given associated value case*/

/*Creates Bool var with given simple case*/

/*For each public enum with cases count > 0 is created extension with cases' prism vars*/
public extension AdVideoControls.Props.AdSkipState {
    var isUnavailable: Bool {
        guard case .unavailable = self else { return false }
        return true
    }

    /*Optional associated values not supported now*/
    var available:  Command?  {
        guard case let .available(available) = self else { return nil }
        return available
    }

    /*Optional associated values not supported now*/
    var awaiting:  Int?  {
        guard case let .awaiting(awaiting) = self else { return nil }
        return awaiting
    }
}
public extension AdVideoControls.Props.MainAction {
    /*Optional associated values not supported now*/
    var play:  Command?  {
        guard case let .play(play) = self else { return nil }
        return play
    }

    /*Optional associated values not supported now*/
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

    /*Optional associated values not supported now*/
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

    /*Optional associated values not supported now*/
    var available:  State?  {
        guard case let .available(available) = self else { return nil }
        return available
    }
}
public extension ContentControlsViewController.Props.External.State {
    /*Optional associated values not supported now*/

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
    /*Optional associated values not supported now*/
    var playable:  ContentControlsViewController.Props.Controls?  {
        guard case let .playable(playable) = self else { return nil }
        return playable
    }

    /*Optional associated values not supported now*/
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

    /*Optional associated values not supported now*/
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

    /*Optional associated values not supported now*/
    var play:  Command?  {
        guard case let .play(play) = self else { return nil }
        return play
    }

    /*Optional associated values not supported now*/
    var pause:  Command?  {
        guard case let .pause(pause) = self else { return nil }
        return pause
    }

    /*Optional associated values not supported now*/
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

    /*Optional associated values not supported now*/
    var enabled:  Command?  {
        guard case let .enabled(enabled) = self else { return nil }
        return enabled
    }
}
public extension ContentControlsViewController.Props.Thumbnail {
    /*Optional associated values not supported now*/
    var url:  URL?  {
        guard case let .url(url) = self else { return nil }
        return url
    }

    /*Optional associated values not supported now*/
    var image:  UIImage?  {
        guard case let .image(image) = self else { return nil }
        return image
    }
}
