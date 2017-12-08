//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit

///Custom window contains a presentation variable, that is designed to represent all existing device screens in every possible view, including different orientations and split view.
public class HostWindow: UIWindow {
    
    public var presentation: Presentation
    private var traits: UITraitCollection
    
    override public var traitCollection: UITraitCollection {
        return traits
    }
    
    @available(iOS 9.0, *)
    public init(presentation: Presentation) {
        self.presentation = presentation
        self.traits = UITraitCollection(traitsFrom: [presentation.traitCollection])
        super.init(frame: presentation.size.asRect)
        self.mask = presentation.mask
        self.mask?.frame = self.bounds
    }
    
    @available(iOS 10.0, *)
    public init(presentation: Presentation, context: Context = .init()) {
        self.presentation = presentation
        self.traits = UITraitCollection(traitsFrom: [presentation.traitCollection, context.traitCollection])
        super.init(frame: presentation.size.asRect)
        self.mask = presentation.mask
        self.mask?.frame = self.bounds
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@available(iOS 10.0, *)
public struct Context {
    public var layoutDirection: UITraitEnvironmentLayoutDirection
    public var contentSizeCategory: UIContentSizeCategory
    public var name: String
    public var traitCollection: UITraitCollection {
        return UITraitCollection(traitsFrom: [UITraitCollection(layoutDirection: self.layoutDirection),
                                              UITraitCollection(preferredContentSizeCategory: self.contentSizeCategory)])
    }
    
    public init(layoutDirection: UITraitEnvironmentLayoutDirection = .unspecified, contentSizeCategory: UIContentSizeCategory = .unspecified, name: String = "") {
        self.layoutDirection = layoutDirection
        self.contentSizeCategory = contentSizeCategory
        self.name = name
    }
}
