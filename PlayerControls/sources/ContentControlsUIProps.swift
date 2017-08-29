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
        
        var durationTextHidden: Bool
        var durationTextLabelText: String
        
        var subtitlesTextLabelHidden: Bool
        var subtitlesTextLabelText: String
        
        var thumbnailImageViewHidden: Bool
        var thumbnailImageUrl: URL?
        
        var errorLabelHidden: Bool
        var errorLabelText: String
        var retryButtonHidden: Bool
        var retryButtonAction: Action<Void>
        
        var pipButtonHidden: Bool
        var pipButtonEnabled: Bool
        var pipButtonAction: Action<Void>
        
        var settingsButtonHidden: Bool
        var settingsButtonEnabled: Bool
        var settingsButtonAction: Action<Void>
        
        var liveIndicationViewIsHidden: Bool
        
        //swiftlint:disable function_body_length
        //swiftlint:disable cyclomatic_complexity
        init(props: Props, controlsViewVisible: Bool) {
            controlsViewHidden = {
                return props.player == nil || !controlsViewVisible
            }()
            
            loading = {
                return props.player?.item.playable?.loading ?? false
            }()
            
            playButtonHidden = {
                return props.player?.item.playable?.playbackAction.play == nil
            }()
            
            playButtonAction = {
                return props.player?.item.playable?.playbackAction.play ?? nop
            }()
            
            pauseButtonHidden = {
                return props.player?.item.playable?.playbackAction.pause == nil
            }()
            
            pauseButtonAction = {
                return props.player?.item.playable?.playbackAction.pause ?? nop
            }()
            
            replayButtonHidden = {
                return props.player?.item.playable?.playbackAction.replay == nil
            }()
            
            replayButtonAction = {
                return props.player?.item.playable?.playbackAction.replay ?? nop
            }()
            
            nextButtonEnabled = {
                return props.player?.playlist?.next != nil
            }()
            
            nextButtonAction = {
                return props.player?.playlist?.next ?? nop
            }()
            
            prevButtonEnabled = {
                return props.player?.playlist?.prev != nil
            }()
            
            prevButtonAction = {
                return props.player?.playlist?.prev ?? nop
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
                return props.player?.item.playable?.seekbar == nil
            }()
            
            durationTextHidden = {
                return props.player?.item.playable?.seekbar == nil
            }()
            
            durationTextLabelText = {
                guard let seekbar = props.player?.item.playable?.seekbar else { return "" }
                return TimeFormatter.string(from: seekbar.duration)
            }()
            
            seekBackButtonHidden = {
                return props.player?.item.playable?.seekbar?.seeker.seekTo == nil
            }()
            
            seekForwardButtonHidden = {
                return props.player?.item.playable?.seekbar?.seeker.seekTo == nil
            }()
            
            seekToSecondsAction = {
                return props.player?.item.playable?.seekbar?.seeker.seekTo ?? nop
            }()
            
            startSeekAction = {
                return props.player?.item.playable?.seekbar?.seeker.state.start ?? nop
            }()
            
            updateSeekAction = {
                return props.player?.item.playable?.seekbar?.seeker.state.update ?? nop
            }()
            
            stopSeekAction = {
                return props.player?.item.playable?.seekbar?.seeker.state.stop ?? nop
            }()
            
            seekerViewCurrentTimeText = {
                guard let seekbar = props.player?.item.playable?.seekbar else { return "" }
                return TimeFormatter.string(from: seekbar.currentTime)
            }()
            
            seekerViewCurrentTime = {
                return props.player?.item.playable?.seekbar?.currentTime ?? 0
            }()
            
            seekerViewProgress = {
                return CGFloat(props.player?.item.playable?.seekbar?.progress ?? 0)
            }()
            
            seekerViewBuffered = {
                return CGFloat(props.player?.item.playable?.seekbar?.buffered ?? 0)
            }()
            
            seekbarPositionedAtBottom = {
                guard let playable = props.player?.item.playable else { return false }
                let hasNoTitle = playable.title.characters.count == 0
                let hasNoSubtitles = playable.legible.external?.external.isNone ?? true
                return hasNoTitle && hasNoSubtitles
            }()
            
            sideBarViewHidden = {
                return props.player?.item.playable?.sideBarViewHidden ?? true
            }()
            
            compasBodyViewHidden = {
                return props.player?.item.playable?.camera == nil
            }()
            
            compasDirectionViewHidden = {
                return props.player?.item.playable?.camera == nil
            }()
            
            compasDirectionViewTransform = {
                guard let camera = props.player?.item.playable?.camera else { return CGAffineTransform.identity }
                return CGAffineTransform(rotationAngle: .init(-camera.angles.horizontal))
            }()
            
            updateCameraAngles = {
                guard let camera = props.player?.item.playable?.camera else { return nop }
                return { translation in
                    var angles = camera.angles
                    angles.horizontal += Float(translation.x) * 0.01
                    angles.vertical += Float(translation.y) * 0.01
                    
                    camera.moveTo(angles)
                }
            }()
            
            resetCameraAngles = {
                guard let camera = props.player?.item.playable?.camera else { return nop }
                return { camera.moveTo(.init()) }
            }()
            
            cameraPanGestureIsEnabled = {
                return props.player?.item.playable?.camera != nil
            }()
            
            videoTitleLabelHidden = {
                return props.player?.item.playable == nil
            }()
            
            videoTitleLabelText = props.player?.item.playable?.title ?? ""
            
            subtitlesTextLabelText = {
                guard let state = props.player?.item.playable?.legible.external?.external.available  else { return "" }
                switch state {
                case .inactive: return ""
                case .loading: return "Loading..."
                case .active(let text): return text ?? ""
                case .error: return "Cannot load subtitles."
                }
            }()
            
            subtitlesTextLabelHidden = {
                return props.player?.item.playable?.legible.external?.external.available?.isInactive ?? false
            }()
            
            thumbnailImageViewHidden = {
                return props.player?.item.playable?.thumbnail?.url == nil
            }()
            
            thumbnailImageUrl = {
                return props.player?.item.playable?.thumbnail?.url
            }()
            
            errorLabelText = {
                let item = props.player?.item
                return item?.nonplayable ?? item?.playable?.error?.message ?? ""
            }()
            
            errorLabelHidden = {
                let item = props.player?.item
                return (item?.nonplayable == nil) && (item?.playable?.error == nil)
            }()
            
            retryButtonHidden = {
                return props.player?.item.playable?.error == nil
            }()
            
            retryButtonAction = {
                return props.player?.item.playable?.error?.retryAction ?? nop
            }()
            
            pipButtonHidden = {
                return props.player?.item.playable?.pictureInPictureControl.isUnsupported ?? true
            }()
            
            pipButtonEnabled = {
                return props.player?.item.playable?.pictureInPictureControl.possible != nil
            }()
            
            pipButtonAction = {
                return props.player?.item.playable?.pictureInPictureControl.possible ?? nop
            }()
            
            settingsButtonHidden = {
                guard
                    case .player(let player) = props,
                    case .playable(let props) = player.item else { return true }
                guard case .hidden = props.settings else { return false }
                return true
            }()
            
            settingsButtonEnabled = {
                guard
                    case .player(let player) = props,
                    case .playable(let props) = player.item,
                    case .enabled = props.settings else { return false }
                return true
            }()
            
            settingsButtonAction = {
                guard
                    case .player(let player) = props,
                    case .playable(let props) = player.item,
                    case .enabled(let action) = props.settings else { return nop }
                return action
            }()
            
            liveIndicationViewIsHidden = {
                guard case .player(let player) = props else { return true }
                guard case .playable(let props) = player.item else { return true }
                
                return props.isLive == false
            }()
        }
    }
}
