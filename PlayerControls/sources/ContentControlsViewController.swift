//  Copyright © 2017 Oath. All rights reserved.
import Foundation
import CoreMedia
///Generate prism for confirmed enum
public protocol Prism {}
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
    
    public enum Props: Prism {
        case noPlayer
        
        case player(Player)
        
        case pictureInPicture
        
        public struct Player: Codable {
            public var playlist: Playlist?
            public var item: Item = .nonplayable("")
            public var animationsEnabled: Bool = false
            
            public init() {}
        }
        
        public struct Playlist: Codable {
            public var next: Command?
            public var prev: Command?
            
            public init() {}
        }
        
        public enum Item: Prism {
            case playable(Controls)
            case nonplayable(String)
        }
    }
}

extension ContentControlsViewController.Props {
    public typealias Seconds = Int
    
    public struct Controls: Codable {
        
        public var title: String = ""
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
        public var legible: Subtitles = .internal(nil)
        public var audible: MediaGroupControl?
        public var settings: Settings = .disabled
        public var airplay: AirPlay = .enabled

        public init() {}
    }
    
    public struct Angles: Codable {
        /// zero - center, positive - right part, negative - left part.
        public var horizontal: Float = 0.0
        /// zero - horizon, positive - above horizon, negative - below
        public var vertical: Float = 0.0
        
        public init() {}
    }
    
    public enum AirPlay: Prism {
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
    
    public enum External: Prism {
        case none
        case unavailable
        case available(state: State)
        
        public enum State: Prism {
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
    
    public enum PictureInPictureControl: Prism {
        case unsupported
        case impossible
        case possible(Command)
    }
    
    public enum Playback: Prism {
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
        public var seekTo: CommandWith<Seconds>?
        public var state: State = State()
        
        public init() {}
    }
    
    public enum Subtitles: Prism {
        case `internal`(MediaGroupControl?)
        case external(external: External, control: MediaGroupControl)
    }
    
    public enum Settings: Prism {
        case hidden
        case disabled
        case enabled(Command)
    }
    
    public enum Thumbnail: Prism {
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
