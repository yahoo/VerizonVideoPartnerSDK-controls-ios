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
            public var title = ""
            public var loading = false
            
            public var playbackAction: Playback = .none
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
            }
            
            public var subtitles: Subtitles = .none
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
                
                public var duration: Seconds = 0
                public var currentTime: Seconds = 0
                public var progress: Progress = 0.0
                public var buffered: Progress = 0.0
                
                public var seeker = Seeker()
                
                public struct Seeker {
                    public var seekTo: Action<Seconds>?
                    
                    public var state = State()
                    public struct State {
                        public var start: Action<Progress> = nop
                        public var update: Action<Progress> = nop
                        public var stop: Action<Progress> = nop
                    }
                }
            }
            
            /// This field will be available only when 360 video is active
            public var camera: Camera?
            public struct Camera {
                /// Angles of current camera position - measured in radians.
                public struct Angles {
                    
                    /// zero - center, positive - right part, negatve - left part.
                    public var horizontal: Float = 0.0
                    
                    /// zero - horizon, positive - above horizon, negative - below
                    public var vertical: Float = 0.0
                }
                
                public var angles = Angles()
                public var moveTo: Action<Angles> = nop
            }
            
            /// URL or UIImage for the thumbnail.
            public var thumbnail: Thumbnail?
            public enum Thumbnail {
                case url(URL) //swiftlint:disable:this type_name
                case image(UIImage)
            }
            
            public var sideBarViewHidden = true 
            
            public var error: Error?
            public struct Error {
                public var message = ""
                public var retryAction: Action<Void>?
            }
        }
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
