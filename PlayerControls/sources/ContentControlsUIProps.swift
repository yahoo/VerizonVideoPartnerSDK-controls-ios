//  Copyright © 2017 Oath. All rights reserved.
import Foundation

extension DefaultControlsViewController {
    struct UIProps {
        var loading: Bool
        var controlsViewHidden: Bool
        
        var playButtonHidden: Bool
        var playButtonAction: Command
        
        var pauseButtonHidden: Bool
        var pauseButtonAction: Command
        
        var replayButtonHidden: Bool
        var replayButtonAction: Command
        
        var nextButtonHidden: Bool
        var nextButtonAction: Command
        var nextButtonEnabled: Bool
        
        var prevButtonHidden: Bool
        var prevButtonAction: Command
        var prevButtonEnabled: Bool
        
        var seekerViewHidden: Bool
        var seekerViewCurrentTimeText: String
        var seekerViewCurrentTime: Int
        var seekerViewProgress: CGFloat
        var seekerViewBuffered: CGFloat
        var seekerViewAccessibilityLabel: String
        var seekerViewCuePoints: [Props.Progress.NativeValue]
        var startSeekAction: CommandWith<Props.Progress>
        var updateSeekAction: CommandWith<Props.Progress>
        var stopSeekAction: CommandWith<Props.Progress>
        var seekToSecondsAction: CommandWith<Int>
        var seekBackButtonHidden: Bool
        var seekForwardButtonHidden: Bool
        var seekbarPositionedAtBottom: Bool
        
        var sideBarViewHidden: Bool
        
        var compasBodyViewHidden: Bool
        var compasDirectionViewHidden: Bool
        var compasDirectionViewTransform: CGAffineTransform
        var updateCameraAngles: CommandWith<CGPoint>
        var resetCameraAngles: Command
        var cameraPanGestureIsEnabled: Bool
        var compassViewBelowLive: Bool
        
        var videoTitleLabelHidden: Bool
        var videoTitleLabelText: String
        
        var durationTextLabelAccessibilityLabel: String
        var durationTextHidden: Bool
        var durationTextLabelText: String
        
        var subtitlesTextLabelHidden: Bool
        var subtitlesTextLabelText: String
        
        var thumbnailImageViewHidden: Bool
        var thumbnailImageUrl: URL?
        var thumbnailImage: UIImage?
        
        var errorLabelHidden: Bool
        var errorLabelText: String
        var retryButtonHidden: Bool
        var retryButtonAction: Command
        
        var pipButtonHidden: Bool
        var pipButtonEnabled: Bool
        var pipButtonAction: Command
        
        var settingsButtonHidden: Bool
        var settingsButtonEnabled: Bool
        var settingsButtonAction: Command
        
        var airplayActiveLabelHidden: Bool
        var airplayButtonHidden: Bool
        
        var liveIndicationViewIsHidden: Bool
        var liveDotColor: UIColor?
        
