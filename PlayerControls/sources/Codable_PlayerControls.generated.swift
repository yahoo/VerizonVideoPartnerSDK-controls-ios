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
