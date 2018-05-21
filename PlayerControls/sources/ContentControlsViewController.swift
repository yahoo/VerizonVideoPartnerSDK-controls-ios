//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation
import CoreMedia
import SafariServices
/// Base class for implementing custom content
/// video controls.
open class ContentControlsViewController: UIViewController {
    public weak var settingsViewController: SettingsViewController?
    public var props: Props = .noPlayer {
        didSet {
            guard isViewLoaded else { return }
            settingsViewController?.props = ContentControlsViewController.settingProps(from: props)
            view.setNeedsLayout()
        }
    }
    
    public enum Props {
        case noPlayer
        
        case player(Player)
        
        case pictureInPicture
        
        public struct Player: Codable {
            public var playlist: Playlist?
            public var item: Item = .nonplayable("")
            
            public init() {}
        }
        
        public struct Playlist: Codable {
            public var next: Command?
            public var prev: Command?
            
            public init() {}
        }
        
        public enum Item {
            case playable(ContentControlsViewController.Props.Controls)
            case nonplayable(String)
        }
    }
}

extension ContentControlsViewController.Props {
    public typealias Seconds = Int
    
    public struct Controls: Codable {
        
        public var title: String = ""
        public var animationsEnabled: Bool = false
        public var loading: Bool = false
        public var playbackAction: Playback = .none
        public var live: Live = Live()
        public var seekbar: Seekbar?
        /// This field will be available only when 360 video is active
        public var camera: Camera?
        /// URL or UIImage for the thumbnail.
        public var thumbnail: Thumbnail?
        public var sideBarViewHidden: Bool = true
        public var error: Error?
        public var pictureInPictureControl: PictureInPictureControl = .impossible
        public var legible: MediaGroupControl?
        public var audible: MediaGroupControl?
        public var settings: Settings = .disabled
        public var airplay: AirPlay = .enabled
        public var contentFullScreen: Command = .nop
        public var brandedContent: BrandedContent?
        
        public init() {}
    }
    
    public struct Angles: Codable {
        /// zero - center, positive - right part, negative - left part.
        public var horizontal: Float = 0.0
        /// zero - horizon, positive - above horizon, negative - below
        public var vertical: Float = 0.0
        
        public init() {}
    }
    
    public enum AirPlay {
        case hidden
        case enabled
        case active
    }
    
    public struct Camera: Codable {
        /// Angles of current camera position - measured in radians.
        public var angles: Angles = Angles()
        public var moveTo: CommandWith<Angles> = .nop
        
        public init() {}
    }
    
    public enum External {
        case none
        case unavailable
        case available(state: State)
        
        public enum State {
            case active(text: String?), loading, inactive, error
        }
    }
    
    public struct Error: Codable {
        public var message: String = ""
        public var retryAction: Command?
        
        public init() {}
    }
    
    public struct Live: Codable {
        public var isHidden: Bool = true
        public var dotColor: Color?
        
        public init() {}
    }
    
    public struct MediaGroupControl: Codable {
        public var options: [Option] = []
        
        public init() {}
    }
    
    public struct Option: Codable {
        public var name: String = ""
        public var selected: Bool = false
        public var select: Command = .nop
        
        public init() {}
    }
    
    public enum PictureInPictureControl {
        case unsupported
        case impossible
        case possible(Command)
    }
    
    public enum Playback {
        case none
        case play(Command)
        case pause(Command)
        case replay(Command)
    }
    
    public struct Seekbar: Codable {
        public var duration: Seconds = 0
        public var currentTime: Seconds = 0
        public var progress: Progress = 0
        public var buffered: Progress = 0
        public var seeker: Seeker = Seeker()
        
        public init() {}
    }
    
    public struct State: Codable {
        public var start: CommandWith<Progress> = .nop
        public var update: CommandWith<Progress> = .nop
        public var stop: CommandWith<Progress> = .nop
        
        public init() {}
    }
    
    public struct Seeker: Codable {
        public var cuePoints: [Progress] = []
        public var seekTo: CommandWith<Seconds>?
        public var state: State = State()
        
        public init() {}
    }
    
    public enum Settings {
        case hidden
        case disabled
        case enabled(Command)
    }
    
    public enum Thumbnail {
        case url(URL) //swiftlint:disable:this type_name
        case image(UIImage)
    }
    
    public struct Progress: Codable {
        public typealias NativeValue = CGFloat
        
        public let value: NativeValue
        public init(_ value: NativeValue) {
            self.value = min(max(value.isNaN ? 0 : value, 0), 1)
        }
    }
    
    public struct BrandedContent: Codable {
        public var advertisementText: String = ""
        public var action: CommandWith<SFSafariViewControllerDelegate>? = nil
        
        public init() {}
    }
}

extension ContentControlsViewController.Props.Progress: ExpressibleByIntegerLiteral {
    public typealias IntegerLiteralType = Int
    public init(integerLiteral value: IntegerLiteralType) {
        self.init(NativeValue(value))
    }
}

extension ContentControlsViewController.Props.Progress: ExpressibleByFloatLiteral {
    public typealias FloatLiteralType = Double
    public init(floatLiteral value: FloatLiteralType) {
        self.init(NativeValue(value))
    }
}

extension ContentControlsViewController: SFSafariViewControllerDelegate {
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        props.player?.item.playable?.brandedContent?.action?.perform(with: self)
    }
}
