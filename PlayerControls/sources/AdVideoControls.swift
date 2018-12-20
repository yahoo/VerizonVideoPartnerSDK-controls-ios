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
    /// AirPlay active view. Shows when AirPlay is active
    @IBOutlet private var airplayActiveView: AirPlayActiveView!
    
    @IBOutlet public weak var containerView: UIView!
    
    public var props: Props = Props(mainAction: .play(.nop),
                                    seeker: nil,
                                    click: .nop,
                                    isLoading: true,
                                    airplayActiveViewHidden: true) {
        didSet {
            guard isViewLoaded else { return }
            view.setNeedsLayout()
        }
    }
    
    public init() {
        super.init(nibName: "AdVideoControls",
                   bundle: Bundle(for: type(of: self)))
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
    }
    
    public struct Props: Codable {
        public static let `default` = Props(mainAction: .play(.nop),
                                            seeker: nil,
                                            click: .nop,
                                            isLoading: true,
                                            airplayActiveViewHidden: true)
        public let mainAction: MainAction
        public let seeker: Seeker?
        public let click: CommandWith<SFSafariViewControllerDelegate>
        public let isLoading: Bool
        public let airplayActiveViewHidden: Bool
        
        public enum MainAction: Prism, AutoCodable {
            case play(Command)
            case pause(Command)
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
                    airplayActiveViewHidden: Bool) {
            self.mainAction = mainAction
            self.seeker = seeker
            self.click = click
            self.isLoading = isLoading
            self.airplayActiveViewHidden = airplayActiveViewHidden
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
    
    @IBAction private func viewTouched() {
        props.click.perform(with: self)
    }
}

extension AdVideoControls {
    @IBAction func highlightButton(_ button: UIButton) {
        button.tintColor = view.tintColor
    }
    
    @IBAction func normaliseButton(_ button: UIButton) {
        button.tintColor = .white
    }
}

extension AdVideoControls: SFSafariViewControllerDelegate {
    @available(iOS 9.0, *)
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        props.click.perform(with: self)
    }
}
