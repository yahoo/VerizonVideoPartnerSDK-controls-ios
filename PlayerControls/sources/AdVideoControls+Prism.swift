//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import Foundation

/// Prism extension for advertisement content video controls
public extension AdVideoControls.Props.MainAction {
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
}
