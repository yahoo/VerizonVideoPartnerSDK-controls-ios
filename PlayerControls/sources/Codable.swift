//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import Foundation

fileprivate enum EnumCodingKeys: String, CodingKey { case `case`, value }

extension ContentControlsViewController.Props: Codable {
    
    public enum Cases: String, Codable {
        case noPlayer
        case player
        case pictureInPicture
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EnumCodingKeys.self)
        let `case` = try values.decode(Cases.self, forKey: .case)
        switch `case` {
        case .noPlayer: self = .noPlayer
        case .pictureInPicture: self = .pictureInPicture
        case .player: self = .player(try values.decode(Player.self, forKey: .value))
        }
        return
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnumCodingKeys.self)
        switch self {
        case ContentControlsViewController.Props.noPlayer:
            try container.encode(Cases.noPlayer, forKey: .case)
        case ContentControlsViewController.Props.pictureInPicture:
            try container.encode(Cases.pictureInPicture, forKey: .case)
        case ContentControlsViewController.Props.player(let player):
            try container.encode(Cases.player, forKey: .case)
            try container.encode(player, forKey: .value)
        }
    }
}

extension ContentControlsViewController.Props.Item: Codable {
    
    public enum Cases: String, Codable {
        case playable
        case nonplayable
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EnumCodingKeys.self)
        let `case` = try values.decode(Cases.self, forKey: .case)
        switch `case` {
        case .playable: self = .playable(try values.decode(ContentControlsViewController.Props.Controls.self, forKey: .value))
        case .nonplayable: self = .nonplayable(try values.decode(String.self, forKey: .value))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnumCodingKeys.self)
        switch self {
        case .nonplayable(let string):
            try container.encode(Cases.nonplayable, forKey: .case)
            try container.encode(string, forKey: .value)
        case .playable(let controls):
            try container.encode(Cases.playable, forKey: .case)
            try container.encode(controls, forKey: .value)
        }
    }
}

extension ContentControlsViewController.Props.Playback: Codable {
    
    public enum Cases: String, Codable {
        case none
        case play
        case pause
        case replay
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EnumCodingKeys.self)
        let `case` = try values.decode(Cases.self, forKey: .case)
        switch `case` {
        case .play: self = .play(try values.decode(Command.self, forKey: .value))
        case .pause: self = .pause(try values.decode(Command.self, forKey: .value))
        case .replay: self = .replay(try values.decode(Command.self, forKey: .value))
        case .none: self = .none
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnumCodingKeys.self)
        switch self {
        case .play(let command):
            try container.encode(Cases.play, forKey: .case)
            try container.encode(command, forKey: .value)
        case .pause(let command):
            try container.encode(Cases.pause, forKey: .case)
            try container.encode(command, forKey: .value)
        case .replay(let command):
            try container.encode(Cases.replay, forKey: .case)
            try container.encode(command, forKey: .value)
        case .none:
            try container.encode(Cases.none, forKey: .case)
        }
    }
}

extension ContentControlsViewController.Props.Thumbnail: Codable {
    
    public enum Error: Swift.Error {
        case encodeRawImage(UIImage)
        case decodeRawImage
    }
    
    public enum Cases: String, Codable {
        case url
        case image
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EnumCodingKeys.self)
        let `case` = try values.decode(Cases.self, forKey: .case)
        switch `case` {
        case .url: self = .url(try values.decode(URL.self, forKey: .value))
        case .image: throw Error.decodeRawImage
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnumCodingKeys.self)
        switch self {
        case .url(let url):
            try container.encode(Cases.url, forKey: .case)
            try container.encode(url, forKey: .value)
        case .image(let image):
            throw Error.encodeRawImage(image)
        }
    }
}

extension ContentControlsViewController.Props.PictureInPictureControl: Codable {
    
    public enum Cases: String, Codable {
        case unsupported
        case impossible
        case possible
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EnumCodingKeys.self)
        let `case` = try values.decode(Cases.self, forKey: .case)
        switch `case` {
        case Cases.unsupported: self = .unsupported
        case Cases.impossible: self = .impossible
        case Cases.possible: self = .possible(try values.decode(Command.self, forKey: .value))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnumCodingKeys.self)
        switch self {
        case .impossible: try container.encode(Cases.unsupported, forKey: .case)
        case .unsupported: try container.encode(Cases.impossible, forKey: .case)
        case .possible(let command):
            try container.encode(Cases.possible, forKey: .case)
            try container.encode(command, forKey: .value)
        }
    }
}

extension ContentControlsViewController.Props.Subtitles: Codable {
    
    public enum Cases: String, Codable {
        case `internal`
        case external
    }
    
    public struct ExternalControl: Codable {
        let external: ContentControlsViewController.Props.External
        let control: ContentControlsViewController.Props.MediaGroupControl
        
        init(external: ContentControlsViewController.Props.External, control: ContentControlsViewController.Props.MediaGroupControl) {
            self.external = external
            self.control = control
        }
        
        public enum CodingKeys: CodingKey {
            case external
            case control
        }
        
