//
//  Autogeneratable.swift
//  PlayerControls
//
//  Created by Andrey Doroshko on 3/6/18.
//  Copyright © 2018 One by AOL : Publishers. All rights reserved.
//

import Foundation

public protocol Prism {}
public protocol AutoCodable {}

extension ContentControlsViewController.Props: Prism, AutoCodable {}
extension ContentControlsViewController.Props.Item: Prism, AutoCodable {}
extension ContentControlsViewController.Props.AirPlay: Prism, AutoCodable {}
extension ContentControlsViewController.Props.External: Prism, AutoCodable {}
extension ContentControlsViewController.Props.External.State: Prism, AutoCodable {}
extension ContentControlsViewController.Props.PictureInPictureControl: Prism, AutoCodable {}
extension ContentControlsViewController.Props.Playback: Prism, AutoCodable {}
extension ContentControlsViewController.Props.Settings: Prism, AutoCodable {}
extension ContentControlsViewController.Props.Subtitles: Prism, AutoCodable {}
extension ContentControlsViewController.Props.Thumbnail: Prism, AutoCodable {}

