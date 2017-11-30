//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import Foundation

extension UITraitCollection: ExpressibleByArrayLiteral {
    
    public typealias ArrayLiteralElement = UITraitCollection
    
    public init(arrayLiteral elements: ArrayLiteralElement...){
        self.init(traitsFrom: elements)
    }
   
     @available(iOS 10.0, *)
    public enum interfaceIdiom {
        public static let phone = UITraitCollection(userInterfaceIdiom: .phone)
        public static let pad = UITraitCollection(userInterfaceIdiom: .pad)
        public static let tv = UITraitCollection(userInterfaceIdiom: .tv)
        public static let carPlay = UITraitCollection(userInterfaceIdiom: .carPlay)
    }
    
    @available(iOS 10.0, *)
    public enum layoutDirection {
        public static let leftToRight = UITraitCollection(layoutDirection: .leftToRight)
        public static let rightToLeft = UITraitCollection(layoutDirection: .rightToLeft)
        public static let unspecified = UITraitCollection(layoutDirection: .unspecified)
    }
    
    public enum displayScale {
        public static let retina = UITraitCollection(displayScale: 2.0)
        public static let nonRetina = UITraitCollection(displayScale: 1.0)
        public static let unspecified = UITraitCollection(displayScale: 0.0)
    }
    
    public enum horizontalSizeClass {
        public static let regular = UITraitCollection(horizontalSizeClass: .regular)
        public static let compact = UITraitCollection(horizontalSizeClass: .compact)
        public static let unspecified = UITraitCollection(horizontalSizeClass: .unspecified)
    }
    
    public enum verticalSizeClass {
         public static let regular = UITraitCollection(verticalSizeClass: .regular)
         public static let compact = UITraitCollection(verticalSizeClass: .compact)
         public static let unspecified = UITraitCollection(verticalSizeClass: .unspecified)
    }
    
    @available(iOS 9.0, *)
    public enum forceTouch {
        public static let unavailable = UITraitCollection(forceTouchCapability: .unavailable)
        public static let available = UITraitCollection(forceTouchCapability: .available)
        public static let unknown = UITraitCollection(forceTouchCapability: .unknown)
    }
    
    @available(iOS 10.0, *)
    public enum contentSizeCategory {
        public static let unspecified = UITraitCollection(preferredContentSizeCategory: .unspecified)
        public static let extraSmall = UITraitCollection(preferredContentSizeCategory: .extraSmall)
        public static let extraLarge = UITraitCollection(preferredContentSizeCategory: .extraLarge)
        public static let small = UITraitCollection(preferredContentSizeCategory: .small)
        public static let medium = UITraitCollection(preferredContentSizeCategory: .medium)
        public static let large = UITraitCollection(preferredContentSizeCategory: .large)
        public static let extraExtraSmall = UITraitCollection(preferredContentSizeCategory: .extraExtraLarge)
        public static let extraExtraExtraLarge = UITraitCollection(preferredContentSizeCategory: .extraExtraExtraLarge)
        public static let accessibilityMedium = UITraitCollection(preferredContentSizeCategory: .accessibilityMedium)
        public static let accessibilityLarge = UITraitCollection(preferredContentSizeCategory: .accessibilityLarge)
        public static let accessibilityExtraLarge = UITraitCollection(preferredContentSizeCategory: .accessibilityExtraLarge)
        public static let accessibilityExtraExtraLarge = UITraitCollection(preferredContentSizeCategory: .accessibilityExtraExtraLarge)
        public static let accessibilityExtraExtraExtraLarge = UITraitCollection(preferredContentSizeCategory: .accessibilityExtraExtraExtraLarge)
    }
    
    @available(iOS 10.0, *)
    public enum displayGamut {
        public static let unspecified = UITraitCollection(displayGamut: .unspecified)
        public static let SRGB = UITraitCollection(displayGamut: .SRGB)
        public static let P3 = UITraitCollection(displayGamut: .P3)
    }

}

extension CGSize {
    
    enum iPhone {
        static let SE = CGSize(width: 320, height: 568)
        static let X = CGSize(width: 375, height: 812)
        static let Eight = CGSize(width: 375, height: 667)
        static let EightPlus = CGSize(width: 414, height: 736)
    }
    
    enum iPad {
        static let Pro9_7 = CGSize(width: 768, height: 1024)
        static let Pro10_5 = CGSize(width: 834, height: 1112)
        static let Pro12_9 = CGSize(width: 1024, height: 1366)
    }
}
extension CGSize {
    var rotated: CGSize {
        return CGSize(width: height, height: width)
    }
    var splitViewHalf: CGSize {
        return CGSize(width: width/2, height: height)
    }
    var splitViewTwoThirds: CGSize {
        return CGSize(width: (width/3)*2, height: height)
    }
    var splitViewOneThird: CGSize {
        return CGSize(width: width/3, height: height)
    }
}

extension CGSize{
    var asRect: CGRect {
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
}

enum iPhoneXMask {
    static let portrait = UIImageView(image: UIImage(named: "maskPortrait"))
    static let landscapeLeft = UIImageView(image: UIImage(named: "maskLandscapeLeft"))
    static let landscapeRight = UIImageView(image: UIImage(named: "maskLandscapeRight"))
}

