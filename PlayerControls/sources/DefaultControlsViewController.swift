import MediaPlayer
//  Copyright © 2017 Oath. All rights reserved.
/// This class contains all controls that
/// are defined for Player View Controller default UI.
/// You can replace commands with your own
/// and customise controls according to your needs.
public final class DefaultControlsViewController: ContentControlsViewController {
    public init() {
        super.init(nibName: "DefaultControlsViewController",
                   bundle: Bundle(for: type(of: self)))
        setupVisibilityController()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(nibName: "DefaultControlsViewController",
                   bundle: Bundle(for: type(of: self)))
        setupVisibilityController()
    }
    
    public override var props: Props {
        didSet(old) {
            guard isViewLoaded else { return }
            updateVisibilityController(from: old, to: props)
        }
    }
    
    @IBOutlet private var airplayActiveLabel: UILabel!
    @IBOutlet private var thumbnailImageView: UIImageView!
    @IBOutlet private var controlsView: UIView!
    @IBOutlet private var shadowView: UIView!
    @IBOutlet private var compasDirectionView: UIView!
    @IBOutlet private var compasBodyView: UIView!
    @IBOutlet private var ccTextLabel: UILabel!
    @IBOutlet private var playButton: UIButton!
    @IBOutlet private var pauseButton: UIButton!
    @IBOutlet private var replayButton: UIButton!
    @IBOutlet private var nextButton: UIButton!
    @IBOutlet private var prevButton: UIButton!
    @IBOutlet private var durationTextLabel: UILabel!
    @IBOutlet private var seekerView: SeekerControlView!
    @IBOutlet private var seekForwardButton: UIButton!
    @IBOutlet private var seekBackButton: UIButton!
    @IBOutlet private var videoTitleLabel: UILabel!
    @IBOutlet private var loadingImageView: UIImageView!
    @IBOutlet private var sideBarView: SideBarView!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var retryButton: UIButton!
    @IBOutlet private var cameraPanGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet private var pipButton: UIButton!
    @IBOutlet private var settingsButton: UIButton!
    @IBOutlet private var airPlayView: AirPlayView!
    
    @IBOutlet private var bottomItemsView: UIView!
    @IBOutlet private var liveIndicationView: UIView!
    @IBOutlet private var liveDotLabel: UILabel!
    
    @IBOutlet private var visibleControlsSubtitlesConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomSeekBarConstraint: NSLayoutConstraint!
    @IBOutlet private var compassBodyBelowLiveTopConstraint: NSLayoutConstraint!
    @IBOutlet private var compassBodyNoLiveTopConstraint: NSLayoutConstraint!
    @IBOutlet private var airplayPipTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var airplayEdgeTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesAirplayTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesEdgeTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesPipTrailingConstrains: NSLayoutConstraint!
    
    @IBOutlet private var bottomItemsAndSeekerAnimatedConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomItemsVisibleConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomItemsInvisibleConstraint: NSLayoutConstraint!
    
    //@IBOutlet private var sideBarConstraints: AnimationsConstraint!
    
