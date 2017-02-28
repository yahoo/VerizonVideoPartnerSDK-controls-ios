//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import Foundation

/// Base class for implementing custom content
/// video controls.
public class ContentControlsViewController: UIViewController {
    public var props: Props = .noPlayer {
        didSet {
            guard isViewLoaded else { return }
            view.setNeedsLayout()
        }
    }
    
    public enum Props {
        case noPlayer
        
        case playback(Controls)
        public struct Controls {
            public var title: String
            public var loading: Bool
            
            public var playbackAction: Playback
            public enum Playback {
                case none
                case play(Action<Void>)
                case pause(Action<Void>)
                case replay(Action<Void>)
            }
            
            public var playlist: Playlist?
            public struct Playlist {
                public var next: Action<Void>?
                public var prev: Action<Void>?
                
                public init(next: Action<Void>?, prev: Action<Void>?) {
                    self.next = next
                    self.prev = prev
                }
            }
            
            public var subtitles: Subtitles
            public enum Subtitles {
                case none
                case unavailable
                case available(toggle: Action<Void>, state: State)
                public enum State {
                    case active(text: String?), loading, inactive, error
                }
            }
            
            public var seekbar: Seekbar?
            public struct Seekbar {
                public typealias Seconds = UInt
                public typealias Progress = Double
                
                public var duration: Seconds
                public var currentTime: Seconds
                public var progress: Progress
                public var buffered: Progress
                
                public var seeker: Seeker
                
                public init(duration: Seconds,
                            currentTime: Seconds,
                            progress: Progress,
                            buffered: Progress,
                            seeker: Seeker) {
                    self.duration = duration
                    self.currentTime = currentTime
                    self.progress = progress
                    self.buffered = buffered
                    self.seeker = seeker
                }
                
                public struct Seeker {
                    public var seekTo: Action<Seconds>?
                    
                    public var state: State
                    public struct State {
                        let start: Action<Progress>
                        let update: Action<Progress>
                        let stop: Action<Progress>
                        public init(start: @escaping Action<Progress>,
                                    update: @escaping Action<Progress>,
                                    stop: @escaping Action<Progress>) {
                            self.start = start
                            self.update = update
                            self.stop = stop
                        }
                    }
                }
            }
            
            /// This field will be available only when 360 video is active
            public var camera: Camera?
            public struct Camera {
                /// Angles of current camera position - measured in radians.
                public struct Angles {
                    
                    /// zero - center, positive - right part, negatve - left part.
                    var horizontal: Float
                    
                    /// zero - horizon, positive - above horizon, negative - below
                    var vertical: Float
                    
                    public init(horizontal: Float, vertical: Float) {
                        self.horizontal = horizontal
                        self.vertical = vertical
                    }
                }
                
                public var angles: Angles
                public var moveTo: Action<Angles>
                
                public init(angles: Angles, moveTo: @escaping Action<Angles>) {
                    self.angles = angles
                    self.moveTo = moveTo
                }
            }
            
            /// URL or UIImage for the thumbnail.
            public var thumbnail: Thumbnail?
            public enum Thumbnail {
                case url(URL) //swiftlint:disable:this type_name
                case image(UIImage)
            }
            
            public var sideBarViewHidden: Bool
            
            public var error: Error?
            public struct Error {
                var message: String
                var retryAction: Action<Void>?
            }
            
            public init(title: String,
                        loading: Bool,
                        playbackAction: Playback,
                        playlist: Playlist?,
                        subtitles: Subtitles,
                        seekbar: Seekbar?,
                        camera: Camera?,
                        thumbnail: Thumbnail?,
                        sideBarViewHidden: Bool,
                        error: Error?) {
                self.title = title
                self.loading = loading
                self.playbackAction = playbackAction
                self.playlist = playlist
                self.subtitles = subtitles
                self.seekbar = seekbar
                self.camera = camera
                self.thumbnail = thumbnail
                self.sideBarViewHidden = sideBarViewHidden
                self.error = error
            }
        }
    }
}
