//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import Foundation

extension DefaultControlsViewController {
    struct UIProps {
        var loading: Bool
        var controlsViewHidden: Bool
        
        var playButtonHidden: Bool
        var playButtonAction: Action<Void>
        
        var pauseButtonHidden: Bool
        var pauseButtonAction: Action<Void>
        
        var replayButtonHidden: Bool
        var replayButtonAction: Action<Void>
        
        var nextButtonHidden: Bool
        var nextButtonAction: Action<Void>
        var nextButtonEnabled: Bool
        
        var prevButtonHidden: Bool
        var prevButtonAction: Action<Void>
        var prevButtonEnabled: Bool
        
        var seekerViewHidden: Bool
        var seekerViewCurrentTimeText: String
        var seekerViewCurrentTime: UInt
        var seekerViewProgress: CGFloat
        var seekerViewBuffered: CGFloat
        var startSeekAction: Action<Double>
        var updateSeekAction: Action<Double>
        var stopSeekAction: Action<Double>
        var seekToSecondsAction: Action<UInt>
        var seekBackButtonHidden: Bool
        var seekForwardButtonHidden: Bool
        var seekbarPositionedAtBottom: Bool
        
        var sideBarViewHidden: Bool
        
        var compasBodyViewHidden: Bool
        var compasDirectionViewHidden: Bool
        var compasDirectionViewTransform: CGAffineTransform
        var updateCameraAngles: Action<CGPoint>
        var resetCameraAngles: Action<Void>
        var cameraPanGestureIsEnabled: Bool
        
        var videoTitleLabelHidden: Bool
        var videoTitleLabelText: String
        
        var durationTextLabelText: String
        
        var subtitlesButtonHidden: Bool
        var subtitlesButtonEnabled: Bool
        var subtitlesButtonSelected: Bool
        var subtitlesTextLabelHidden: Bool
        var subtitlesTextLabelText: String
        var subtitlesToggleAction: Action<Void>
        
        var thumbnailImageViewHidden: Bool
        var thumbnailImageUrl: URL?
        
        var errorLabelHidden: Bool
        var errorLabelText: String
        var retryButtonHidden: Bool
        var retryButtonAction: Action<Void>
        
        //swiftlint:disable function_body_length
        //swiftlint:disable cyclomatic_complexity
        init(props: Props, controlsViewVisible: Bool) {
            controlsViewHidden = {
                guard case .player = props else { return true }
                return !controlsViewVisible
            }()
            
            loading = {
                guard case .player(let player) = props else { return false }
                guard case .playable(let props) = player.item else { return false }
                return props.loading
            }()
            
            playButtonHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable(let props) = player.item else { return true }
                guard case .play = props.playbackAction else { return true }
                return false
            }()
            
            playButtonAction = {
                guard case .player(let player) = props else { return nop }
                guard case .playable(let props) = player.item else { return nop }
                guard case .play(let action) = props.playbackAction else { return nop }
                return action
            }()
            
            pauseButtonHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable(let props) = player.item else { return true }
                guard case .pause = props.playbackAction else { return true }
                return false
            }()
            
            pauseButtonAction = {
                guard case .player(let player) = props else { return nop }
                guard case .playable(let props) = player.item else { return nop }
                guard case .pause(let action) = props.playbackAction else { return nop }
                return action
            }()
            
            replayButtonHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable(let props) = player.item else { return true }
                guard case .replay = props.playbackAction else { return true }
                return false
            }()
            
            replayButtonAction = {
                guard case .player(let player) = props else { return nop }
                guard case .playable(let props) = player.item else { return nop }
                guard case .replay(let action) = props.playbackAction else { return nop }
                return action
            }()
            
            nextButtonEnabled = {
                guard case .player(let player) = props else { return false }
                return player.playlist?.next != nil
            }()
            
            nextButtonAction = {
                guard case .player(let player) = props else { return nop }
                return player.playlist?.next ?? nop
            }()
            
            prevButtonEnabled = {
                guard case .player(let player) = props else { return false }
                return player.playlist?.prev != nil
            }()
            
            prevButtonAction = {
                guard case .player(let player) = props else { return nop }
                return player.playlist?.prev ?? nop
            }()
            
            let nextButtonDisabled = !nextButtonEnabled
            let prevButtonDisabled = !prevButtonEnabled
            
            prevButtonHidden = {
                return nextButtonDisabled && prevButtonDisabled
            }()
            
            nextButtonHidden = {
                return nextButtonDisabled && prevButtonDisabled
            }()
            
            seekerViewHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable(let props) = player.item else { return true }
                return props.seekbar == nil
            }()
            
            durationTextLabelText = {
                guard case .player(let player) = props else { return "" }
                guard case .playable(let props) = player.item else { return "" }
                guard let seekbar = props.seekbar else { return "" }
                return TimeFormatter.string(from: seekbar.duration)
            }()
            
            seekBackButtonHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable(let props) = player.item else { return true }
                return props.seekbar?.seeker.seekTo == nil
            }()
            
            seekForwardButtonHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable(let props) = player.item else { return true }
                return props.seekbar?.seeker.seekTo == nil
            }()
            
            seekToSecondsAction = {
                guard case .player(let player) = props else { return nop }
                guard case .playable(let props) = player.item else { return nop }
                guard let action = props.seekbar?.seeker.seekTo else { return nop }
                return action
            }()
            
            startSeekAction = {
                guard case .player(let player) = props else { return nop }
                guard case .playable(let props) = player.item else { return nop }
                guard let seekbar = props.seekbar else { return nop }
                return seekbar.seeker.state.start
            }()
            
            updateSeekAction = {
                guard case .player(let player) = props else { return nop }
                guard case .playable(let props) = player.item else { return nop }
                guard let seekbar = props.seekbar else { return nop }
                return seekbar.seeker.state.update
            }()
            
            stopSeekAction = {
                guard case .player(let player) = props else { return nop }
                guard case .playable(let props) = player.item else { return nop }
                guard let seekbar = props.seekbar else { return nop }
                return seekbar.seeker.state.stop
            }()
            
            seekerViewCurrentTimeText = {
                guard case .player(let player) = props else { return "" }
                guard case .playable(let props) = player.item else { return "" }
                guard let seekbar = props.seekbar else { return "" }
                return TimeFormatter.string(from: seekbar.currentTime)
            }()
            
            seekerViewCurrentTime = {
                guard case .player(let player) = props else { return 0 }
                guard case .playable(let props) = player.item else { return 0 }
                guard let seekbar = props.seekbar else { return 0 }
                return seekbar.currentTime
            }()
            
            seekerViewProgress = {
                guard case .player(let player) = props else { return 0 }
                guard case .playable(let props) = player.item else { return 0 }
                guard let seekbar = props.seekbar else { return 0 }
                return CGFloat(seekbar.progress)
            }()
            
            seekerViewBuffered = {
                guard case .player(let player) = props else { return 0 }
                guard case .playable(let props) = player.item else { return 0 }
                guard let seekbar = props.seekbar else { return 0 }
                return CGFloat(seekbar.buffered)
            }()
            
            seekbarPositionedAtBottom = {
                guard case .player(let player) = props else { return false }
                guard case .playable(let props) = player.item else { return false }
                let hasNoTitle = props.title.characters.count == 0
                let hasNoSubtitles: Bool = {
                    if case .none = props.subtitles {
                        return true
                    } else {
                        return false
                    }
                }()
                
                return hasNoTitle && hasNoSubtitles
            }()
            
            sideBarViewHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable(let props) = player.item else { return true }
                return props.sideBarViewHidden
            }()
            
            compasBodyViewHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable(let props) = player.item else { return true }
                guard props.camera != nil else { return true }
                return false
            }()
            
            compasDirectionViewHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable(let props) = player.item else { return true }
                guard props.camera != nil else { return true }
                return false
            }()
            
            compasDirectionViewTransform = {
                guard case .player(let player) = props else { return CGAffineTransform.identity }
                guard case .playable(let props) = player.item else { return CGAffineTransform.identity }
                guard let camera = props.camera else { return CGAffineTransform.identity }
                return CGAffineTransform(rotationAngle: .init(-camera.angles.horizontal))
            }()
            
            updateCameraAngles = {
                guard case .player(let player) = props else { return nop }
                guard case .playable(let props) = player.item else { return nop }
                guard let camera = props.camera else { return nop }
                return { translation in
                    var angles = camera.angles
                    angles.horizontal += Float(translation.x) * 0.01
                    angles.vertical += Float(translation.y) * 0.01
                    
                    camera.moveTo(angles)
                }
            }()
            
            resetCameraAngles = {
                guard case .player(let player) = props else { return nop }
                guard case .playable(let props) = player.item else { return nop }
                guard let camera = props.camera else { return nop }
                return { camera.moveTo(.init()) }
            }()
            
            cameraPanGestureIsEnabled = {
                guard case .player(let player) = props else { return false }
                guard case .playable(let props) = player.item else { return false }
                return props.camera != nil
            }()
            
            videoTitleLabelHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable = player.item else { return true }
                return false
            }()
            
            videoTitleLabelText = {
                guard case .player(let player) = props else { return "" }
                guard case .playable(let props) = player.item else { return "" }
                return props.title 
            }()
            
            subtitlesButtonHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable(let props) = player.item else { return true }
                guard case .none = props.subtitles else { return false }
                return true
            }()
            
            subtitlesButtonEnabled = {
                guard case .player(let player) = props else { return false }
                guard case .playable(let props) = player.item else { return false }
                guard case .available = props.subtitles else { return false }
                return true
            }()
            
            subtitlesButtonSelected = {
                guard case .player(let player) = props else { return false }
                guard case .playable(let props) = player.item else { return false }
                guard case .available(let subtitlesProps) = props.subtitles else { return false }
                guard case .inactive = subtitlesProps.state else { return true }
                return false
            }()
            
            subtitlesTextLabelText = {
                guard case .player(let player) = props else { return "" }
                guard case .playable(let props) = player.item else { return "" }
                guard case .available(let subtitlesProps) = props.subtitles else { return "" }
                switch subtitlesProps.state {
                case .inactive: return ""
                case .loading: return "Loading..."
                case .active(let text): return text ?? ""
                case .error: return "Cannot load subtitles."
                }
            }()
            
            subtitlesTextLabelHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable(let props) = player.item else { return true }
                guard case .available(let subtitlesProps) = props.subtitles else { return true }
                guard case .inactive = subtitlesProps.state else { return false }
                return true
            }()
            
            subtitlesToggleAction = {
                guard case .player(let player) = props else { return nop }
                guard case .playable(let props) = player.item else { return nop }
                guard case .available(let subtitlesProps) = props.subtitles else { return nop }
                return subtitlesProps.toggle
            }()
            
            thumbnailImageViewHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable(let props) = player.item else { return true }
                guard case .some(.url) = props.thumbnail else { return
                    true }
                return false
            }()
            
            thumbnailImageUrl = {
                guard case .player(let player) = props else { return nil }
                guard case .playable(let props) = player.item else { return nil }
                guard case .some(.url(let url)) = props.thumbnail else { return
                    nil }
                return url
            }()
            
            errorLabelText = {
                guard case .player(let player) = props else { return "" }
                switch player.item {
                case .playable(let props): return props.error?.message ?? ""
                case .nonplayable(let reason): return reason
                }
            }()
            
            errorLabelHidden = {
                guard case .player(let player) = props else { return true }
                switch player.item {
                case .playable(let props): return props.error == nil
                case .nonplayable: return false
                }
            }()
            
            retryButtonHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable(let props) = player.item else { return true }
                return props.error == nil
            }()
            
            retryButtonAction = {
                guard case .player(let player) = props else { return nop }
                guard case .playable(let props) = player.item else { return nop }
                return props.error?.retryAction ?? nop
            }()
        }
    }
}
