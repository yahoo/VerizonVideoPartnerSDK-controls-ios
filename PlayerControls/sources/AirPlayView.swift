//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import UIKit
import MediaPlayer

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
    let volumeView = MPVolumeView()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        volumeView.isOpaque = true
        volumeView.showsVolumeSlider = false
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        volumeView.frame = bounds
        volumeView.setRouteButtonImage(props.icons.highlighted, for: .highlighted)
        volumeView.setRouteButtonImage(props.icons.normal, for: .normal)
        volumeView.setRouteButtonImage(props.icons.selected, for: .selected)
        
        if volumeView.superview != self {
            volumeView.removeFromSuperview()
            addSubview(volumeView)
        }
    }
}
