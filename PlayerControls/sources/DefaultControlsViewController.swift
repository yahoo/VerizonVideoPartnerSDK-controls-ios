import MediaPlayer
//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

/// This class contains all controls that
/// are defined for Player View Controller default UI.
/// You can replace actions with your own
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
    
    public var sidebarProps: SideBarView.Props = [] {
        didSet {
            sideBarView.props = sidebarProps.map { [weak self] in
                var props = $0
                let handler = props.handler
                props.handler = {
                    self?.onUserInteraction?()
                    handler()
                }
                return props
            }
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        seekerView.callbacks.onDragStarted = { [unowned self] value in
            self.startSeek(from: value)
        }
        seekerView.callbacks.onDragChanged = { [unowned self] value in
            self.updateSeek(to: value)
        }
        seekerView.callbacks.onDragFinished = { [unowned self] value in
            self.stopSeek(at: value)
        }
    }
    
    var task: URLSessionDataTask?
    
    var uiProps: UIProps = UIProps(props: .noPlayer, controlsViewVisible: false)
    //swiftlint:disable function_body_length
    //swiftlint:disable cyclomatic_complexity
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        uiProps = UIProps(props: props,
                          controlsViewVisible: controlsShouldBeVisible)
        
        controlsView.isHidden = uiProps.controlsViewHidden
        isLoading = uiProps.loading
        
        playButton.isHidden = uiProps.playButtonHidden
        pauseButton.isHidden = uiProps.pauseButtonHidden
        replayButton.isHidden = uiProps.replayButtonHidden
        
        nextButton.isHidden = uiProps.nextButtonHidden
        nextButton.isEnabled = uiProps.nextButtonEnabled
        prevButton.isHidden = uiProps.prevButtonHidden
        prevButton.isEnabled = uiProps.prevButtonEnabled
        
        seekerView.isHidden = uiProps.seekerViewHidden
        seekerView.updateCurrentTime(text: uiProps.seekerViewCurrentTimeText)
        seekerView.progress = uiProps.seekerViewProgress
        seekerView.buffered = uiProps.seekerViewBuffered

        let constant = traitCollection.userInterfaceIdiom == .pad ? 70 : 63
        bottomSeekBarConstraint.constant = uiProps.seekbarPositionedAtBottom
            ? 13
            : CGFloat(constant)
        
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
        durationTextLabel.isHidden = uiProps.durationTextHidden
        
        ccTextLabel.isHidden = uiProps.subtitlesTextLabelHidden
        ccTextLabel.text = uiProps.subtitlesTextLabelText

        visibleControlsSubtitlesConstraint.constant = uiProps.controlsViewHidden ? 30 : 110
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
        }
        
        retryButton.isHidden = uiProps.retryButtonHidden
        errorLabel.isHidden = uiProps.errorLabelHidden
        errorLabel.text = uiProps.errorLabelText
        
        pipButton.isHidden = uiProps.pipButtonHidden
        pipButton.isEnabled = uiProps.pipButtonEnabled
        
        settingsButton.isHidden = uiProps.settingsButtonHidden
        settingsButton.isEnabled = uiProps.settingsButtonEnabled
        
        liveIndicationView.isHidden = uiProps.liveIndicationViewIsHidden
        liveDotLabel.textColor = uiProps.liveDotColor ?? view.tintColor
        
        airplayActiveLabel.isHidden = uiProps.airplayActiveLabelHidden
        airPlayView.props = AirPlayView.Props(
            icons: AirPlayView.Props.Icons(
                normal: UIImage.init(named: "icon-airplay", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!,
                selected: UIImage.init(named: "icon-airplay-active", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!,
                highlighted: UIImage.init(named: "icon-airplay-active", in: Bundle(for: AirPlayView.self), compatibleWith: nil)!)
        )
        airPlayView.isHidden = uiProps.airplayButtonHidden
    }
    
    //Code below makes expected layout on all devices, including iPhone X without changes in interface in xib file, which can be made only without iOS 8 support.
    public override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        let statusBarSpacing: CGFloat = 20.0
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            controlsView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            controlsView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
            controlsView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            controlsView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            
            shadowView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            shadowView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            shadowView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            shadowView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            
            liveIndicationView.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10).isActive = true
            liveIndicationView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10).isActive = true
            
            visibleControlsSubtitlesConstraint.constant = controlsView.isHidden
                ? 30 + view.safeAreaInsets.bottom
                : 110 + view.safeAreaInsets.bottom
        } else if #available(iOS 9, *) {
            controlsView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            controlsView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            controlsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            controlsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            
            shadowView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        } else {
            NSLayoutConstraint(item: controlsView, attribute: .top, relatedBy: .equal, toItem: view,
                               attribute: .top, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: controlsView, attribute: .bottom, relatedBy: .equal, toItem: view,
                               attribute: .bottom, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: controlsView, attribute: .leading, relatedBy: .equal, toItem: view,
                               attribute: .leading, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: controlsView, attribute: .trailing, relatedBy: .equal, toItem: view,
                               attribute: .trailing, multiplier: 1, constant: 0).isActive = true
            
            NSLayoutConstraint(item: shadowView, attribute: .top, relatedBy: .equal, toItem: view,
                               attribute: .top, multiplier: 1, constant: 0).isActive = true
            
            NSLayoutConstraint(item: liveIndicationView, attribute: .top, relatedBy: .equal, toItem: view,
                               attribute: .top, multiplier: 1, constant: statusBarSpacing).isActive = true
        }
        
    }
    
    ///Method that hides or shows iPhone X home indicator based on controlsView hidden status.
    @available(iOS 11.0, *)
    override public func prefersHomeIndicatorAutoHidden() -> Bool
    {
        if controlsView.isHidden {
            return true
        } else {
            return false
        }
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
    
    public var onPlayEvent: Action<Void>?
    public var onPauseEvent: Action<Void>?
    public var onTapEvent: Action<Void>?
    public var onUserInteraction: Action<Void>?
    
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
        case (false, true): onPlayEvent?()
        case (true, false): onPauseEvent?()
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
            show: { weakSelf?.showControls() },
            hide: { weakSelf?.hideControls() })
        
        let visibilityController = ControlsPresentationController(controls: controls)
        
        onUserInteraction = visibilityController.resetTimer
        onTapEvent = visibilityController.tap
        onPlayEvent = visibilityController.play
        onPauseEvent = visibilityController.pause
    }
    
    @IBAction private func playButtonTouched() {
        uiProps.playButtonAction()
        onUserInteraction?()
    }
    
    @IBAction private func pauseButtonTouched() {
        uiProps.pauseButtonAction()
        onUserInteraction?()
    }
    
    @IBAction private func replayButtonTouched() {
        uiProps.replayButtonAction()
        onUserInteraction?()
    }
    
    @IBAction private func nextButtonTouched() {
        uiProps.nextButtonAction()
        onUserInteraction?()
    }
    
    @IBAction private func prevButtonTouched() {
        uiProps.prevButtonAction()
        onUserInteraction?()
    }
    
    private func startSeek(from progress: CGFloat) {
        uiProps.startSeekAction(.init(progress))
        onUserInteraction?()
    }
    
    private func updateSeek(to progress: CGFloat) {
        uiProps.updateSeekAction(.init(progress))
        onUserInteraction?()
    }
    
    private func stopSeek(at progress: CGFloat) {
        uiProps.stopSeekAction(.init(progress))
        onUserInteraction?()
    }
    
    @IBAction private func seekForwardButtonTouched() {
        uiProps.seekToSecondsAction(uiProps.seekerViewCurrentTime.advanced(by: 10))
        onUserInteraction?()
    }
    
    @IBAction private func seekBackButtonTouched() {
        let value = uiProps.seekerViewCurrentTime
        uiProps.seekToSecondsAction(value - min(value, 10))
        onUserInteraction?()
    }
    
    @IBAction private func onEmptySpaceTap() {
        onTapEvent?()
    }
    
    @IBAction private func onCameraPan(with recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: recognizer.view)
        recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
        
        uiProps.updateCameraAngles(translation)
    }
    
    @IBAction private func resetCamera() {
        uiProps.resetCameraAngles()
        onUserInteraction?()
    }
    
    @IBAction private func retry() {
        uiProps.retryButtonAction()
        onUserInteraction?()
    }
    
    @IBAction private func pipButtonTouched() {
        uiProps.pipButtonAction()
        onUserInteraction?()
    }
    
    @IBAction private func settingsButtonTouched() {
        uiProps.settingsButtonAction()
    }
}
