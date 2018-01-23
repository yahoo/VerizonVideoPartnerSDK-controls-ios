//  Copyright © 2017 Oath. All rights reserved.
import UIKit

final class SeekerControlView: UIView {
    @IBInspectable var progress: CGFloat = 0.0 { didSet { setNeedsLayout() } }
    @IBInspectable var buffered: CGFloat = 0.0 { didSet { setNeedsLayout() } }
    @IBInspectable var height: CGFloat = 57 { didSet { setNeedsLayout() } }
    @IBInspectable var text: String = "--:--" { didSet { currentTimeLabel.text = text } }
    @IBInspectable var draggingEnabled: Bool = true { didSet { setNeedsLayout() } }
    
    var isCurrentTimeEnabled: Bool = true {
        didSet {
            guard let _ = currentTimeLabel else { return }
            currentTimeLabel.isHidden = !isCurrentTimeEnabled
            setNeedsLayout()
        }
    }
    
    private var width: CGFloat {
        return frame.width - dragControl.alignmentRect.width
    }
    
    private var dragControlX: CGFloat { return progress * width }
    private var bufferX: CGFloat { return buffered * width }
    
    private var seekerFiller: UIImageView!
    private var seekerBackground: UIImageView!
    private var seekerBufferBackground: UIImageView!
    private var dragControl: UIImageView!
    private var currentTimeLabel: UILabel!
    
    override func tintColorDidChange() {
        currentTimeLabel.textColor = tintColor
    }
    
    private func setup() {
        /* Initial setup. */ do {
            dragControl = UIImageView()
            dragControl.isAccessibilityElement = true
            dragControl.accessibilityLabel = "Seek bar drag control"
            dragControl.accessibilityTraits = UIAccessibilityTraitAdjustable
            
            seekerFiller = UIImageView()
            seekerFiller.isAccessibilityElement = true
            seekerFiller.accessibilityLabel = "Seek bar"
            seekerFiller.accessibilityTraits = UIAccessibilityTraitAdjustable
            
            seekerBackground = UIImageView()
            seekerBackground.tintColor = .white
            seekerBackground.isAccessibilityElement = true
            seekerBackground.accessibilityLabel = "Seek bar"
            seekerBackground.accessibilityTraits = UIAccessibilityTraitAdjustable
            
            seekerBufferBackground = UIImageView()
            seekerBufferBackground.alpha = 0.6
            
            currentTimeLabel = UILabel()
            currentTimeLabel.font = UIFont(name: "Helvetica", size: 10.0)
            currentTimeLabel.textColor = tintColor
            
            addSubview(seekerFiller)
            addSubview(seekerBackground)
            addSubview(seekerBufferBackground)
            addSubview(dragControl)
            addSubview(currentTimeLabel)
        }
        
        guard draggingEnabled else { return }
        
        /* Configure pan gesture recognizer. */ do {
            let dragRecognizer = SeekGestureRecognizer(
                target: self, action: #selector(ringIsDragged))
            addGestureRecognizer(dragRecognizer)
            isUserInteractionEnabled = true
        }        
    }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder)
        setup()
    }
    
    override init(frame: CGRect) { super.init(frame: frame)
        setup()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIViewNoIntrinsicMetric, height: height)
    }
        
    override func layoutSubviews() { //swiftlint:disable:this function_body_length
        super.layoutSubviews()
        
        if dragControl.image == nil && draggingEnabled {
            dragControl.image = createImage(named: "icon-handle")
        }
        
        if seekerFiller.image == nil {
            seekerFiller.image = createImage(named: "seekbar-played")
        }

        if seekerBackground.image == nil {
            seekerBackground.image = createImage(named: "seekbar-full")
        }
        
        if seekerBufferBackground.image == nil {
            seekerBufferBackground.image = createImage(named: "seekbar-full")
        }
        
        dragControl.accessibilityValue = currentTimeLabel.text
        seekerFiller.accessibilityValue = currentTimeLabel.text
        seekerBackground.accessibilityValue = currentTimeLabel.text
        
        seekerFiller.sizeToFit()
        seekerBackground.sizeToFit()
        seekerBufferBackground.sizeToFit()
        dragControl.sizeToFit()
        currentTimeLabel.sizeToFit()
            
        /* Calculate drag position. */ do {
            dragControl.frame.origin.x = -dragControl.alignmentRectInsets.left + dragControlX
            dragControl.center.y = bounds.maxY - dragControl.bounds.midY
        }
        
        /* Calculate current time label position. */ do {
            let verticalSpacing: CGFloat = traitCollection.horizontalSizeClass == .regular ? 9 : 3
            let minValue = currentTimeLabel.frame.width / 2
            let maxValue = frame.size.width - minValue
            
            currentTimeLabel.center.x = min(max(dragControl.center.x, minValue), maxValue)
            currentTimeLabel.frame.origin.y = dragControl.alignmentRect.minY
                - verticalSpacing
                - currentTimeLabel.frame.size.height
        }
        
        /* Calculate seeker filler view. */ do {
            seekerFiller.frame.origin.x = 0
            seekerFiller.center.y = dragControl.center.y
            seekerFiller.frame.size.width = dragControl.alignmentRect.minX
        }
        
        /* Calculate seeker buffer background*/ do {
            seekerBufferBackground.frame.origin.x = dragControl.alignmentRect.maxX
            seekerBufferBackground.center.y = dragControl.center.y
            seekerBufferBackground.frame.size.width =
                max(0, width * buffered
                    - dragControl.alignmentRect.maxX
                    + dragControl.alignmentRect.width
            )
        }
        
        /* Calculate seeker background view. */ do {
            seekerBackground.frame.origin.x = dragControl.alignmentRect.maxX
            seekerBackground.center.y = dragControl.center.y
            seekerBackground.frame.size.width = frame.width - seekerBackground.frame.origin.x
        }
    }
    struct Callbacks {
        var onDragStarted: CommandWith<CGFloat>?
        var onDragChanged: CommandWith<CGFloat>?
        var onDragFinished: CommandWith<CGFloat>?
    }
    
    var callbacks: Callbacks = Callbacks()
    
    func ringIsDragged(recognizer: SeekGestureRecognizer) {
        switch recognizer.state {
        case .began: callbacks.onDragStarted?.perform(with: recognizer.progress)
        case .changed: callbacks.onDragChanged?.perform(with: recognizer.progress)
        case .ended, .possible: callbacks.onDragFinished?.perform(with: recognizer.progress)
        default: break }
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        currentTimeLabel.text = text
        layoutIfNeeded()
    }
    
    func update(withProgress progress: Float) {
        self.progress = CGFloat(progress)
    }
    
    func updateCurrentTime(text: String) {
        currentTimeLabel.text = text
        currentTimeLabel.sizeToFit()
    }
}

extension UIImageView {
    var alignmentRect: CGRect { return alignmentRect(forFrame: frame) }
}
