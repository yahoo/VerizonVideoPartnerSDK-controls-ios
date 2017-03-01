//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

protocol Defaultable {
    init()
}

extension Defaultable {
    public static func construct(builder: (inout Self) -> () = { _ in }) -> Self {
        var this = Self.init()
        builder(&this)
        return this
    }
}