    public var sidebarProps: SideBarView.Props = [] {
        didSet {
            sideBarView.props = sidebarProps.map { [weak self] in
                var props = $0
                let handler = props.handler
                props.handler = CommandWith {
                    self?.onUserInteraction?.perform()
                    handler.perform()
                }
                return props
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        seekerView.callbacks.onDragStarted = CommandWith { [unowned self] value in
            self.startSeek(from: value)
        }
        seekerView.callbacks.onDragChanged = CommandWith { [unowned self] value in
            self.updateSeek(to: value)
        }
        seekerView.callbacks.onDragFinished = CommandWith { [unowned self] value in
            self.stopSeek(at: value)
        }
    }
    
    var isApperared = false
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isApperared = true
    }
    
    var task: URLSessionDataTask?
    var animationsEnabled: Bool = true
    
    var uiProps: UIProps = UIProps(props: .noPlayer, controlsViewVisible: false)
    //swiftlint:disable function_body_length
    //swiftlint:disable cyclomatic_complexity
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let controlsViewVisible = controlsShouldBeVisible || UIAccessibilityIsVoiceOverRunning()
        uiProps = UIProps(props: props,
                          controlsViewVisible: controlsViewVisible)
        
        var afterSlideAnimationActions: [() -> ()] = []
        func afterSlideAnimation(block: @escaping () -> ()) {
            afterSlideAnimationActions.append(block)
        }
        
        var afterFadeAnimationActions: [() -> ()] = []
        func afterFadeAnimation(block: @escaping () -> ()) {
            afterFadeAnimationActions.append(block)
        }
        
        let allButtonsAndTitleAreHidden = (videoTitleLabel.isHidden || videoTitleLabel.text == "") && settingsButton.isHidden && pipButton.isHidden && airPlayView.isHidden
        
        if animationsEnabled {
            
            let animationPosition = CABasicAnimation(keyPath: "position")
            animationPosition.duration = 0.4
            animationPosition.delegate = AnimationDelegate(didStop: { _, completed in
                guard completed else { return }
                afterSlideAnimationActions.forEach{$0()}
            })
            
            let animationOpacity = CABasicAnimation(keyPath: "opacity")
            animationOpacity.duration = 0.4
            animationOpacity.delegate = AnimationDelegate(didStop: { _, completed in
                guard completed else { return }
                afterFadeAnimationActions.forEach{$0()}
            })
            
            sideBarView.layer.add(animationPosition, forKey: "position")
            seekerView.layer.add(animationPosition, forKey: "position")
            bottomItemsView.layer.add(animationPosition, forKey: "position")
            ccTextLabel.layer.add(animationPosition, forKey: "position")
            
            shadowView.layer.add(animationOpacity, forKey: "opacity")
            playButton.layer.add(animationOpacity, forKey: "opacity")
            pauseButton.layer.add(animationOpacity, forKey: "opacity")
            replayButton.layer.add(animationOpacity, forKey: "opacity")
            nextButton.layer.add(animationOpacity, forKey: "opacity")
            prevButton.layer.add(animationOpacity, forKey: "opacity")
            seekBackButton.layer.add(animationOpacity, forKey: "opacity")
            seekForwardButton.layer.add(animationOpacity, forKey: "opacity")
            compasBodyView.layer.add(animationOpacity, forKey: "opacity")
            compasDirectionView.layer.add(animationOpacity, forKey: "opacity")
            retryButton.layer.add(animationOpacity, forKey: "opacity")
            errorLabel.layer.add(animationOpacity, forKey: "opacity")
            liveIndicationView.layer.add(animationOpacity, forKey: "opacity")
            airplayActiveLabel.layer.add(animationOpacity, forKey: "opacity")
        }
        
        if !isApperared {
            shadowView.isHidden = uiProps.controlsViewHidden
            playButton.isHidden = uiProps.playButtonHidden
            pauseButton.isHidden = uiProps.pauseButtonHidden
            replayButton.isHidden = uiProps.replayButtonHidden
            
            
            seekBackButton.isHidden = uiProps.seekBackButtonHidden
            seekForwardButton.isHidden = uiProps.seekForwardButtonHidden
            compasBodyView.isHidden = uiProps.compasBodyViewHidden
            compasDirectionView.isHidden = uiProps.compasDirectionViewHidden
            retryButton.isHidden = uiProps.retryButtonHidden
            errorLabel.isHidden = uiProps.errorLabelHidden
            liveIndicationView.isHidden = uiProps.liveIndicationViewIsHidden
            airplayActiveLabel.isHidden = uiProps.airplayActiveLabelHidden
            
            sideBarView.isHidden = uiProps.sideBarViewHidden
        }
        switch uiProps.bottomItemsHidden {
        case true:
            bottomItemsVisibleConstraint.isActive = false
            bottomItemsInvisibleConstraint.isActive = true
            afterSlideAnimation {
                self.bottomItemsView.isHidden = true
                self.bottomItemsView.subviews.forEach { $0.isHidden = true }
                self.airplayPipTrailingConstrains.isActive = !self.uiProps.pipButtonHidden
                self.airplayEdgeTrailingConstrains.isActive = self.uiProps.pipButtonHidden
                self.subtitlesAirplayTrailingConstrains.isActive = !self.uiProps.airplayButtonHidden
                self.subtitlesEdgeTrailingConstrains.isActive = self.uiProps.airplayButtonHidden && self.uiProps.pipButtonHidden
                self.subtitlesPipTrailingConstrains.isActive = self.uiProps.airplayButtonHidden
            }
        case false:
            self.bottomItemsView.isHidden = false
            self.bottomItemsView.subviews.forEach { $0.isHidden = false }
            airplayPipTrailingConstrains.isActive = !uiProps.pipButtonHidden
            airplayEdgeTrailingConstrains.isActive = uiProps.pipButtonHidden
            subtitlesAirplayTrailingConstrains.isActive = !uiProps.airplayButtonHidden
            subtitlesEdgeTrailingConstrains.isActive = uiProps.airplayButtonHidden && uiProps.pipButtonHidden
            subtitlesPipTrailingConstrains.isActive = uiProps.airplayButtonHidden
            bottomItemsVisibleConstraint.isActive = true
            bottomItemsInvisibleConstraint.isActive = false
        }
        
        switch uiProps.seekForwardButtonHidden {
        case true:
            seekForwardButton.alpha = 0
            afterFadeAnimation {
                self.retryButton.isHidden = true
            }
        case false:
            seekForwardButton.isHidden = false
            seekForwardButton.alpha = 1
        }
        
        switch uiProps.seekBackButtonHidden {
        case true:
            seekBackButton.alpha = 0
            afterFadeAnimation {
                self.seekBackButton.isHidden = true
            }
        case false:
            seekBackButton.isHidden = false
            seekBackButton.alpha = 1
        }
        
        switch uiProps.replayButtonHidden {
        case true:
            retryButton.alpha = 0
            afterFadeAnimation {
                self.retryButton.isHidden = true
            }
        case false:
            retryButton.isHidden = false
            retryButton.alpha = 1
        }
        
        switch uiProps.pauseButtonHidden {
        case true:
            pauseButton.alpha = 0
            afterFadeAnimation {
                self.pauseButton.isHidden = true
            }
        case false:
            pauseButton.isHidden = false
            pauseButton.alpha = 1
        }
        
        switch uiProps.playButtonHidden {
        case true:
            playButton.alpha = 0
            afterFadeAnimation {
                self.playButton.isHidden = true
            }
        case false:
            playButton.isHidden = false
            playButton.alpha = 1
        }
        
        switch uiProps.sideBarViewHidden {
        case true:
//            sideBarConstraints.toggleToInVisible()
            afterSlideAnimation {
                self.sideBarView.isHidden = true
            }
        case false:
            self.sideBarView.isHidden = false
//            sideBarConstraints.toggleToVisible()
        }
        
        switch  uiProps.seekerViewHidden {
        case true:
            if uiProps.bottomItemsHidden {
                print("both hidden")
                bottomItemsVisibleConstraint.isActive = false
                bottomItemsInvisibleConstraint.isActive = false
                bottomItemsAndSeekerAnimatedConstraint.isActive = true
            } else {
                print("fade seeker hide")
                seekerView.performFadingAnimation(inHiddenState: uiProps.seekerViewHidden)
                durationTextLabel.performFadingAnimation(inHiddenState: uiProps.durationTextHidden)
            }
            afterSlideAnimation {
                self.seekerView.isHidden = true
                self.seekerView.progress = self.uiProps.seekerViewProgress
                self.seekerView.buffered = self.uiProps.seekerViewBuffered
            }
        case false:
            self.seekerView.progress = self.uiProps.seekerViewProgress
            self.seekerView.buffered = self.uiProps.seekerViewBuffered
            if uiProps.bottomItemsHidden {
                print("onlyBottom items hidden")
                self.seekerView.isHidden = false
                bottomItemsVisibleConstraint.isActive = false
                bottomItemsInvisibleConstraint.isActive = true
                bottomItemsAndSeekerAnimatedConstraint.isActive = false
            } else if (!uiProps.bottomItemsHidden && !allButtonsAndTitleAreHidden) {
                print("fade seeker appear")
                seekerView.performFadingAnimation(inHiddenState: uiProps.seekerViewHidden)
                durationTextLabel.performFadingAnimation(inHiddenState: uiProps.durationTextHidden)
            } else {
                print("nothing hidden")
                self.seekerView.isHidden = false
                bottomItemsVisibleConstraint.isActive = true
                bottomItemsInvisibleConstraint.isActive = false
                bottomItemsAndSeekerAnimatedConstraint.isActive = false
            }
            
        }
        seekerView.updateCurrentTime(text: uiProps.seekerViewCurrentTimeText)
        
        switch uiProps.nextButtonHidden {
        case true:
            nextButton.alpha = 0
            afterSlideAnimation {
                self.nextButton.isHidden = true
            }
        case false:
            self.nextButton.isHidden = true
            nextButton.alpha = 1
        }
        nextButton.isEnabled = uiProps.nextButtonEnabled
        
        switch uiProps.prevButtonHidden {
        case true:
            prevButton.alpha = 0
            afterFadeAnimation {
                self.prevButton.isHidden = true
            }
        case false:
            self.prevButton.isHidden = true
            prevButton.alpha = 1
        }
        prevButton.isEnabled = uiProps.prevButtonEnabled
        
        
        shadowView.isHidden = uiProps.controlsViewHidden
        isLoading = uiProps.loading
        
        playButton.isHidden = uiProps.playButtonHidden
        pauseButton.isHidden = uiProps.pauseButtonHidden
        replayButton.isHidden = uiProps.replayButtonHidden
        
        nextButton.isHidden = uiProps.nextButtonHidden
        nextButton.isEnabled = uiProps.nextButtonEnabled
        prevButton.isHidden = uiProps.prevButtonHidden
        prevButton.isEnabled = uiProps.prevButtonEnabled
        
        //seekerView.isHidden = uiProps.seekerViewHidden
        seekerView.updateCurrentTime(text: uiProps.seekerViewCurrentTimeText)
        seekerView.progress = uiProps.seekerViewProgress
        seekerView.buffered = uiProps.seekerViewBuffered
        seekerView.height = traitCollection.userInterfaceIdiom == .pad ? 46 : 38
        seekerView.accessibilityLabel = uiProps.seekerViewAccessibilityLabel
        
//        bottomSeekBarConstraint.constant = {
//            let constant = traitCollection.userInterfaceIdiom == .pad ? 60 : 53
//            return .init(uiProps.seekbarPositionedAtBottom ? 10 : constant)
//        }()
        
        seekBackButton.isHidden = uiProps.seekBackButtonHidden
        seekForwardButton.isHidden = uiProps.seekForwardButtonHidden
        
        sideBarView.isHidden = uiProps.sideBarViewHidden
        
        compasBodyView.isHidden = uiProps.compasBodyViewHidden
        compasDirectionView.isHidden = uiProps.compasDirectionViewHidden
        compasDirectionView.transform = uiProps.compasDirectionViewTransform
        cameraPanGestureRecognizer.isEnabled = uiProps.cameraPanGestureIsEnabled

        videoTitleLabel.isHidden = uiProps.videoTitleLabelHidden
        videoTitleLabel.text = uiProps.videoTitleLabelText
        
        durationTextLabel.text = uiProps.durationTextLabelText
        //durationTextLabel.isHidden = uiProps.durationTextHidden
        durationTextLabel.accessibilityLabel = uiProps.durationTextLabelAccessibilityLabel
        
        ccTextLabel.isHidden = uiProps.subtitlesTextLabelHidden
        ccTextLabel.text = uiProps.subtitlesTextLabelText

        visibleControlsSubtitlesConstraint.constant = {
            let constant = traitCollection.userInterfaceIdiom == .pad ? 130 : 110
            return .init(uiProps.controlsViewHidden ? 30 : constant)
        }()
        airplayPipTrailingConstrains.isActive = !uiProps.pipButtonHidden
        airplayEdgeTrailingConstrains.isActive = uiProps.pipButtonHidden
        subtitlesAirplayTrailingConstrains.isActive = !uiProps.airplayButtonHidden 
        subtitlesEdgeTrailingConstrains.isActive = uiProps.airplayButtonHidden && uiProps.pipButtonHidden
        subtitlesPipTrailingConstrains.isActive = uiProps.airplayButtonHidden
        
        thumbnailImageView.isHidden = uiProps.thumbnailImageViewHidden
        
        if let url = uiProps.thumbnailImageUrl {
            func resetUrlIfNeeded() {
                guard let taskUrl = task?.originalRequest?.url else { return }
                guard taskUrl != url else { return }
                task = nil
            }
            
            func handleThumbnail() {
                guard task == nil else { return }
                weak var weakSelf = self
                task = URLSession.shared.dataTask(
                    with: url,
                    completionHandler: { data, response, error in
                        guard let response = response as? HTTPURLResponse else { return }
                        guard response.statusCode == 200 else { return }
                        guard error == nil else { return }
                        guard let data = data else { return }
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            weakSelf?.thumbnailImageView.isHidden = false
                            weakSelf?.thumbnailImageView.image = image
                        }
                })
                task?.resume()
            }
            
            resetUrlIfNeeded()
            handleThumbnail()
        } else if let image = uiProps.thumbnailImage {
            thumbnailImageView.isHidden = false
            thumbnailImageView.image = image
        }
        
