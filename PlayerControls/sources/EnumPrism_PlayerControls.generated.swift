// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

/*Creates value type of the form (foo: Type1, boo: Type2) with given case*/

/*Creates value type of the form foo: Type1*/

/*Creates set value of the form (foo: newValue.foo, boo: newValue.boo) with given case and newValue*/

/*Creates set value of the form newValue*/

/*Creates tuple var with given associated value case*/

/*Creates Bool var with given simple case*/

/*For each public enum with cases count > 0 is created extension with cases' prism vars*/
    public extension AdVideoControls.Props.MainAction {
    /*Optional associated values not supported now*/
        public var play: 
        Command?
 {
            guard case let .play(play) = self else { return nil }
            return play
        }

    /*Optional associated values not supported now*/
        public var pause: 
        Command?
 {
            guard case let .pause(pause) = self else { return nil }
            return pause
        }
    }

    public extension ContentControlsViewController.Props {
    public var isNoplayer: Bool {
        guard case .noPlayer = self else { return false }
        return true
    }

    /*Optional associated values not supported now*/
        public var player: 
        Player?
 {
            guard case let .player(player) = self else { return nil }
            return player
        }

    public var isPictureinpicture: Bool {
        guard case .pictureInPicture = self else { return false }
        return true
    }
    }

    public extension ContentControlsViewController.Props.AirPlay {
    public var isHidden: Bool {
        guard case .hidden = self else { return false }
        return true
    }

    public var isEnabled: Bool {
        guard case .enabled = self else { return false }
        return true
    }

    public var isActive: Bool {
        guard case .active = self else { return false }
        return true
    }
    }

    public extension ContentControlsViewController.Props.External {
    public var isNone: Bool {
        guard case .none = self else { return false }
        return true
    }

    public var isUnavailable: Bool {
        guard case .unavailable = self else { return false }
        return true
    }

    /*Optional associated values not supported now*/
        public var available: 
        State?
 {
            guard case let .available(available) = self else { return nil }
            return available
        }
    }

    public extension ContentControlsViewController.Props.External.State {
    /*Optional associated values not supported now*/

    public var isLoading: Bool {
        guard case .loading = self else { return false }
        return true
    }

    public var isInactive: Bool {
        guard case .inactive = self else { return false }
        return true
    }

    public var isError: Bool {
        guard case .error = self else { return false }
        return true
    }
    }

    public extension ContentControlsViewController.Props.Item {
    /*Optional associated values not supported now*/
        public var playable: 
        ContentControlsViewController.Props.Controls?
 {
            guard case let .playable(playable) = self else { return nil }
            return playable
        }

    /*Optional associated values not supported now*/
        public var nonplayable: 
        String?
 {
            guard case let .nonplayable(nonplayable) = self else { return nil }
            return nonplayable
        }
    }

    public extension ContentControlsViewController.Props.PictureInPictureControl {
    public var isUnsupported: Bool {
        guard case .unsupported = self else { return false }
        return true
    }

    public var isImpossible: Bool {
        guard case .impossible = self else { return false }
        return true
    }

    /*Optional associated values not supported now*/
        public var possible: 
        Command?
 {
            guard case let .possible(possible) = self else { return nil }
            return possible
        }
    }

    public extension ContentControlsViewController.Props.Playback {
    public var isNone: Bool {
        guard case .none = self else { return false }
        return true
    }

    /*Optional associated values not supported now*/
        public var play: 
        Command?
 {
            guard case let .play(play) = self else { return nil }
            return play
        }

    /*Optional associated values not supported now*/
        public var pause: 
        Command?
 {
            guard case let .pause(pause) = self else { return nil }
            return pause
        }

    /*Optional associated values not supported now*/
        public var replay: 
        Command?
 {
            guard case let .replay(replay) = self else { return nil }
            return replay
        }
    }

    public extension ContentControlsViewController.Props.Settings {
    public var isHidden: Bool {
        guard case .hidden = self else { return false }
        return true
    }

    public var isDisabled: Bool {
        guard case .disabled = self else { return false }
        return true
    }

    /*Optional associated values not supported now*/
        public var enabled: 
        Command?
 {
            guard case let .enabled(enabled) = self else { return nil }
            return enabled
        }
    }

    public extension ContentControlsViewController.Props.Thumbnail {
    /*Optional associated values not supported now*/
        public var url: 
        URL?
 {
            guard case let .url(url) = self else { return nil }
            return url
        }

    /*Optional associated values not supported now*/
        public var image: 
        UIImage?
 {
            guard case let .image(image) = self else { return nil }
            return image
        }
    }
