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
        
        public struct Player {
            public var playlist: Playlist?
            public var item: Item = .nonplayable("")
            
            public init() {}
        }
        
        public struct Playlist  {
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
    
    public struct Controls {
        
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
    
    public struct Angles {
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
    
    public struct Camera {
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
    
    public struct Error {
        public var message: String = ""
        public var retryAction: Command?
        
        public init() {}
    }
    
    public struct Live {
        public var isHidden: Bool = true
        public var dotColor: Color?
        
        public init() {}
    }
    
    public struct MediaGroupControl {
        public var options: [Option] = []
        
        public init() {}
    }
    
    public struct Option {
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
    
    public struct Seekbar {
        public var duration: Seconds = 0
        public var currentTime: Seconds = 0
        public var progress: Progress = 0
        public var buffered: Progress = 0
        public var seeker: Seeker = Seeker()
        public var seekbarColors: SeekbarColors?
        
        public init() {}
    }
    public struct SeekbarColors {
        public var currentTimeColor: Color?
        public var progressColor: Color?
        public var bufferedColor: Color?
        public var fillerColor: Color?
        public var cuePointsColor: Color?
        public var dragControlColor: Color?
        
        public init() {}
    }
    
    public struct State {
        public var start: CommandWith<Progress> = .nop
        public var update: CommandWith<Progress> = .nop
        public var stop: CommandWith<Progress> = .nop
        
        public init() {}
    }
    
    public struct Seeker {
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
    
    public struct Progress {
        public typealias NativeValue = CGFloat
        
        public let value: NativeValue
        public init(_ value: NativeValue) {
            self.value = min(max(value.isNaN ? 0 : value, 0), 1)
        }
    }
    
    public struct BrandedContent {
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

extension ContentControlsViewController.Props.Player {
    public init(playlist: ContentControlsViewController.Props.Playlist?,
                item: ContentControlsViewController.Props.Item) {
        self.playlist = playlist
        self.item = item
    }
}

extension ContentControlsViewController.Props.Playlist {
    public init(next: Command?, prev: Command?) {
        self.next = next
        self.prev = prev
    }
}

extension ContentControlsViewController.Props.Controls {
    public init(airplay: ContentControlsViewController.Props.AirPlay,
                audible: ContentControlsViewController.Props.MediaGroupControl?,
                camera: ContentControlsViewController.Props.Camera?,
                error: ContentControlsViewController.Props.Error?,
                legible: ContentControlsViewController.Props.MediaGroupControl?,
                live: ContentControlsViewController.Props.Live,
                loading: Bool,
                pictureInPictureControl: ContentControlsViewController.Props.PictureInPictureControl,
                playbackAction: ContentControlsViewController.Props.Playback,
                seekbar: ContentControlsViewController.Props.Seekbar?,
                settings: ContentControlsViewController.Props.Settings,
                sideBarViewHidden: Bool,
                thumbnail: ContentControlsViewController.Props.Thumbnail?,
                title: String,
                animationsEnabled: Bool,
                contentFullScreen: Command,
                brandedContent: ContentControlsViewController.Props.BrandedContent?) {
        self.contentFullScreen = contentFullScreen
        self.animationsEnabled = animationsEnabled
        self.title = title
        self.thumbnail = thumbnail
        self.sideBarViewHidden = sideBarViewHidden
        self.settings = settings
        self.seekbar = seekbar
        self.playbackAction = playbackAction
        self.pictureInPictureControl = pictureInPictureControl
        self.loading = loading
        self.live = live
        self.legible = legible
        self.camera = camera
        self.error = error
        self.audible = audible
        self.airplay = airplay
        self.brandedContent = brandedContent
    }
}

extension ContentControlsViewController.Props.Angles {
    public init(horizontal: Float, vertical: Float) {
        self.horizontal = horizontal
        self.vertical = vertical
    }
}

extension ContentControlsViewController.Props.Camera {
    public init(angles: ContentControlsViewController.Props.Angles, moveTo: CommandWith<ContentControlsViewController.Props.Angles>) {
        self.angles = angles
        self.moveTo = moveTo
    }
}

extension ContentControlsViewController.Props.Error {
    public init(message: String, retryAction: Command?) {
        self.message = message
        self.retryAction = retryAction
    }
}

extension ContentControlsViewController.Props.Live {
    public init(isHidden: Bool, dotColor: UIColor?) {
        self.isHidden = isHidden
        guard let color = dotColor else { self.dotColor = nil; return }
        self.dotColor = Color(color)
    }
}

extension ContentControlsViewController.Props.MediaGroupControl {
    public init(options: [ContentControlsViewController.Props.Option]) {
        self.options = options
    }
}

extension ContentControlsViewController.Props.Option {
    public init(name: String ,
                selected: Bool,
                select: Command) {
        self.name = name
        self.selected = selected
        self.select = select
    }
}

extension ContentControlsViewController.Props.Seekbar {
    public init(duration: ContentControlsViewController.Props.Seconds,
                currentTime: ContentControlsViewController.Props.Seconds,
                progress: ContentControlsViewController.Props.Progress,
                buffered: ContentControlsViewController.Props.Progress,
                seeker: ContentControlsViewController.Props.Seeker,
                seekbarColors: ContentControlsViewController.Props.SeekbarColors? = nil) {
        self.duration = duration
        self.currentTime = currentTime
        self.progress = progress
        self.buffered = buffered
        self.seeker = seeker
        self.seekbarColors = seekbarColors
    }
}
extension ContentControlsViewController.Props.SeekbarColors {
    public init(currentTimeColor: Color? = nil,
                progressColor: Color? = nil,
                bufferedColor: Color? = nil,
                fillerColor: Color? = nil,
                cuePointsColor: Color? = nil,
                dragControlColor: Color? = nil) {
        self.currentTimeColor = currentTimeColor
        self.progressColor = progressColor
        self.bufferedColor = bufferedColor
        self.fillerColor = fillerColor
        self.cuePointsColor = cuePointsColor
        self.dragControlColor = dragControlColor
    }
}

extension ContentControlsViewController.Props.State {
    public init(start: CommandWith<ContentControlsViewController.Props.Progress>,
                update: CommandWith<ContentControlsViewController.Props.Progress>,
                stop: CommandWith<ContentControlsViewController.Props.Progress>) {
        self.start = start
        self.update = update
        self.stop = stop
    }
}

extension ContentControlsViewController.Props.Seeker {
    public init(cuePoints: [ContentControlsViewController.Props.Progress], seekTo: CommandWith<ContentControlsViewController.Props.Seconds>?, state: ContentControlsViewController.Props.State) {
        self.cuePoints = cuePoints
        self.seekTo = seekTo
        self.state = state
    }
}

