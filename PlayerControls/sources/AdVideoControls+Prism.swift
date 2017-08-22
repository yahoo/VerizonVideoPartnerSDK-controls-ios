//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import Foundation

/// Prism extension for advertisement content video controls
public extension AdVideoControls.Props.MainAction {
    public var play: Action<Void>? {
        guard case let .play(play) = self else { return nil }
        return play
    }
    
    public var pause: Action<Void>? {
        guard case let .pause(pause) = self else { return nil }
        return pause
    }
}
