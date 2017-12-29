//  Copyright © 2017 Oath. All rights reserved.
import UIKit
import MediaPlayer

#if (arch(i386) || arch(x86_64)) && os(iOS)
    typealias AirPlayButton = AirPlayMock
#else
    typealias AirPlayButton = MPVolumeView
#endif

public final class AirPlayView: UIView {
    public struct Props {
        public struct Icons {
            public var normal: UIImage
            public var selected: UIImage?
            public var highlighted: UIImage?
            
            public init(normal: UIImage,
                        selected: UIImage?,
                        highlighted: UIImage?) {
                self.normal = normal
                self.selected = selected
                self.highlighted = highlighted
            }
        }
        
        public static let empty = Props(
            icons: .init(
                normal: UIImage(),
                selected: nil,
                highlighted: nil))
        
        public var icons: Icons
        
        public init(icons: Icons) {
            self.icons = icons
        }
    }
    
    var props: Props = Props.empty {
        didSet { setNeedsLayout() }
    }
    private let volumeView = AirPlayButton()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        volumeView.isOpaque = true
        volumeView.showsVolumeSlider = false
        addSubview(volumeView)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        volumeView.frame = bounds
        volumeView.setRouteButtonImage(props.icons.highlighted, for: .highlighted)
        volumeView.setRouteButtonImage(props.icons.normal, for: .normal)
        volumeView.setRouteButtonImage(props.icons.selected, for: .selected)
    }
}

class AirPlayMock: UIButton {
    
    var showsVolumeSlider: Bool = false
    
    func setRouteButtonImage(_ image: UIImage?, for controlState: UIControlState) {
        setImage(image, for: controlState)
    }
}
