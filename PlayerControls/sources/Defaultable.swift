//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

public protocol Defaultable {
    init()
}

extension Defaultable {
    public init(builder: (inout Self) -> Void) {
        self.init()
        builder(&self)
    }
}

extension ContentControlsViewController.Props.Controls.Playlist: Defaultable { }
extension ContentControlsViewController.Props.Controls.Seekbar: Defaultable { }
extension ContentControlsViewController.Props.Controls.Seekbar.Seeker: Defaultable { }
extension ContentControlsViewController.Props.Controls.Seekbar.Seeker.State: Defaultable { }
extension ContentControlsViewController.Props.Controls.Camera: Defaultable { }
extension ContentControlsViewController.Props.Controls.Camera.Angles: Defaultable { }
extension ContentControlsViewController.Props.Controls.Error: Defaultable { }
extension ContentControlsViewController.Props.Controls: Defaultable { }
