import MediaPlayer
//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.
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
    @IBOutlet private var loadingImageView: LoadingImageView!
    @IBOutlet private var sideBarView: SideBarView!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var retryButton: UIButton!
    
    @IBOutlet private var showBrandedContentButton: UIButton!
    
    @IBOutlet private var onEmptySpaceGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet private var contentFullScreenGestureRecognizer: UITapGestureRecognizer!
    @IBOutlet private var cameraPanGestureRecognizer: UIPanGestureRecognizer!
    
    @IBOutlet private var pipButton: UIButton!
    @IBOutlet private var settingsButton: UIButton!
    @IBOutlet private var airPlayView: AirPlayView!
    
    @IBOutlet private var bottomItemsView: UIView!
    @IBOutlet private var liveIndicationView: UIView!
    @IBOutlet private var liveDotLabel: UILabel!
    
    @IBOutlet private var compassBodyBelowLiveTopConstraint: NSLayoutConstraint!
    @IBOutlet private var compassBodyNoLiveTopConstraint: NSLayoutConstraint!
    @IBOutlet private var airplayPipTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var airplayEdgeTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesAirplayTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesEdgeTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var subtitlesPipTrailingConstrains: NSLayoutConstraint!
    @IBOutlet private var liveViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet private var bottomItemsAndSeekerAnimatedConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomItemsVisibleConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomItemsInvisibleConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomItemsSeekerConstraint: NSLayoutConstraint!
    
    @IBOutlet private var sideBarInvisibleConstraint: NSLayoutConstraint!
    @IBOutlet private var sideBarVisibleConstraint: NSLayoutConstraint!
    @IBOutlet private var sideBarSeekerConstraint: NSLayoutConstraint!
    @IBOutlet private var sideBarBottomConstraint: NSLayoutConstraint!
    @IBOutlet private var bottomItemsHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var seekerToSafeAreaConstraint: NSLayoutConstraint!
    
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
        
        onEmptySpaceGestureRecognizer.require(toFail: contentFullScreenGestureRecognizer)
        
        contentFullScreenGestureRecognizer.delegate = self
    }
    
    private var state = State()
    struct State {
        var hasAppeared = false
        var isTransitioning = false
        var isSeekingInProgress = false
        
        var controlsAnimationPossible: Bool {
            return hasAppeared && !isSeekingInProgress
        }
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        state.hasAppeared = false
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        state.hasAppeared = true
    }
    
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        state.isTransitioning = true
        coordinator.animateAlongsideTransition(in: nil, animation: nil) { _ in
            self.state.isTransitioning = false
        }
    }
    
    
    var task: URLSessionDataTask?
    public var controlsAppearanceAnimationDuration: CFTimeInterval = 0.25
    public var controlsDisappearanceAnimationDuration: CFTimeInterval = 0.35
    
    var shouldHideHomeIndicator = true
    
    @available(iOS 11.0, *)
    override public var prefersHomeIndicatorAutoHidden: Bool
    {
        return shouldHideHomeIndicator
    }
    
    var currentUIProps: UIProps = UIProps(props: .noPlayer, controlsViewVisible: false)
    //swiftlint:disable function_body_length
    //swiftlint:disable cyclomatic_complexity
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let controlsViewVisible = controlsShouldBeVisible || UIAccessibility.isVoiceOverRunning
        
        let nextUIProps = UIProps(props: props,
                                  controlsViewVisible: controlsViewVisible)
        
        func addAnimation(view: UIView, keyPath: String, onComplete: @escaping () -> ()) {
            guard nextUIProps.animationsEnabled && state.controlsAnimationPossible else {
                onComplete()
                return
            }
            let animation = CABasicAnimation(keyPath: keyPath)
            let controlsBecomeVisible = {
                return currentUIProps.controlsViewHidden && !nextUIProps.controlsViewHidden
            }()
            let duration = controlsBecomeVisible
                ? controlsAppearanceAnimationDuration
                : controlsDisappearanceAnimationDuration
            
            animation.duration = duration
            animation.delegate = AnimationDelegate(didStop: { _, completed in
                guard completed else { return }
                onComplete()
            })
            
            view.layer.add(animation, forKey: keyPath)
        }
        
        loadingImageView.isLoading = nextUIProps.loading
        
        func renderShadowView() {
            switch (currentUIProps.controlsViewHidden, nextUIProps.controlsViewHidden) {
            case (false, true):
                addAnimation(view: shadowView, keyPath: "opacity") {
                    self.shadowView.isHidden = true
                }
                shadowView.alpha = 0
                
            case (true, false):
                addAnimation(view: shadowView, keyPath: "opacity") {}
                shadowView.isHidden = false
                shadowView.alpha = shadowViewAlpha
                
            default:
                guard shadowView.layer.animationKeys() == nil else { return }
                shadowView.isHidden = nextUIProps.controlsViewHidden
            }
        }
        
        func renderBottomItemsView() {
            func setupBottomItems() {
                bottomItemsView.isHidden = nextUIProps.bottomItemsHidden
                pipButton.isHidden = nextUIProps.pipButtonHidden
                airPlayView.isHidden = nextUIProps.airplayButtonHidden
                settingsButton.isHidden = nextUIProps.settingsButtonHidden
                videoTitleLabel.isHidden = nextUIProps.videoTitleLabelHidden
                
                pipButton.isEnabled = nextUIProps.pipButtonEnabled
                settingsButton.isEnabled = nextUIProps.settingsButtonEnabled
                videoTitleLabel.text = nextUIProps.videoTitleLabelText
            }
            func setupBottomItemsConstraints() {
                airplayPipTrailingConstrains.isActive = !nextUIProps.pipButtonHidden && !nextUIProps.airplayButtonHidden
                airplayEdgeTrailingConstrains.isActive = nextUIProps.pipButtonHidden && !nextUIProps.airplayButtonHidden
                subtitlesAirplayTrailingConstrains.isActive = !nextUIProps.airplayButtonHidden
                subtitlesEdgeTrailingConstrains.isActive = nextUIProps.airplayButtonHidden && nextUIProps.pipButtonHidden && !nextUIProps.settingsButtonHidden
                subtitlesPipTrailingConstrains.isActive = nextUIProps.airplayButtonHidden && !nextUIProps.pipButtonHidden
            }
            switch (currentUIProps.bottomItemsHidden, nextUIProps.bottomItemsHidden) {
            case (false, true):
                addAnimation(view: bottomItemsView, keyPath: "position") {
                    setupBottomItems()
                    setupBottomItemsConstraints()
                }
                if !currentUIProps.seekerViewHidden && !nextUIProps.seekerViewHidden {
                    addAnimation(view: seekerView, keyPath: "position") {}
                }
                
                bottomItemsVisibleConstraint.isActive = false
                bottomItemsInvisibleConstraint.isActive = true
            case (true, false):
                addAnimation(view: bottomItemsView, keyPath: "position") {}
                
                if !currentUIProps.seekerViewHidden && !nextUIProps.seekerViewHidden {
                    addAnimation(view: seekerView, keyPath: "position") {}
                }
                
                setupBottomItems()
                setupBottomItemsConstraints()
                
                bottomItemsVisibleConstraint.isActive = true
                bottomItemsInvisibleConstraint.isActive = false
            case (false, false):
                setupBottomItemsConstraints()
                setupBottomItems()
                guard bottomItemsView.layer.animationKeys() == nil &&
                    seekerView.layer.animationKeys() == nil ||
                    state.isTransitioning else { return }
                bottomItemsVisibleConstraint.isActive = !nextUIProps.bottomItemsHidden
                bottomItemsInvisibleConstraint.isActive = nextUIProps.bottomItemsHidden
            case (true, true):
                guard bottomItemsView.layer.animationKeys() == nil &&
                    seekerView.layer.animationKeys() == nil ||
                    state.isTransitioning else { return }
                bottomItemsVisibleConstraint.isActive = !nextUIProps.bottomItemsHidden
                bottomItemsInvisibleConstraint.isActive = nextUIProps.bottomItemsHidden
                setupBottomItemsConstraints()
                setupBottomItems()
            }
            bottomItemsHeightConstraint.constant = {
                return .init(traitCollection.userInterfaceIdiom == .pad ? 58.5 : 51.5)
            }()
        }
        
        func renderSeekerView() {
            func setupSeekerView() {
                seekerView.progress = nextUIProps.seekerViewProgress
                seekerView.buffered = nextUIProps.seekerViewBuffered
                seekerView.updateCurrentTime(text: nextUIProps.seekerViewCurrentTimeText)
                seekerView.height = self.traitCollection.userInterfaceIdiom == .pad ? 46 : 38
                seekerView.accessibilityLabel = nextUIProps.seekerViewAccessibilityLabel
                seekerView.cuePoints = nextUIProps.seekerViewCuePoints
                seekerView.updateSeekerViewColors(
                    currentTimeColor: nextUIProps.seekerViewCurrentTimeColor,
                    progressColor: nextUIProps.seekerViewProgressColor,
                    bufferedColor: nextUIProps.seekerViewBufferedColor,
                    seekerFillerColor: nextUIProps.seekerViewFillerColor,
                    seekerViewCuePoints: nextUIProps.seekerViewCuePointsColor,
                    dragControlColor: nextUIProps.seekerViewDragControlColor)
            }
            switch (currentUIProps.seekerViewHidden, nextUIProps.seekerViewHidden) {
            case (false, true):
                if nextUIProps.bottomItemsHidden {
                    addAnimation(view: seekerView, keyPath: "position") {
                        self.seekerView.isHidden = true
                        self.seekerView.alpha = 0
                        setupSeekerView()
                    }
                    seekerToSafeAreaConstraint.isActive = false
                    bottomItemsSeekerConstraint.isActive = true
                    bottomItemsVisibleConstraint.isActive = false
                    bottomItemsInvisibleConstraint.isActive = false
                    bottomItemsAndSeekerAnimatedConstraint.isActive = true
                } else {
                    addAnimation(view: seekerView, keyPath: "opacity", onComplete: setupSeekerView)
                    if currentUIProps.bottomItemsHidden {
                        addAnimation(view: seekerView, keyPath: "position", onComplete: setupSeekerView)
                    }
                    bottomItemsAndSeekerAnimatedConstraint.isActive = false
                    seekerToSafeAreaConstraint.isActive = false
                    bottomItemsSeekerConstraint.isActive = true
                    seekerView.alpha = 0
                }
            case (true, false):
                if currentUIProps.bottomItemsHidden {
                    addAnimation(view: seekerView, keyPath: "position") {}
                } else {
                    addAnimation(view: seekerView, keyPath: "opacity") {}
                }
                setupSeekerView()
                
                if nextUIProps.bottomItemsHidden {
                    seekerView.isHidden = false
                    seekerView.alpha = 1
                    seekerToSafeAreaConstraint.isActive = true
                    bottomItemsSeekerConstraint.isActive = false
                    bottomItemsVisibleConstraint.isActive = false
                    bottomItemsInvisibleConstraint.isActive = true
                    bottomItemsAndSeekerAnimatedConstraint.isActive = false
                } else {
                    seekerView.isHidden = false
                    seekerView.alpha = 1
                    seekerToSafeAreaConstraint.isActive = false
                    bottomItemsSeekerConstraint.isActive = true
                    bottomItemsVisibleConstraint.isActive = true
                    bottomItemsInvisibleConstraint.isActive = false
                    bottomItemsAndSeekerAnimatedConstraint.isActive = false
                }
            case (true, true):
                setupSeekerView()
                guard seekerView.layer.animationKeys() == nil || state.isTransitioning else { return }
                seekerView.isHidden = nextUIProps.seekerViewHidden
                seekerView.alpha = 0
                if nextUIProps.bottomItemsHidden {
                    bottomItemsVisibleConstraint.isActive = false
                    bottomItemsInvisibleConstraint.isActive = false
                    bottomItemsAndSeekerAnimatedConstraint.isActive = true
                } else {
                    bottomItemsVisibleConstraint.isActive = true
                    bottomItemsInvisibleConstraint.isActive = false
                    bottomItemsAndSeekerAnimatedConstraint.isActive = false
                }
            case (false, false):
                setupSeekerView()
                if nextUIProps.bottomItemsHidden {
                    seekerToSafeAreaConstraint.isActive = true
                    bottomItemsSeekerConstraint.isActive = false
                } else {
                    seekerToSafeAreaConstraint.isActive = false
                    bottomItemsSeekerConstraint.isActive = true
                }
                guard seekerView.layer.animationKeys() == nil && !state.isTransitioning else { return }
                seekerView.alpha = 1
                seekerView.isHidden = nextUIProps.seekerViewHidden
                guard currentUIProps.bottomItemsHidden != nextUIProps.bottomItemsHidden else { return }
                addAnimation(view: seekerView, keyPath: "position") {}
                if nextUIProps.bottomItemsHidden {
                    bottomItemsVisibleConstraint.isActive = false
                    bottomItemsInvisibleConstraint.isActive = true
                    bottomItemsAndSeekerAnimatedConstraint.isActive = false
                } else {
                    bottomItemsVisibleConstraint.isActive = true
                    bottomItemsInvisibleConstraint.isActive = false
                    bottomItemsAndSeekerAnimatedConstraint.isActive = false
                }
            }
        }
        func renderDurationLabel() {
            func setupDurationLabel() {
                durationTextLabel.text = nextUIProps.durationTextLabelText
                durationTextLabel.accessibilityLabel = nextUIProps.durationTextLabelAccessibilityLabel
            }
            switch (currentUIProps.durationTextHidden, nextUIProps.durationTextHidden) {
            case (false, true):
                if nextUIProps.bottomItemsHidden {
                    addAnimation(view: durationTextLabel, keyPath: "position") {
                        self.durationTextLabel.isHidden = true
                        setupDurationLabel()
                    }
                } else {
                    addAnimation(view: durationTextLabel, keyPath: "opacity") {
                        self.durationTextLabel.isHidden = true
                        setupDurationLabel()
                    }
                    durationTextLabel.alpha = 0
                }
            case (true, false):
                if !currentUIProps.bottomItemsHidden {
                    addAnimation(view: durationTextLabel, keyPath: "opacity") {}
                } else {
                    addAnimation(view: durationTextLabel, keyPath: "position") {}
                }
                durationTextLabel.isHidden = false
                durationTextLabel.alpha = 1
                setupDurationLabel()
            case (true, true):
                setupDurationLabel()
                guard durationTextLabel.layer.animationKeys() == nil || state.isTransitioning else { return }
                durationTextLabel.isHidden = true
                durationTextLabel.alpha = 0
            case (false, false):
                setupDurationLabel()
                guard durationTextLabel.layer.animationKeys() == nil && !state.isTransitioning else { return }
                if currentUIProps.bottomItemsHidden != nextUIProps.bottomItemsHidden {
                    addAnimation(view: durationTextLabel, keyPath: "position") {}
                }
                durationTextLabel.isHidden = false
                durationTextLabel.alpha = 1
            }
        }
        
        func renderSideBarView() {
            switch (currentUIProps.sideBarViewHidden, nextUIProps.sideBarViewHidden) {
            case (false, true):
                addAnimation(view: sideBarView, keyPath: "position") {
                    self.sideBarView.isHidden = true
                }
                sideBarBottomConstraint.constant = {
                    guard #available(iOS 11, *) else { return view.frame.height - sideBarView.frame.height }
                    return view.frame.height - sideBarView.frame.height - view.safeAreaInsets.top
                }()
                sideBarVisibleConstraint.isActive = false
                sideBarInvisibleConstraint.isActive = true
                
                sideBarBottomConstraint.isActive = true
            case (true, false):
                addAnimation(view: sideBarView, keyPath: "position") {}
                sideBarView.isHidden = false
                sideBarInvisibleConstraint.isActive = false
                sideBarBottomConstraint.isActive = false
                sideBarVisibleConstraint.isActive = true
            default:
                guard sideBarView.layer.animationKeys() == nil || state.isTransitioning else { return }
                sideBarView.isHidden = nextUIProps.sideBarViewHidden
                sideBarVisibleConstraint.isActive = !nextUIProps.sideBarViewHidden
                sideBarInvisibleConstraint.isActive = nextUIProps.sideBarViewHidden
                sideBarBottomConstraint.isActive = nextUIProps.sideBarViewHidden
            }
        }
        
        func renderPlayButton() {
            switch (currentUIProps.playButtonHidden, nextUIProps.playButtonHidden) {
            case (false, true):
                if nextUIProps.replayButtonHidden && nextUIProps.pauseButtonHidden {
                    addAnimation(view: playButton, keyPath: "opacity") {
                        self.playButton.isHidden = true
                    }
                }
                playButton.alpha = 0
            case (true, false):
                if replayButton.isHidden && pauseButton.isHidden {
                    addAnimation(view: playButton, keyPath: "opacity") {}
                }
                playButton.isHidden = false
                playButton.alpha = 1
            default:
                guard playButton.layer.animationKeys() == nil else { return }
                playButton.isHidden = nextUIProps.playButtonHidden
                playButton.alpha = nextUIProps.playButtonHidden ? 0 : 1
            }
        }
        func renderPauseButton() {
            switch (currentUIProps.pauseButtonHidden, nextUIProps.pauseButtonHidden) {
            case (false, true):
                if nextUIProps.playButtonHidden && nextUIProps.replayButtonHidden {
                    addAnimation(view: pauseButton, keyPath: "opacity") {
                        self.pauseButton.isHidden = true
                    }
                }
                pauseButton.alpha = 0
            case (true, false):
                if playButton.isHidden && replayButton.isHidden {
                    addAnimation(view: pauseButton, keyPath: "opacity") {}
                }
                pauseButton.isHidden = false
                pauseButton.alpha = 1
            default:
                guard pauseButton.layer.animationKeys() == nil else { return }
                pauseButton.isHidden = nextUIProps.pauseButtonHidden
                pauseButton.alpha = nextUIProps.pauseButtonHidden ? 0 : 1
            }
        }
        func renderReplayButton() {
            switch (currentUIProps.replayButtonHidden, nextUIProps.replayButtonHidden) {
            case (false, true):
                if nextUIProps.playButtonHidden && nextUIProps.pauseButtonHidden {
                    addAnimation(view: replayButton, keyPath: "opacity") {
                        self.replayButton.isHidden = true
                    }
                }
                replayButton.alpha = 0
                
            case (true, false):
                if playButton.isHidden && pauseButton.isHidden {
                    addAnimation(view: replayButton, keyPath: "opacity") {}
                }
                replayButton.isHidden = false
                replayButton.alpha = 1
            default:
                guard replayButton.layer.animationKeys() == nil else { return }
                replayButton.isHidden = nextUIProps.replayButtonHidden
                replayButton.alpha = nextUIProps.replayButtonHidden ? 0 : 1
            }
        }
        func renderRetryButton() {
            switch (currentUIProps.retryButtonHidden, nextUIProps.retryButtonHidden) {
            case (false, true):
                addAnimation(view: retryButton, keyPath: "opacity") {
                    self.retryButton.isHidden = true
                }
                retryButton.alpha = 0
            case (true, false):
                addAnimation(view: retryButton, keyPath: "opacity") {}
                retryButton.isHidden = false
                retryButton.alpha = 1
            default:
                guard retryButton.layer.animationKeys() == nil else { return }
                retryButton.isHidden = nextUIProps.retryButtonHidden
            }
        }
        func renderNextButton() {
            switch (currentUIProps.nextButtonHidden, nextUIProps.nextButtonHidden) {
            case (false, true):
                addAnimation(view: nextButton, keyPath: "opacity") {
                    self.nextButton.isHidden = true
                    self.nextButton.isEnabled = nextUIProps.nextButtonEnabled
                }
                nextButton.alpha = 0
            case (true, false):
                addAnimation(view: nextButton, keyPath: "opacity") {}
                nextButton.isHidden = false
                nextButton.alpha = 1
                nextButton.isEnabled = nextUIProps.nextButtonEnabled
            default:
                guard nextButton.layer.animationKeys() == nil else { return }
                nextButton.isHidden = nextUIProps.nextButtonHidden
                nextButton.alpha = nextUIProps.nextButtonHidden ? 0 : 1
                nextButton.isEnabled = nextUIProps.nextButtonEnabled
            }
        }
        func renderPrevButton() {
            switch (currentUIProps.prevButtonHidden, nextUIProps.prevButtonHidden) {
            case (false, true):
                addAnimation(view: prevButton, keyPath: "opacity") {
                    self.prevButton.isHidden = true
                    self.prevButton.isEnabled = nextUIProps.prevButtonEnabled
                }
                prevButton.alpha = 0
            case (true, false):
                addAnimation(view: prevButton, keyPath: "opacity") {}
                prevButton.isHidden = false
                prevButton.alpha = 1
                prevButton.isEnabled = nextUIProps.prevButtonEnabled
            default:
                guard prevButton.layer.animationKeys() == nil else { return }
                prevButton.isHidden = nextUIProps.prevButtonHidden
                prevButton.alpha = nextUIProps.prevButtonHidden ? 0 : 1
                prevButton.isEnabled = nextUIProps.prevButtonEnabled
            }
        }
        
        func renderErrorLabel() {
            switch (currentUIProps.errorLabelHidden, nextUIProps.errorLabelHidden) {
            case (false, true):
                addAnimation(view: errorLabel, keyPath: "opacity") {
                    self.errorLabel.isHidden = true
                    self.errorLabel.text = nextUIProps.errorLabelText
                }
                errorLabel.alpha = 0
            case (true, false):
                addAnimation(view: errorLabel, keyPath: "opacity") {}
                errorLabel.isHidden = false
                errorLabel.text = nextUIProps.errorLabelText
                errorLabel.alpha = 1
            default:
                guard errorLabel.layer.animationKeys() == nil else { return }
                errorLabel.isHidden = nextUIProps.errorLabelHidden
                errorLabel.alpha = nextUIProps.errorLabelHidden ? 0 : 1
                errorLabel.text = nextUIProps.errorLabelText
            }
        }
        func renderAirplayActiveLabel() {
            switch (currentUIProps.airplayActiveLabelHidden, nextUIProps.airplayActiveLabelHidden) {
            case (false, true):
                addAnimation(view: airplayActiveLabel, keyPath: "opacity") {
                    self.airplayActiveLabel.isHidden = true
                }
                airplayActiveLabel.alpha = 0
            case (true, false):
                addAnimation(view: airplayActiveLabel, keyPath: "opacity") {}
                airplayActiveLabel.isHidden = false
                airplayActiveLabel.alpha = 1
            default:
                guard airplayActiveLabel.layer.animationKeys() == nil else { return }
                airplayActiveLabel.isHidden = nextUIProps.airplayActiveLabelHidden
                airplayActiveLabel.alpha = nextUIProps.airplayActiveLabelHidden ? 0 : 1
            }
        }
        func renderSeekForwardButton() {
            switch (currentUIProps.seekForwardButtonHidden, nextUIProps.seekForwardButtonHidden) {
            case (false, true):
                addAnimation(view: seekForwardButton, keyPath: "opacity") {
                    self.seekForwardButton.isHidden = true
                }
                seekForwardButton.alpha = 0
            case (true, false):
                addAnimation(view: seekForwardButton, keyPath: "opacity") {}
                seekForwardButton.isHidden = false
                seekForwardButton.alpha = 1
            default:
                guard seekForwardButton.layer.animationKeys() == nil else { return }
                seekForwardButton.isHidden = nextUIProps.seekForwardButtonHidden
                seekForwardButton.alpha = nextUIProps.seekForwardButtonHidden ? 0 : 1
            }
        }
        func renderSeekBackButton() {
            switch (currentUIProps.seekBackButtonHidden, nextUIProps.seekBackButtonHidden) {
            case (false, true):
                addAnimation(view: seekBackButton, keyPath: "opacity") {
                    self.seekBackButton.isHidden = true
                }
                seekBackButton.alpha = 0
            case (true, false):
                addAnimation(view: seekBackButton, keyPath: "opacity") {}
                seekBackButton.isHidden = false
                seekBackButton.alpha = 1
            default:
                guard seekBackButton.layer.animationKeys() == nil else { return }
                seekBackButton.isHidden = nextUIProps.seekBackButtonHidden
                seekBackButton.alpha = nextUIProps.seekBackButtonHidden ? 0 : 1
            }
        }
        
        func renderLiveIndicatorView() {
            switch (currentUIProps.liveIndicationViewIsHidden, nextUIProps.liveIndicationViewIsHidden) {
            case (false, true):
                addAnimation(view: liveIndicationView, keyPath: "opacity") {
                    self.liveIndicationView.isHidden = true
                    self.liveDotLabel.textColor = nextUIProps.liveDotColor ?? self.liveDotLabel.textColor ?? self.view.tintColor
                }
                liveIndicationView.alpha = 0
            case (true, false):
                addAnimation(view: liveIndicationView, keyPath: "opacity") {}
                liveIndicationView.isHidden = false
                liveIndicationView.alpha = 1
                liveDotLabel.textColor = nextUIProps.liveDotColor ?? liveDotLabel.textColor ?? view.tintColor
            default:
                guard liveIndicationView.layer.animationKeys() == nil else { return }
                liveIndicationView.isHidden = nextUIProps.liveIndicationViewIsHidden
                liveIndicationView.alpha = nextUIProps.liveIndicationViewIsHidden ? 0 : 1
                liveDotLabel.textColor = nextUIProps.liveDotColor ?? liveDotLabel.textColor ?? view.tintColor
            }
        }
        
        func renderShowBrandedContentPageButton() {
            showBrandedContentButton.layer.cornerRadius = showBrandedContentButton.frame.height / 2
            showBrandedContentButton.setTitle(currentUIProps.brandedContentTitle,
                                              for: .normal)
            let image = nextUIProps.isBrandedContentClickable
                ? UIImage(named: "open-web-page", in: Bundle(for: type(of: self)), compatibleWith: nil)
                : nil
            showBrandedContentButton.setImage(image, for: .normal)
            showBrandedContentButton.setImage(image, for: .selected)
            showBrandedContentButton.setImage(image, for: .highlighted)
            
            switch (currentUIProps.isBrandedContentHidden, nextUIProps.isBrandedContentHidden) {
            case (false, true):
                addAnimation(view: showBrandedContentButton, keyPath: "opacity") {
                    self.showBrandedContentButton.isHidden = true
                }
                showBrandedContentButton.alpha = 0
            case (true, false):
                addAnimation(view: showBrandedContentButton, keyPath: "opacity") {}
                showBrandedContentButton.isHidden = false
                showBrandedContentButton.alpha = 1
            default:
                guard showBrandedContentButton.layer.animationKeys() == nil else { return }
                showBrandedContentButton.isHidden = nextUIProps.isBrandedContentHidden
                showBrandedContentButton.alpha = nextUIProps.isBrandedContentHidden ? 0 : 1
            }
        }
        
        func renderCompasBodyView() {
            switch (currentUIProps.compasBodyViewHidden, nextUIProps.compasBodyViewHidden) {
            case (false, true):
                addAnimation(view: compasBodyView, keyPath: "opacity") {
                    self.compasBodyView.isHidden = true
                }
                compasBodyView.alpha = 0
            case (true, false):
                addAnimation(view: compasBodyView, keyPath: "opacity") {}
                compasBodyView.isHidden = false
                compasBodyView.alpha = 1
            default:
                guard compasBodyView.layer.animationKeys() == nil else { return }
                compasBodyView.isHidden = nextUIProps.compasBodyViewHidden
                compasBodyView.alpha = nextUIProps.compasBodyViewHidden ? 0 : 1
            }
        }
        func renderCompasDirectionView() {
            switch (currentUIProps.compasDirectionViewHidden, nextUIProps.compasDirectionViewHidden) {
            case (false, true):
                addAnimation(view: compasDirectionView, keyPath: "opacity") {
                    self.compasDirectionView.isHidden = true
                }
                compasDirectionView.alpha = 0
            case (true, false):
                addAnimation(view: compasDirectionView, keyPath: "opacity") {}
                compasDirectionView.isHidden = false
                compasDirectionView.alpha = 1
            default:
                guard compasDirectionView.layer.animationKeys() == nil else { return }
                compasDirectionView.isHidden = nextUIProps.compasDirectionViewHidden
                compasDirectionView.alpha = nextUIProps.compasDirectionViewHidden ? 0 : 1
            }
        }
        compasDirectionView.transform = nextUIProps.compasDirectionViewTransform
        cameraPanGestureRecognizer.isEnabled = nextUIProps.cameraPanGestureIsEnabled
        
        func renderThumbnailImage() {
            thumbnailImageView.isHidden = nextUIProps.thumbnailImageViewHidden
            
            if let url = nextUIProps.thumbnailImageUrl {
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
            } else if let image = nextUIProps.thumbnailImage {
                thumbnailImageView.isHidden = false
                thumbnailImageView.image = image
            }
        }
        
        if #available(iOS 11.0, *) {
            compassBodyNoLiveTopConstraint.constant = 20
            liveViewTopConstraint.constant = 20
        } else {
            compassBodyNoLiveTopConstraint.constant = prefersStatusBarHidden ? 20 : 40
            liveViewTopConstraint.constant = prefersStatusBarHidden ? 20 : 40
        }
        
        if #available(iOS 11.0, *)  {
            if nextUIProps.controlsViewHidden {
                shouldHideHomeIndicator = true
                setNeedsUpdateOfHomeIndicatorAutoHidden()
            } else {
                shouldHideHomeIndicator = false
                setNeedsUpdateOfHomeIndicatorAutoHidden()
            }
        }
        
        airPlayView.props = AirPlayView.Props(
            icons: AirPlayView.Props.Icons(
                normal: UIImage.init(named: "icon-airplay", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!,
                selected: UIImage.init(named: "icon-airplay-active", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!,
                highlighted: UIImage.init(named: "icon-airplay-active", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!)
        )
        
        renderShadowView()
        renderBottomItemsView()
        renderSeekerView()
        renderDurationLabel()
        renderSideBarView()
        renderPlayButton()
        renderPauseButton()
        renderReplayButton()
        renderRetryButton()
        renderNextButton()
        renderPrevButton()
        renderErrorLabel()
        renderAirplayActiveLabel()
        renderSeekForwardButton()
        renderSeekBackButton()
        renderLiveIndicatorView()
        renderCompasBodyView()
        renderCompasDirectionView()
        renderThumbnailImage()
        renderShowBrandedContentPageButton()
        
        currentUIProps = nextUIProps
    }
    
    //swiftlint:enable function_body_length
    //swiftlint:enable cyclomatic_complexity
    
    /// Alpha for shadow view.
    public var shadowViewAlpha = 0.3 as CGFloat
    /// Shadow view on beneath controls.
    
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
        currentUIProps.playButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func pauseButtonTouched() {
        currentUIProps.pauseButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func replayButtonTouched() {
        currentUIProps.replayButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func nextButtonTouched() {
        currentUIProps.nextButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func prevButtonTouched() {
        currentUIProps.prevButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    private func startSeek(from progress: CGFloat) {
        currentUIProps.startSeekAction.perform(with: .init(progress))
        onUserInteraction?.perform()
        state.isSeekingInProgress = true
    }
    
    private func updateSeek(to progress: CGFloat) {
        currentUIProps.updateSeekAction.perform(with: .init(progress))
        onUserInteraction?.perform()
    }
    
    private func stopSeek(at progress: CGFloat) {
        currentUIProps.stopSeekAction.perform(with: .init(progress))
        onUserInteraction?.perform()
        state.isSeekingInProgress = false
    }
    
    @IBAction private func seekForwardButtonTouched() {
        currentUIProps.seekToSecondsAction.perform(with: currentUIProps.seekerViewCurrentTime.advanced(by: 10))
        onUserInteraction?.perform()
    }
    
    @IBAction private func seekBackButtonTouched() {
        let value = currentUIProps.seekerViewCurrentTime
        currentUIProps.seekToSecondsAction.perform(with: value - min(value, 10))
        onUserInteraction?.perform()
    }
    
    @IBAction private func onEmptySpaceTap(_ sender: UITapGestureRecognizer) {
        onTapEvent?.perform()
    }
    
    @IBAction private func onEmptySpaceDoubleTap(_ sender: UITapGestureRecognizer) {
        currentUIProps.contentFullScreenAction.perform()
    }
    
    @IBAction private func onCameraPan(with recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: recognizer.view)
        recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
        
        currentUIProps.updateCameraAngles.perform(with: translation)
    }
    
    @IBAction private func resetCamera() {
        currentUIProps.resetCameraAngles.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func retry() {
        currentUIProps.retryButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func pipButtonTouched() {
        currentUIProps.pipButtonAction.perform()
        onUserInteraction?.perform()
    }
    
    @IBAction private func settingsButtonTouched() {
        currentUIProps.settingsButtonAction.perform()
    }
    
    @IBAction private func showWebSiteButtonTouched() {
        currentUIProps.brandedContentCommand?.perform(with: self)
        onUserInteraction?.perform()
    }
}

extension DefaultControlsViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return !(touch.view is UIButton)
    }
}
