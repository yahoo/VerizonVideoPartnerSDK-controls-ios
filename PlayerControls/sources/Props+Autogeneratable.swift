//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

extension ContentControlsViewController.Props: Prism, AutoCodable {}
extension ContentControlsViewController.Props.Item: Prism, AutoCodable {}
extension ContentControlsViewController.Props.AirPlay: Prism, AutoCodable {}
extension ContentControlsViewController.Props.External: Prism, AutoCodable {}
extension ContentControlsViewController.Props.External.State: Prism, AutoCodable {}
extension ContentControlsViewController.Props.PictureInPictureControl: Prism, AutoCodable {}
extension ContentControlsViewController.Props.Playback: Prism, AutoCodable {}
extension ContentControlsViewController.Props.Settings: Prism, AutoCodable {}
extension ContentControlsViewController.Props.Thumbnail: Prism, AutoCodable {}