        public init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            self.external = try values.decode(ContentControlsViewController.Props.External.self, forKey: .external)
            let type = ContentControlsViewController.Props.MediaGroupControl.self
            self.control = try values.decode(type, forKey: .control)
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.external, forKey: .external)
            try container.encode(self.control, forKey: .control)
        }
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EnumCodingKeys.self)
        let `case` = try values.decode(Cases.self, forKey: .case)
        let type = ContentControlsViewController.Props.MediaGroupControl?.self
        switch `case` {
        case .`internal`:
            self = .`internal`(try values.decode(type, forKey: .value))
        case .external:
            let externalControl = try values.decode(ExternalControl.self, forKey: .value)
            self = .external(external: externalControl.external, control: externalControl.control)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnumCodingKeys.self)
        switch self {
        case .`internal`(let mediaGroupControls):
            try container.encode(Cases.`internal`, forKey: .case)
            try container.encode(mediaGroupControls, forKey: .value)
        case .external(let external, let controls):
            try container.encode(Cases.external, forKey: .case)
            try container.encode(ExternalControl(external: external, control: controls), forKey: .value)
        }
    }
}

extension ContentControlsViewController.Props.External: Codable {
    
    public enum Cases: String, Codable {
        case none
        case unavailable
        case available
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EnumCodingKeys.self)
        let `case` = try values.decode(Cases.self, forKey: .case)
        switch `case` {
        case .available: self = .available(state: try values.decode(State.self, forKey: .value))
        case .unavailable: self = .unavailable
        case .none: self = .none
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnumCodingKeys.self)
        switch self {
        case .available(state: let state):
            try container.encode(Cases.available, forKey: .case)
            try container.encode(state, forKey: .value)
        case .none:
            try container.encode(Cases.none, forKey: .case)
        case .unavailable:
            try container.encode(Cases.unavailable, forKey: .case)
        }
    }
}

extension ContentControlsViewController.Props.External.State: Codable {
    
    public enum Cases: String, Codable {
        case active
        case loading
        case inactive
        case error
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EnumCodingKeys.self)
        let `case` = try values.decode(Cases.self, forKey: .case)
        switch `case` {
        case .active: self = .active(text: try values.decode(String.self, forKey: .value))
        case .loading: self = .loading
        case .inactive: self = .inactive
        case .error: self = .error
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnumCodingKeys.self)
        switch self {
        case .active(text: let text):
            try container.encode(Cases.active, forKey: .case)
            try container.encode(text, forKey: .value)
        case .loading:
            try container.encode(Cases.loading, forKey: .case)
        case .inactive:
            try container.encode(Cases.inactive, forKey: .case)
        case .error:
            try container.encode(Cases.error, forKey: .case)
        }
    }
}

extension ContentControlsViewController.Props.Settings: Codable {
    
    public enum Cases: String, Codable {
        case hidden
        case disabled
        case enabled
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EnumCodingKeys.self)
        let `case` = try values.decode(Cases.self, forKey: .case)
        switch `case` {
        case .hidden: self = .hidden
        case .disabled: self = .disabled
        case .enabled: self = .enabled(try values.decode(Command.self, forKey: .value))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnumCodingKeys.self)
        switch self {
        case .hidden:
            try container.encode(Cases.hidden, forKey: .case)
        case .disabled:
            try container.encode(Cases.disabled, forKey: .case)
        case .enabled(let command):
            try container.encode(Cases.enabled, forKey: .case)
            try container.encode(command, forKey: .value)
        }
    }
}

extension ContentControlsViewController.Props.AirPlay: Codable {
    
    public enum Cases: String, Codable {
        case hidden
        case enabled
        case active
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EnumCodingKeys.self)
        let `case` = try values.decode(Cases.self, forKey: .case)
        switch `case` {
        case .hidden: self = .hidden
        case .enabled: self = .enabled
        case .active: self = .active
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnumCodingKeys.self)
        switch self {
        case .hidden: try container.encode(Cases.hidden, forKey: .case)
        case .enabled: try container.encode(Cases.enabled, forKey: .case)
        case .active: try container.encode(Cases.active, forKey: .case)
        }
    }
}

extension AdVideoControls.Props.MainAction: Codable {
    
    private enum Cases: String, Codable {
        case play
        case pause
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EnumCodingKeys.self)
        let `case` = try values.decode(Cases.self, forKey: .case)
        switch `case` {
        case .play: self = .play(try values.decode(Command.self, forKey: .value))
        case .pause: self = .pause(try values.decode(Command.self, forKey: .value))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnumCodingKeys.self)
        switch self {
        case .play(let command):
            try container.encode(Cases.play, forKey: .case)
            try container.encode(command, forKey: .value)
        case .pause(let command):
            try container.encode(Cases.pause, forKey: .case)
            try container.encode(command, forKey: .value)
        }
    }
}

extension AdVideoControls.Props.ClickAction: Codable {
    
    private enum Cases: String, Codable {
        case show, hide
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EnumCodingKeys.self)
        let `case` = try values.decode(Cases.self, forKey: .case)
        switch `case` {
        case .show: self = .show(try values.decode(Command.self, forKey: .value))
        case .hide: self = .hide(try values.decode(Command.self, forKey: .value))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnumCodingKeys.self)
        switch self {
        case .show(let command):
            try container.encode(Cases.show, forKey: .case)
            try container.encode(command, forKey: .value)
        case .hide(let command):
            try container.encode(Cases.hide, forKey: .case)
            try container.encode(command, forKey: .value)
        }
    }
}
