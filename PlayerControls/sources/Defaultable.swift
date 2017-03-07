//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

protocol Defaultable {
    init()
}

func construct<T: Defaultable>(builder: (inout T) -> Void = { _ in }) -> T {
    var this = T.init()
    builder(&this)
    return this
}

public protocol Constructable {
    static func construct(builder: (inout Self) -> ()) -> Self
}

extension ContentControlsViewController.Props.Controls.Playlist: Constructable {
    public static func construct(builder: (inout ContentControlsViewController.Props.Controls.Playlist) -> ()) -> ContentControlsViewController.Props.Controls.Playlist { return construct(builder: builder) }
}

extension ContentControlsViewController.Props.Controls.Seekbar: Constructable {
    public static func construct(builder: (inout ContentControlsViewController.Props.Controls.Seekbar) -> ()) -> ContentControlsViewController.Props.Controls.Seekbar { return construct(builder: builder) }
}

extension ContentControlsViewController.Props.Controls.Seekbar.Seeker: Constructable {
    public static func construct(builder: (inout ContentControlsViewController.Props.Controls.Seekbar.Seeker) -> ()) -> ContentControlsViewController.Props.Controls.Seekbar.Seeker { return construct(builder: builder) }
}

extension ContentControlsViewController.Props.Controls.Seekbar.Seeker.State: Constructable {
    public static func construct(builder: (inout ContentControlsViewController.Props.Controls.Seekbar.Seeker.State) -> ()) -> ContentControlsViewController.Props.Controls.Seekbar.Seeker.State { return construct(builder: builder) }
}

extension ContentControlsViewController.Props.Controls.Camera: Constructable {
    public static func construct(builder: (inout ContentControlsViewController.Props.Controls.Camera) -> ()) -> ContentControlsViewController.Props.Controls.Camera { return construct(builder: builder) }
}

extension ContentControlsViewController.Props.Controls.Camera.Angles: Constructable {
    public static func construct(builder: (inout ContentControlsViewController.Props.Controls.Camera.Angles) -> ()) -> ContentControlsViewController.Props.Controls.Camera.Angles { return construct(builder: builder) }
}

extension ContentControlsViewController.Props.Controls.Error: Constructable {
    public static func construct(builder: (inout ContentControlsViewController.Props.Controls.Error) -> ()) -> ContentControlsViewController.Props.Controls.Error { return construct(builder: builder) }
}

extension ContentControlsViewController.Props.Controls: Constructable {
    public static func construct(builder: (inout ContentControlsViewController.Props.Controls) -> ()) -> ContentControlsViewController.Props.Controls { return construct(builder: builder) }
}
