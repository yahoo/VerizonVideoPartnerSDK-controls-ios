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

extension ContentControlsViewController.Props.Player: Defaultable { }
extension ContentControlsViewController.Props.Player.Item.Controls.Seekbar: Defaultable { }
extension ContentControlsViewController.Props.Player.Item.Controls.Seekbar.Seeker: Defaultable { }
extension ContentControlsViewController.Props.Player.Item.Controls.Seekbar.Seeker.State: Defaultable { }
extension ContentControlsViewController.Props.Player.Item.Controls.Camera: Defaultable { }
extension ContentControlsViewController.Props.Player.Item.Controls.Camera.Angles: Defaultable { }
extension ContentControlsViewController.Props.Player.Item.Controls.Error: Defaultable { }
extension ContentControlsViewController.Props.Player.Item.Controls: Defaultable { }
extension ContentControlsViewController.Props.Player.Item.Controls.MediaGroupControl: Defaultable { }
extension ContentControlsViewController.Props.Player.Item.Controls.MediaGroupControl.Option: Defaultable { }
extension ContentControlsViewController.Props.Player.Playlist: Defaultable { }