        retryButton.isHidden = uiProps.retryButtonHidden
        errorLabel.isHidden = uiProps.errorLabelHidden
        errorLabel.text = uiProps.errorLabelText
        
        pipButton.isEnabled = uiProps.pipButtonEnabled
        
        settingsButton.isEnabled = uiProps.settingsButtonEnabled
        
        liveIndicationView.isHidden = uiProps.liveIndicationViewIsHidden
        liveDotLabel.textColor = uiProps.liveDotColor ?? liveDotLabel.textColor ?? view.tintColor
        
        airplayActiveLabel.isHidden = uiProps.airplayActiveLabelHidden
        airPlayView.props = AirPlayView.Props(
            icons: AirPlayView.Props.Icons(
                normal: UIImage.init(named: "icon-airplay", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!,
                selected: UIImage.init(named: "icon-airplay-active", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!,
                highlighted: UIImage.init(named: "icon-airplay-active", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!)
        )
    }
    
    func setConstraints() {
        
        //what is needed: 1) seeker new state, bottomItems new and old state in visible and invisible
        
        //bottom items go down && seeker follows
        //bottom items go up && seeker follows
        //seeker and bottom items go down
        //seeker and bottom items go up
        //seeker fades when bottom items are and will not be hidden
    }
    
    //swiftlint:enable function_body_length
    //swiftlint:enable cyclomatic_complexity
    
    /// Alpha for shadow view.
    public var shadowViewAlpha = 0.3 as CGFloat
    
    /// Shadow view on beneath controls.
    @IBInspectable var isLoading: Bool = false {
        didSet {
            guard isViewLoaded else { return }
            
            loadingImageView.isHidden = !isLoading
            
            isLoading
                ? loadingImageView.enableRotation()
                : loadingImageView.disableRotation()
        }
    }
    
    public var onPlayEvent: Command?
    public var onPauseEvent: Command?
    public var onTapEvent: Command?
    public var onUserInteraction: Command?
    
    func updateVisibilityController( //swiftlint:disable:this cyclomatic_complexity
        from old: ContentControlsViewController.Props,
             to new: ContentControlsViewController.Props) {
        
        func isVideoPlaying(for props: ContentControlsViewController.Props) -> Bool {
            guard case .player(let player) = props else { return false }
            guard case .playable(let contentProps) = player.item else { return false }
            guard case .pause = contentProps.playbackAction else { return false }
            return true
        }
        
        switch (isVideoPlaying(for: old), isVideoPlaying(for: new)) {
        case (true, true): break
        case (false, false): break
        case (false, true): onPlayEvent?.perform()
        case (true, false): onPauseEvent?.perform()
        }
    }
    
    var controlsShouldBeVisible = true
    
    public func showControls() {
        controlsShouldBeVisible = true
        view.setNeedsLayout()
    }
    
    public func hideControls() {
        controlsShouldBeVisible = false
        view.setNeedsLayout()
    }
    
    func setupVisibilityController() {
        weak var weakSelf = self
        let controls = ControlsPresentationController.Controls(
            show: CommandWith { weakSelf?.showControls() },
            hide: CommandWith { weakSelf?.hideControls() })
        
        let visibilityController = ControlsPresentationController(controls: controls)
        
        onUserInteraction = CommandWith { visibilityController.resetTimer() }
        onTapEvent = CommandWith { visibilityController.tap() }
        onPlayEvent = CommandWith { visibilityController.play() }
        onPauseEvent = CommandWith { visibilityController.pause() }
    }
 
    @IBAction private func playButtonTouched() {
        uiProps.playButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func pauseButtonTouched() {
        uiProps.pauseButtonAction.perform()
		onUserInteraction?.perform()
    }
    
    @IBAction private func replayButtonTouched() {
        uiProps.replayButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func nextButtonTouched() {
        uiProps.nextButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func prevButtonTouched() {
        uiProps.prevButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    private func startSeek(from progress: CGFloat) {
        uiProps.startSeekAction.perform(with: .init(progress))
		onUserInteraction?.perform()
    }
    
    private func updateSeek(to progress: CGFloat) {
        uiProps.updateSeekAction.perform(with: .init(progress))
		onUserInteraction?.perform()
    }
    
    private func stopSeek(at progress: CGFloat) {
        uiProps.stopSeekAction.perform(with: .init(progress))
		onUserInteraction?.perform()
    }
    
    @IBAction private func seekForwardButtonTouched() {
        uiProps.seekToSecondsAction.perform(with: uiProps.seekerViewCurrentTime.advanced(by: 10))
        onUserInteraction?.perform()
    }
    
    @IBAction private func seekBackButtonTouched() {
        let value = uiProps.seekerViewCurrentTime
        uiProps.seekToSecondsAction.perform(with: value - min(value, 10))
        onUserInteraction?.perform()
    }
    
    @IBAction private func onEmptySpaceTap() {
        onTapEvent?.perform()
    }
    
    @IBAction private func onCameraPan(with recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: recognizer.view)
        recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
        
        uiProps.updateCameraAngles.perform(with: translation)
    }
    
    @IBAction private func resetCamera() {
        uiProps.resetCameraAngles.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func retry() {
        uiProps.retryButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func pipButtonTouched() {
        uiProps.pipButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func settingsButtonTouched() {
        uiProps.settingsButtonAction.perform()
    }
}
