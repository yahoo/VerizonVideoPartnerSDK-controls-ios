//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.
import Foundation
import UIKit

func zip<A, B>(_ arrayA: [A], _ arrayB: [B]) -> [(A?, B?)] {
    var result = Array(repeating:(nil, nil),
                       count: max(arrayA.count, arrayB.count)) as [(A?, B?)]
    
    for (index, a) in arrayA.enumerated() {
        result[index].0 = a
    }
    
    for (index, b) in arrayB.enumerated() {
        result[index].1 = b
    }
    
    return result
}

/// Right side bar view.
/// Fully configurable by 'SideBar.ButtonProps'
public final class SideBarView: UIView {
    public typealias Props = [ButtonProps]
    /// Side bar properties that will be rendered.
    public struct ButtonProps {
        /// Corresponds to UIButton 'enabled' property.
        public var isEnabled: Bool
        /// Corresponds to UIButton 'selected' property.
        public var isSelected: Bool
        
        /// Button icons.
        public var icons: Icons
        public struct Icons {
            /// Corresponds to UIButton 'normalImage' property.
            public var normal: UIImage
            /// Corresponds to UIButton 'selectedImage' property.
            public var selected: UIImage?
            /// Corresponsd to UIButton 'highlightedImage' property.
            public var highlighted: UIImage?
            
            public init(normal: UIImage,
                        selected: UIImage?,
                        highlighted: UIImage?) {
                self.normal = normal
                self.selected = selected
                self.highlighted = highlighted
            }
        }
        
        public var accessibility: Accessibility
        public struct Accessibility {
            public static let empty = Accessibility()
            /// Corresponds to UIButton 'accessibilityLabel' property.
            public var label: String?
            /// Corresponds to UIButton 'accessibilityHint' property.
            public var hint: String?
            /// Corresponds to UIButton 'accessibilityTraits' property.
            public var traits: UIAccessibilityTraits = UIAccessibilityTraits.button
        }
        
        /// Touch handler for button.
        public var handler: Command
        
        /// Public constructor.
        public init(isEnabled: Bool,
                    isSelected: Bool,
                    icons: Icons,
                    handler: Command,
                    accessibility: Accessibility) {
            self.isEnabled = isEnabled
            self.isSelected = isSelected
            self.icons = icons
            self.handler = handler
            self.accessibility = accessibility
        }        
        
        /// Empty button for space alignment
        public static let empty = ButtonProps(
            isEnabled: false,
            isSelected: false,
            icons: .init(
                normal: .init(),
                selected: nil,
                highlighted: nil),
            handler: .nop,
            accessibility: .empty)
    }
    var buttons: [UIButton] = []
    
    @objc func sideButtonClicked(sender: UIButton) {
        guard let index = buttons.index(of: sender) else {
            fatalError("Not found button in array!")
        }
        props[index].handler.perform()
    }
    
    var props: SideBarView.Props = [] {
        didSet { setNeedsLayout() }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        let buttonConfiguration = PlayerControls.zip(buttons, props)
        
        func addButton() -> UIButton {
            let button = UIButton()
            button.addTarget(self,
                             action: #selector(sideButtonClicked),
                             for: .touchUpInside)
            button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            buttons.append(button)
            addSubview(button)
            
            return button
        }
        
        func remove(button: UIButton?) {
            guard let button = button else { return }
            guard let index = buttons.index(of: button) else {
                fatalError("Not found button!")
            }
            
            button.removeFromSuperview()
            buttons.remove(at: index)
        }
        
        for (button, prop) in buttonConfiguration {
            if let prop = prop {
                let button = button ?? addButton()
                button.isSelected = prop.isSelected
                button.isEnabled = prop.isEnabled
                button.setImage(prop.icons.normal, for: .normal)
                button.setImage(prop.icons.selected, for: .selected)
                button.setImage(prop.icons.highlighted, for: .highlighted)
                button.accessibilityLabel = prop.accessibility.label
                button.accessibilityHint = prop.accessibility.hint
                button.accessibilityTraits = prop.accessibility.traits
                button.sizeToFit()
            } else {
                remove(button: button)
            }
        }
        let spacingY = SideBarView.verticalSpacingForButtons(
            withHeights: buttons.map { $0.bounds.size.height },
            in: bounds.height)
        let origins = SideBarView.buttonOrigins(
            buttonSize: buttons.map { $0.frame.size },
            parentSize: bounds.size,
            spacingY: spacingY)
        for (index, origin) in origins.enumerated() {
            buttons[index].frame.origin = origin
        }
        invalidateIntrinsicContentSize()
    }
    
    public override var intrinsicContentSize: CGSize {
        let maxWidth = buttons.reduce(CGFloat.leastNormalMagnitude) { max($0, $1.frame.width) }
        
        return CGSize(width: maxWidth, height: UIView.noIntrinsicMetric)
    }
}

extension SideBarView {
    
    static func buttonOrigins(buttonSize: [CGSize],
                              parentSize: CGSize,
                              spacingY: CGFloat) -> [CGPoint] {
        var offsetY = max(spacingY, 0) as CGFloat
        var result = Array(repeating: CGPoint(x: 0, y: 0),
                           count: buttonSize.count)
        for (index, button) in buttonSize.enumerated() {
            result[index] = CGPoint(
                x: parentSize.width - button.width,
                y: offsetY)
            offsetY += spacingY
            offsetY += button.height
        }
        return result
    }
    
    static func verticalSpacingForButtons(withHeights
        heights: [CGFloat],
                                          in containerHeight: CGFloat) -> CGFloat {
        guard heights.count > 0 else { return 0 }
        let totalSpace = (containerHeight - heights.reduce(0.0, +))
        let spacingCount = totalSpace < 0
            // Top, bottom spaces have to be ignored.
            ? CGFloat(heights.count - 1)
                // Top, bottom spaces are added.
            : CGFloat(heights.count + 1)
        guard spacingCount > 0 else { return 0 }
        return totalSpace / spacingCount
    }
}


