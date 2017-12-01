//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import Foundation

extension UITraitCollection {
    
    public enum Display {
        
        public enum Scale {
            public static let retina = UITraitCollection(displayScale: 2.0)
            public static let nonRetina = UITraitCollection(displayScale: 1.0)
            public static let unspecified = UITraitCollection(displayScale: 0.0)
        }
        
        @available(iOS 10.0, *)
        public enum interfaceIdiom {
            public static let phone = UITraitCollection(userInterfaceIdiom: .phone)
            public static let pad = UITraitCollection(userInterfaceIdiom: .pad)
            public static let tv = UITraitCollection(userInterfaceIdiom: .tv)
            public static let carPlay = UITraitCollection(userInterfaceIdiom: .carPlay)
        }
        
        public enum SizeClass {
            public enum horizontal {
                public static let regular = UITraitCollection(horizontalSizeClass: .regular)
                public static let compact = UITraitCollection(horizontalSizeClass: .compact)
                public static let unspecified = UITraitCollection(horizontalSizeClass: .unspecified)
            }
            
            public enum vertical {
                public static let regular = UITraitCollection(verticalSizeClass: .regular)
                public static let compact = UITraitCollection(verticalSizeClass: .compact)
                public static let unspecified = UITraitCollection(verticalSizeClass: .unspecified)
            }
        }
    }
    
    
    
    public enum Compability {
        @available(iOS 10.0, *)
        public enum displayGamut {
            public static let unspecified = UITraitCollection(displayGamut: .unspecified)
            public static let SRGB = UITraitCollection(displayGamut: .SRGB)
            public static let P3 = UITraitCollection(displayGamut: .P3)
        }
        
        @available(iOS 9.0, *)
        public enum forceTouch {
            public static let unavailable = UITraitCollection(forceTouchCapability: .unavailable)
            public static let available = UITraitCollection(forceTouchCapability: .available)
            public static let unknown = UITraitCollection(forceTouchCapability: .unknown)
        }
        
    }
    
    public enum ContentCategory {
        @available(iOS 10.0, *)
        public enum layoutDirection {
            public static let leftToRight = UITraitCollection(layoutDirection: .leftToRight)
            public static let rightToLeft = UITraitCollection(layoutDirection: .rightToLeft)
            public static let unspecified = UITraitCollection(layoutDirection: .unspecified)
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
    }
    
    @available(iOS 10.0, *)
    enum iPhone {
        enum SE {
            static let portrait = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.displayGamut.SRGB])
            static let landscape = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.displayGamut.SRGB])
        }
        enum _6 {
            static let portrait = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.displayGamut.SRGB])
            static let landscape = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.displayGamut.SRGB])
        }
        enum _6Plus {
            static let portrait = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.displayGamut.SRGB])
            static let landscape = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.displayGamut.SRGB])
        }
        enum _6S {
            static let portrait = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.forceTouch.available,
                             Compability.displayGamut.SRGB])
            static let landscape = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.forceTouch.available,
                             Compability.displayGamut.SRGB])
        }
        enum _6SPlus {
            static let portrait = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.forceTouch.available,
                             Compability.displayGamut.SRGB])
            static let landscape = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.forceTouch.available,
                             Compability.displayGamut.SRGB])
        }
        enum _7 {
            static let portrait = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.forceTouch.available,
                             Compability.displayGamut.P3])
            static let landscape = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.forceTouch.available,
                             Compability.displayGamut.P3])
        }
        enum _7Plus {
            static let portrait = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.forceTouch.available,
                             Compability.displayGamut.P3])
            static let landscape = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.forceTouch.available,
                             Compability.displayGamut.P3])
        }
        
        enum _8 {
            static let portrait = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.forceTouch.available])
            static let landscape = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.forceTouch.available,
                             Compability.displayGamut.P3])
        }
        enum _8Plus {
            static let portrait = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.forceTouch.available,
                             Compability.displayGamut.P3])
            static let landscape = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.forceTouch.available,
                             Compability.displayGamut.P3])
        }
        enum X {
            static let portrait = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.forceTouch.available,
                             Compability.displayGamut.P3])
            static let landscape = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.forceTouch.available,
                             Compability.displayGamut.P3])
        }
        
        
    }
    @available(iOS 10.0, *)
    enum iPad {
        enum Pro9_7 {
            static let regular = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.displayGamut.P3,
                             Compability.forceTouch.unavailable])
            static let splitOneThird = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.displayGamut.P3,
                             Compability.forceTouch.unavailable])
            static let splitHalf = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.displayGamut.P3,
                             Compability.forceTouch.unavailable])
        }
        enum Pro12_9 {
            static let regular = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.displayGamut.P3,
                             Compability.forceTouch.unavailable])
            static let splitOneThird = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.displayGamut.P3,
                             Compability.forceTouch.unavailable])
            static let splitHalf = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.displayGamut.P3,
                             Compability.forceTouch.unavailable])
        }
        
        enum Pro10_5 {
            static let regular = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.displayGamut.P3,
                             Compability.forceTouch.unavailable])
            static let splitOneThird = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.displayGamut.P3,
                             Compability.forceTouch.unavailable])
            static let splitHalf = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.phone,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.displayGamut.P3,
                             Compability.forceTouch.unavailable])
        }
        
        enum Air2 {
            static let regular = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.pad,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.displayGamut.SRGB,
                             Compability.forceTouch.unavailable])
            static let splitOneThird = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.pad,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.displayGamut.SRGB,
                             Compability.forceTouch.unavailable])
            static let splitHalf = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.pad,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.displayGamut.SRGB,
                             Compability.forceTouch.unavailable])
        }
        enum Air {
            static let regular = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.pad,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.displayGamut.SRGB,
                             Compability.forceTouch.unavailable])
        }
        enum fourthGeneration9_7 {
                static let regular = UITraitCollection(
                    traitsFrom: [Display.interfaceIdiom.pad,
                                 Display.SizeClass.vertical.regular,
                                 Display.SizeClass.horizontal.regular,
                                 Display.Scale.retina,
                                 Compability.displayGamut.SRGB,
                                 Compability.forceTouch.unavailable])
        }
        enum thirdGeneration9_7 {
            static let regular = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.pad,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.nonRetina,
                             Compability.displayGamut.SRGB,
                             Compability.forceTouch.unavailable])
        }
        enum mini1 {
            static let regular = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.pad,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.displayGamut.SRGB,
                             Compability.forceTouch.unavailable])
        }
        enum mini2 {
            static let regular = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.pad,
                             Display.SizeClass.vertical.regular,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.displayGamut.SRGB,
                             Compability.forceTouch.unavailable])
            static let splitOneThird = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.pad,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.regular,
                             Display.Scale.retina,
                             Compability.displayGamut.SRGB,
                             Compability.forceTouch.unavailable
                ])
            static let splitHalf = UITraitCollection(
                traitsFrom: [Display.interfaceIdiom.pad,
                             Display.SizeClass.vertical.compact,
                             Display.SizeClass.horizontal.compact,
                             Display.Scale.retina,
                             Compability.displayGamut.SRGB,
                             Compability.forceTouch.unavailable])
            
        }
        enum mini3 {
            static let regular = iPad.mini2.regular
            static let splitOneThird = iPad.mini2.splitOneThird
            static let splitHalf = iPad.mini2.splitHalf
        }
        enum mini4{
            static let regular = iPad.mini2.regular
            static let splitOneThird = iPad.mini2.splitOneThird
            static let splitHalf = iPad.mini2.splitHalf
        }
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

