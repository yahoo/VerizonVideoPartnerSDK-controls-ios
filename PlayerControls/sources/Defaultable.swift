//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

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
extension ContentControlsViewController.Props.Seekbar: Defaultable { }
extension ContentControlsViewController.Props.Seeker: Defaultable { }
extension ContentControlsViewController.Props.State: Defaultable { }
extension ContentControlsViewController.Props.Live: Defaultable { }
extension ContentControlsViewController.Props.Camera: Defaultable { }
extension ContentControlsViewController.Props.Angles: Defaultable { }
extension ContentControlsViewController.Props.Error: Defaultable { }
extension ContentControlsViewController.Props.Controls: Defaultable { }
extension ContentControlsViewController.Props.MediaGroupControl: Defaultable { }
extension ContentControlsViewController.Props.Option: Defaultable { }
extension ContentControlsViewController.Props.Playlist: Defaultable { }
