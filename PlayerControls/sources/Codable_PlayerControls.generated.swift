// Generated using Sourcery 0.13.1 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

fileprivate enum EnumCodingKeys: String, CodingKey { case `case`, value }









extension AdVideoControls.Props.MainAction: Codable {

public enum Cases: String, Codable {
case play
case pause
}



public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: EnumCodingKeys.self)
    let `case` = try values.decode(Cases.self, forKey: .case)
    switch `case` {
    case .play:
                        self = .play( try values.decode( CommandWith.self, forKey: .value))
    case .pause:
                        self = .pause( try values.decode( CommandWith.self, forKey: .value))
}
return
}

public func encode(to encoder: Encoder) throws {
var container = encoder.container(keyedBy: EnumCodingKeys.self)
switch self {
            case .play(let variable):
            try container.encode(Cases.play, forKey: .case)
            try container.encode(variable, forKey: .value)
            case .pause(let variable):
            try container.encode(Cases.pause, forKey: .case)
            try container.encode(variable, forKey: .value)
}
}

}

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
    case .noPlayer:
            self = .noPlayer
    case .player:
                        self = .player( try values.decode( ContentControlsViewController.Props.Player.self, forKey: .value))
    case .pictureInPicture:
            self = .pictureInPicture
}
return
}

public func encode(to encoder: Encoder) throws {
var container = encoder.container(keyedBy: EnumCodingKeys.self)
switch self {
        case .noPlayer:
        try container.encode(Cases.noPlayer, forKey: .case)
            case .player(let variable):
            try container.encode(Cases.player, forKey: .case)
            try container.encode(variable, forKey: .value)
        case .pictureInPicture:
        try container.encode(Cases.pictureInPicture, forKey: .case)
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
    case .hidden:
            self = .hidden
    case .enabled:
            self = .enabled
    case .active:
            self = .active
}
return
}

public func encode(to encoder: Encoder) throws {
var container = encoder.container(keyedBy: EnumCodingKeys.self)
switch self {
        case .hidden:
        try container.encode(Cases.hidden, forKey: .case)
        case .enabled:
        try container.encode(Cases.enabled, forKey: .case)
        case .active:
        try container.encode(Cases.active, forKey: .case)
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
    case .none:
            self = .none
    case .unavailable:
            self = .unavailable
    case .available:
                        self = .available( state: try values.decode( ContentControlsViewController.Props.External.State.self, forKey: .value))
}
return
}

public func encode(to encoder: Encoder) throws {
var container = encoder.container(keyedBy: EnumCodingKeys.self)
switch self {
        case .none:
        try container.encode(Cases.none, forKey: .case)
        case .unavailable:
        try container.encode(Cases.unavailable, forKey: .case)
            case .available(let variable):
            try container.encode(Cases.available, forKey: .case)
            try container.encode(variable, forKey: .value)
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
    case .active:
                        self = .active( text: try values.decode(String?.self, forKey: .value))
    case .loading:
            self = .loading
    case .inactive:
            self = .inactive
    case .error:
            self = .error
}
return
}

public func encode(to encoder: Encoder) throws {
var container = encoder.container(keyedBy: EnumCodingKeys.self)
switch self {
            case .active(let variable):
            try container.encode(Cases.active, forKey: .case)
            try container.encode(variable, forKey: .value)
        case .loading:
        try container.encode(Cases.loading, forKey: .case)
        case .inactive:
        try container.encode(Cases.inactive, forKey: .case)
        case .error:
        try container.encode(Cases.error, forKey: .case)
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
    case .playable:
                        self = .playable( try values.decode( ContentControlsViewController.Props.Controls.self, forKey: .value))
    case .nonplayable:
                        self = .nonplayable( try values.decode(String.self, forKey: .value))
}
return
}

public func encode(to encoder: Encoder) throws {
var container = encoder.container(keyedBy: EnumCodingKeys.self)
switch self {
            case .playable(let variable):
            try container.encode(Cases.playable, forKey: .case)
            try container.encode(variable, forKey: .value)
            case .nonplayable(let variable):
            try container.encode(Cases.nonplayable, forKey: .case)
            try container.encode(variable, forKey: .value)
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
    case .unsupported:
            self = .unsupported
    case .impossible:
            self = .impossible
    case .possible:
                        self = .possible( try values.decode( CommandWith.self, forKey: .value))
}
return
}

public func encode(to encoder: Encoder) throws {
var container = encoder.container(keyedBy: EnumCodingKeys.self)
switch self {
        case .unsupported:
        try container.encode(Cases.unsupported, forKey: .case)
        case .impossible:
        try container.encode(Cases.impossible, forKey: .case)
            case .possible(let variable):
            try container.encode(Cases.possible, forKey: .case)
            try container.encode(variable, forKey: .value)
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
    case .none:
            self = .none
    case .play:
                        self = .play( try values.decode( CommandWith.self, forKey: .value))
    case .pause:
                        self = .pause( try values.decode( CommandWith.self, forKey: .value))
    case .replay:
                        self = .replay( try values.decode( CommandWith.self, forKey: .value))
}
return
}

public func encode(to encoder: Encoder) throws {
var container = encoder.container(keyedBy: EnumCodingKeys.self)
switch self {
        case .none:
        try container.encode(Cases.none, forKey: .case)
            case .play(let variable):
            try container.encode(Cases.play, forKey: .case)
            try container.encode(variable, forKey: .value)
            case .pause(let variable):
            try container.encode(Cases.pause, forKey: .case)
            try container.encode(variable, forKey: .value)
            case .replay(let variable):
            try container.encode(Cases.replay, forKey: .case)
            try container.encode(variable, forKey: .value)
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
    case .hidden:
            self = .hidden
    case .disabled:
            self = .disabled
    case .enabled:
                        self = .enabled( try values.decode( CommandWith.self, forKey: .value))
}
return
}

public func encode(to encoder: Encoder) throws {
var container = encoder.container(keyedBy: EnumCodingKeys.self)
switch self {
        case .hidden:
        try container.encode(Cases.hidden, forKey: .case)
        case .disabled:
        try container.encode(Cases.disabled, forKey: .case)
            case .enabled(let variable):
            try container.encode(Cases.enabled, forKey: .case)
            try container.encode(variable, forKey: .value)
}
}

}

extension ContentControlsViewController.Props.Thumbnail: Codable {

public enum Cases: String, Codable {
case url
case image
}

        public enum ErrorImage: Swift.Error {
            case encodeRawImage(UIImage)
            case decodeRawImage
        }


public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: EnumCodingKeys.self)
    let `case` = try values.decode(Cases.self, forKey: .case)
    switch `case` {
    case .url:
                        self = .url( try values.decode(URL.self, forKey: .value))
    case .image:
                    throw ErrorImage.decodeRawImage
}
return
}

public func encode(to encoder: Encoder) throws {
var container = encoder.container(keyedBy: EnumCodingKeys.self)
switch self {
            case .url(let variable):
            try container.encode(Cases.url, forKey: .case)
            try container.encode(variable, forKey: .value)
            case .image(let variable):
                throw ErrorImage.encodeRawImage(variable)
}
}

}
