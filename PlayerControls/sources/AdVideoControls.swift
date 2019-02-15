//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation
import MediaPlayer
import SafariServices

/// This class contains all controls that are used
/// for advertisement video playback.
/// You are free to override functionality
/// or adjust styling of components.
public final class AdVideoControls: UIViewController {
    /// Play ad button.
    @IBOutlet private var playButton: UIButton!
    /// Pause ad button.
    @IBOutlet private var pauseButton: UIButton!
    /// Remaining ad play time label.
    @IBOutlet private var remainingPlayTimeLabel: UILabel!
    /// Seeker Control View. Dragging is disabled.
    @IBOutlet private var seekerView: SeekerControlView!
    /// Ad title label.
    @IBOutlet private var titleLabel: UILabel!
    /// Skip button. Not yet implemented, hidden by default.
    @IBOutlet private var skipButton: UIButton!
    /// AirPlay active view. Shows when AirPlay is active.
    @IBOutlet private var airplayActiveView: AirPlayActiveView!
    /// Ad Skip button to skip an active ad.
    @IBOutlet private var adSkipButton: UIButton!
    
    @IBOutlet public weak var containerView: UIView!
    
    public var props: Props = Props(mainAction: .play(.nop),
                                    seeker: nil,
                                    click: .nop,
                                    isLoading: true,
                                    airplayActiveViewHidden: true,
                                    adSkipState: .unavailable) {
        didSet {
            guard isViewLoaded else { return }
            view.setNeedsLayout()
        }
    }
    
    public init() {
        super.init(nibName: "AdVideoControls",
                   bundle: controlsBundle(for: type(of: self)))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        playButton.isHidden = props.mainAction.pause != nil
        
        pauseButton.isHidden = !playButton.isHidden
        
        loadingImageView.isHidden = !props.isLoading
        loadingImageView.isLoading = props.isLoading
        
        seekerView.progress = CGFloat(props.seeker?.currentValue ?? 0.0)
        seekerView.text = props.seeker?.remainingPlayTime ?? ""
        seekerView.isHidden = props.seeker == nil
        seekerView.isCurrentTimeEnabled = false
        seekerView.accessibilityLabel = props.seeker?.accessibilityLabel ?? ""
        remainingPlayTimeLabel.text = props.seeker?.remainingPlayTime
        airplayActiveView.isHidden = props.airplayActiveViewHidden
        
        adSkipButton.isHidden = props.adSkipState.isUnavailable
        
        adSkipButton.isEnabled = props.adSkipState.available != nil
        
        switch props.adSkipState {
        case .unavailable: break
        case .available:
            adSkipButton.titleLabel?.alpha = 1
            adSkipButton.setTitle("Skip", for: .normal)
        case .awaiting(let time):
            adSkipButton.titleLabel?.alpha = 0.5
            adSkipButton.setTitle("Skip in \(time)", for: .normal)
        }
    }
    
    public struct Props: Codable {
        public static let `default` = Props(mainAction: .play(.nop),
                                            seeker: nil,
                                            click: .nop,
                                            isLoading: true,
                                            airplayActiveViewHidden: true,
                                            adSkipState: .unavailable)
        public let mainAction: MainAction
        public let seeker: Seeker?
        public let click: CommandWith<SFSafariViewControllerDelegate>
        public let isLoading: Bool
        public let airplayActiveViewHidden: Bool
        public let adSkipState: AdSkipState
        
        public enum MainAction: Prism, AutoCodable {
            case play(Command)
            case pause(Command)
        }
        
        public enum AdSkipState: Prism, AutoCodable {
            case unavailable, available(Command), awaiting(Int)
        }
        
        public struct Seeker: Codable {
            public let remainingPlayTime: String
            public let currentValue: Double
            public let accessibilityLabel: String
            public init(remainingPlayTime: String, currentValue: Double, accessibilityLabel: String) {
                self.remainingPlayTime = remainingPlayTime
                self.currentValue = currentValue
                self.accessibilityLabel = accessibilityLabel
            }
        }
        
        public init(mainAction: MainAction,
                    seeker: Seeker?,
                    click: CommandWith<SFSafariViewControllerDelegate>,
                    isLoading: Bool,
                    airplayActiveViewHidden: Bool,
                    adSkipState: AdSkipState) {
            self.mainAction = mainAction
            self.seeker = seeker
            self.click = click
            self.isLoading = isLoading
            self.airplayActiveViewHidden = airplayActiveViewHidden
            self.adSkipState = adSkipState
        }
    }
    
    @IBOutlet private var loadingImageView: LoadingImageView!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.tintColor = UIColor(
            red: 1.0, green: 198.0 / 255.0, blue: 0, alpha: 1.0)
    }
    
    /// Play video button command. Replace if you need custom behavior.
    @IBAction private func playButtonTouched() {
        props.mainAction.play?.perform()
    }
    
    /// Pause video button command. Replace if you need custom behavior.
    @IBAction private func pauseButtonTouched() {
        props.mainAction.pause?.perform()
    }
    
    /// Ad Clickthrough command.
    @IBAction private func viewTouched() {
        props.click.perform(with: self)
    }
    
    /// Ad Skip button command.
    @IBAction private func adSkipButtonTouched() {
        props.adSkipState.available?.perform()
    }
}

extension AdVideoControls {
    @IBAction func highlightButton(_ button: UIButton) {
        button.tintColor = view.tintColor
        button.setTitleColor(view.tintColor, for: .highlighted)
    }
    
    @IBAction func normaliseButton(_ button: UIButton) {
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
    }
}

extension AdVideoControls: SFSafariViewControllerDelegate {
    @available(iOS 9.0, *)
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        props.click.perform(with: self)
    }
}