        //swiftlint:disable function_body_length
        //swiftlint:disable cyclomatic_complexity
        init(props: Props, controlsViewVisible: Bool) {
            controlsViewHidden = {
                let isPlayerAbsent = props.player == nil
                let isControlsViewHidden = !controlsViewVisible
                let isAirPlayInactive = !(props.player?.item.playable?.airplay.isActive ?? false)
                
                return isPlayerAbsent || (isControlsViewHidden && isAirPlayInactive)
            }()
            
            loading = props.player?.item.playable?.loading ?? false
            
            playButtonHidden = props.player?.item.playable?.playbackAction.play == nil
            
            playButtonAction = props.player?.item.playable?.playbackAction.play ?? .nop
            
            pauseButtonHidden = props.player?.item.playable?.playbackAction.pause == nil
            
            pauseButtonAction = props.player?.item.playable?.playbackAction.pause ?? .nop
            
            replayButtonHidden = props.player?.item.playable?.playbackAction.replay == nil
            
            replayButtonAction = props.player?.item.playable?.playbackAction.replay ?? .nop
            
            nextButtonEnabled = props.player?.playlist?.next != nil
            
            nextButtonAction = props.player?.playlist?.next ?? .nop
            
            prevButtonEnabled = props.player?.playlist?.prev != nil
            
            prevButtonAction = props.player?.playlist?.prev ?? .nop
            
            let nextButtonDisabled = !nextButtonEnabled
            let prevButtonDisabled = !prevButtonEnabled
            
            prevButtonHidden = nextButtonDisabled && prevButtonDisabled
            
            nextButtonHidden = nextButtonDisabled && prevButtonDisabled
            
            seekerViewHidden = props.player?.item.playable?.seekbar == nil
            
            durationTextLabelAccessibilityLabel = {
                guard let duration = props.player?.item.playable?.seekbar?.duration else { return "" }
                return TimeFormatter.voiceOverReadable(from: duration) ?? ""
            }()
            
            durationTextHidden = props.player?.item.playable?.seekbar == nil
            
            durationTextLabelText = {
                guard let seekbar = props.player?.item.playable?.seekbar else { return "" }
                return TimeFormatter.string(from: seekbar.duration)
            }()
            
            seekBackButtonHidden = props.player?.item.playable?.seekbar?.seeker.seekTo == nil
            
            seekForwardButtonHidden = props.player?.item.playable?.seekbar?.seeker.seekTo == nil
            
            seekToSecondsAction = props.player?.item.playable?.seekbar?.seeker.seekTo ?? .nop
            
            seekerViewAccessibilityLabel = {
                guard let duration = props.player?.item.playable?.seekbar?.duration else { return "" }
                guard let currentTime = props.player?.item.playable?.seekbar?.currentTime else { return "" }
                guard let currentTimeString = TimeFormatter.voiceOverReadable(from: currentTime) else { return "" }
                guard let durationString =  TimeFormatter.voiceOverReadable(from: duration) else { return "" }
                return "Current position \(currentTimeString) of \(durationString))"
            }()
            
            startSeekAction = props.player?.item.playable?.seekbar?.seeker.state.start ?? .nop
            
            updateSeekAction = props.player?.item.playable?.seekbar?.seeker.state.update ?? .nop
            
            stopSeekAction = props.player?.item.playable?.seekbar?.seeker.state.stop ?? .nop
            
            seekerViewCurrentTimeText = {
                guard let seekbar = props.player?.item.playable?.seekbar else { return "" }
                return TimeFormatter.string(from: seekbar.currentTime)
            }()
            
            seekerViewCurrentTime = props.player?.item.playable?.seekbar?.currentTime ?? 0
            
            seekerViewProgress = CGFloat(props.player?.item.playable?.seekbar?.progress.value ?? 0)
            
            seekerViewBuffered = CGFloat(props.player?.item.playable?.seekbar?.buffered.value ?? 0)
            
            seekerViewCuePoints = props.player?.item.playable?.seekbar?.seeker.cuePoints.map { $0.value }  ?? []
            
            seekbarPositionedAtBottom = {
                guard let playable = props.player?.item.playable else { return false }
                let hasNoTitle = playable.title.count == 0
                let hasNoSettings = playable.settings.isHidden
                let hasNoPipButton = playable.pictureInPictureControl.isUnsupported
                let hasNoAirplayButton = playable.airplay.isHidden
                return hasNoTitle && hasNoSettings && hasNoPipButton && hasNoAirplayButton
            }()
            
            sideBarViewHidden = props.player?.item.playable?.sideBarViewHidden ?? true
            
            compasBodyViewHidden = props.player?.item.playable?.camera == nil
            
            compasDirectionViewHidden = props.player?.item.playable?.camera == nil
            
            compasDirectionViewTransform = {
                guard let camera = props.player?.item.playable?.camera else { return CGAffineTransform.identity }
                return CGAffineTransform(rotationAngle: .init(-camera.angles.horizontal))
            }()
            
            updateCameraAngles = {
                guard let camera = props.player?.item.playable?.camera else { return .nop }
                return camera.moveTo.map { translation in
                    var angles = camera.angles
                    angles.horizontal += Float(translation.x) * 0.01
                    angles.vertical += Float(translation.y) * 0.01
                    return angles
                }
            }()
            
            resetCameraAngles = {
                guard let camera = props.player?.item.playable?.camera else { return .nop }
                return camera.moveTo.bind(to: .init(horizontal: 0.0, vertical: 0.0))
            }()
            
            cameraPanGestureIsEnabled = props.player?.item.playable?.camera != nil
        
            videoTitleLabelHidden = props.player?.item.playable == nil
            
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
            
            subtitlesTextLabelHidden = props.player?.item.playable?.legible.external?.external.available?.isInactive ?? false
            
            thumbnailImageViewHidden = props.player?.item.playable?.thumbnail?.url == nil
            
            thumbnailImageUrl = props.player?.item.playable?.thumbnail?.url
            
            thumbnailImage = props.player?.item.playable?.thumbnail?.image
            
            errorLabelText = props.player?.item.nonplayable ?? props.player?.item.playable?.error?.message ?? ""
            
            errorLabelHidden = (props.player?.item.nonplayable == nil) && (props.player?.item.playable?.error == nil)
            
            retryButtonHidden = props.player?.item.playable?.error == nil
            
            retryButtonAction = props.player?.item.playable?.error?.retryAction ?? .nop
            
            pipButtonHidden = props.player?.item.playable?.pictureInPictureControl.isUnsupported ?? true
            
            pipButtonEnabled = props.player?.item.playable?.pictureInPictureControl.possible != nil
            
            pipButtonAction = props.player?.item.playable?.pictureInPictureControl.possible ?? .nop
            
            settingsButtonHidden = props.player?.item.playable?.settings.isHidden ?? true
            
            settingsButtonEnabled = props.player?.item.playable?.settings.enabled != nil
            
            settingsButtonAction = props.player?.item.playable?.settings.enabled ?? .nop
            
            airplayActiveLabelHidden = !(props.player?.item.playable?.airplay.isActive ?? false)
            airplayButtonHidden = props.player?.item.playable?.airplay.isHidden ?? true
            
            liveIndicationViewIsHidden = props.player?.item.playable?.live.isHidden ?? true
            
            liveDotColor = props.player?.item.playable?.live.dotColor?.color ?? nil
            
            compassViewBelowLive = {
                guard
                    props.player?.item.playable?.camera != nil,
                    props.player?.item.playable?.live.isHidden == false
                    else { return false }
                return true
            }()
        }
    }
}
