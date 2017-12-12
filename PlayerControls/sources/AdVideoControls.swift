//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import Foundation
import MediaPlayer

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
                                    tapAction: nil,
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
        props.isLoading ? loadingImageView.enableRotation() : loadingImageView.disableRotation()
        
        seekerView.progress = CGFloat(props.seeker?.currentValue ?? 0.0)
        seekerView.text = props.seeker?.remainingPlayTime ?? ""
        seekerView.isHidden = props.seeker == nil
        seekerView.isCurrentTimeEnabled = false
        remainingPlayTimeLabel.text = props.seeker?.remainingPlayTime
        airplayActiveView.isHidden = props.airplayActiveViewHidden
    }
    
    public struct Props {
        public static let `default` = Props(mainAction: .play(.nop),
                                            seeker: nil,
                                            tapAction: nil,
                                            isLoading: true,
                                            airplayActiveViewHidden: true)
        public let mainAction: MainAction
        public let seeker: Seeker?
        public let tapAction: Command?
        public let isLoading: Bool
        public let airplayActiveViewHidden: Bool
        
        public enum MainAction: Prism {
            case play(Command)
            case pause(Command)
        }
        
        public struct Seeker {
            public let remainingPlayTime: String
            public let currentValue: Double
            public init(remainingPlayTime: String, currentValue: Double) {
                self.remainingPlayTime = remainingPlayTime
                self.currentValue = currentValue
            }
        }
        
        public init(mainAction: MainAction,
                    seeker: Seeker?,
                    tapAction: Command?,
                    isLoading: Bool,
                    airplayActiveViewHidden: Bool) {
            self.mainAction = mainAction
            self.seeker = seeker
            self.tapAction = tapAction
            self.isLoading = isLoading
            self.airplayActiveViewHidden = airplayActiveViewHidden
        }
    }
    
    @IBOutlet private var loadingImageView: UIImageView!
    
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
    
    @IBAction private func viewTouched() { props.tapAction?.perform() }
}

extension AdVideoControls {
    @IBAction func highlightButton(_ button: UIButton) {
        button.tintColor = view.tintColor
    }
    
    @IBAction func normaliseButton(_ button: UIButton) {
        button.tintColor = .white
    }
}
