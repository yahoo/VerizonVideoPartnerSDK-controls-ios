//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

fileprivate enum EnumCodingKeys: String, CodingKey { case `case`, value }

extension AdVideoControls.Props.AdSkipState: Codable {
    
    public enum Cases: String, Codable {
        case unavailable
        case available
        case awaiting
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: EnumCodingKeys.self)
        let `case` = try values.decode(Cases.self, forKey: .case)
        switch `case` {
        case .unavailable:
            self = .unavailable
        case .available:
            self = .available(try values.decode(Command.self, forKey: .value))
        case .awaiting:
            self = .awaiting(try values.decode(Int.self, forKey: .value))
        }
        return
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EnumCodingKeys.self)
        switch self {
        case .unavailable:
            try container.encode(Cases.unavailable, forKey: .case)
        case .available(let variable):
            try container.encode(Cases.available, forKey: .case)
            try container.encode(variable, forKey: .value)
        case .awaiting(let variable):
            try container.encode(Cases.awaiting, forKey: .case)
            try container.encode(variable, forKey: .value)
        }
    }
    
}

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
            self = .play(try values.decode(Command.self, forKey: .value))
        case .pause:
            self = .pause(try values.decode(Command.self, forKey: .value))
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
