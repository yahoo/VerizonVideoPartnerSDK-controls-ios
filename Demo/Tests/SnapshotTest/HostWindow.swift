//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit

@available(iOS 10.0, *)
public class HostWindow: UIWindow {
    
    public var presentation: Presentation
    private var traits: UITraitCollection
    
    override public var traitCollection: UITraitCollection {
        return traits
    }
    
    
    public init(presentation: Presentation, context: Context = .init()) {
        self.presentation = presentation
        self.traits = UITraitCollection(traitsFrom: [presentation.traitCollection, context.getTraits()])
        super.init(frame: presentation.size.asRect)
        self.mask = presentation.mask
        self.mask?.frame = self.bounds
    }
    public struct Context {
        var layoutDirection = UITraitEnvironmentLayoutDirection.unspecified
        var contentSizeCategory = UIContentSizeCategory.unspecified
        
        public func getTraits() -> UITraitCollection {
            return UITraitCollection(traitsFrom: [UITraitCollection(layoutDirection: self.layoutDirection),
                                                  UITraitCollection(preferredContentSizeCategory: self.contentSizeCategory)])
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
