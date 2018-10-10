//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import UIKit

final class SeekerControlView: UIView {
    @IBInspectable var progress: CGFloat = 0.0 { didSet { setNeedsLayout() } }
    @IBInspectable var buffered: CGFloat = 0.0 { didSet { setNeedsLayout() } }
    @IBInspectable var height: CGFloat = 57 { didSet { setNeedsLayout() } }
    @IBInspectable var text: String = "--:--" { didSet { currentTimeLabel.text = text } }
    @IBInspectable var draggingEnabled: Bool = true { didSet { setNeedsLayout() } }
    
    var cuePoints: [ContentControlsViewController.Props.Progress] = [] { didSet { setNeedsLayout() } }
    
    var isCurrentTimeEnabled: Bool = true {
        didSet {
            guard let _ = currentTimeLabel else { return }
            currentTimeLabel.isHidden = !isCurrentTimeEnabled
            setNeedsLayout()
        }
    }
    
    private var customCurrentTimeColor: UIColor?
    
    override func tintColorDidChange() {
        if customCurrentTimeColor == nil {
            currentTimeLabel.textColor = tintColor
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
    private var cuePointsViews: [UIImageView] = []
    private var cuePointImage: UIImage!
    
    private func setup() {
        /* Initial setup. */ do {
            cuePointImage = createImage(named: "cue-point")
                
            dragControl = UIImageView()
            
            seekerFiller = UIImageView()
            
            seekerBackground = UIImageView()
            seekerBackground.tintColor = .white
            
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
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
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
        
        /* Cue points positioning. */ do {
            if cuePoints.count > cuePointsViews.count {
                for _ in 1...(cuePoints.count - cuePointsViews.count) {
                    let imageView = UIImageView(image: cuePointImage)
                    cuePointsViews.append(imageView)
                    addSubview(imageView)
                }
            }
            
            if cuePoints.count < cuePointsViews.count {
                for _ in 1...(cuePointsViews.count - cuePoints.count) {
                    let imageView = cuePointsViews.removeLast()
                    imageView.removeFromSuperview()
                }
            }
            
            for (index, imageView) in cuePointsViews.enumerated() {
                imageView.isHidden = (imageView.frame.minX < dragControl.frame.minX || imageView.frame.maxX > dragControl.frame.maxX) == false
                imageView.center.x = frame.width * cuePoints[index].value
                imageView.center.y = seekerBackground.center.y
                imageView.sizeToFit()
            }
        }
    }
    struct Callbacks {
        var onDragStarted: CommandWith<CGFloat>?
        var onDragChanged: CommandWith<CGFloat>?
        var onDragFinished: CommandWith<CGFloat>?
    }
    
    var callbacks: Callbacks = Callbacks()
    
    @objc func ringIsDragged(recognizer: SeekGestureRecognizer) {
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
    func updateSeekerViewColors(currentTimeColor: Color?,
                                progressColor: Color?,
                                bufferedColor: Color?,
                                seekerFillerColor: Color?,
                                seekerViewCuePoints: Color?,
                                dragControlColor: Color?) {
        currentTimeLabel.textColor = currentTimeColor?.color ?? tintColor
        seekerFiller.tintColor = seekerFillerColor?.color ?? tintColor
        seekerBackground.tintColor = progressColor?.color ?? .white
        seekerBufferBackground.tintColor = bufferedColor?.color ?? tintColor
        dragControl.tintColor = dragControlColor?.color ?? tintColor
        cuePointsViews.forEach { $0.tintColor = seekerViewCuePoints?.color ?? tintColor }
        
        customCurrentTimeColor = currentTimeColor?.color
    }
}

extension UIImageView {
    var alignmentRect: CGRect { return alignmentRect(forFrame: frame) }
}
