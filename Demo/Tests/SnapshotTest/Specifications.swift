//  Copyright © 2017 One by AOL : Publishers. All rights reserved.
//  This file contains all possible specifications for all iOS devices available for this moment, including size, trait collection and masks for iPhone X.

extension UITraitCollection {
    public enum Display {
        public enum Scale {
            public static let x3 = UITraitCollection(displayScale: 3.0)
            public static let x2 = UITraitCollection(displayScale: 2.0)
            public static let x1 = UITraitCollection(displayScale: 1.0)
            public static let x0 = UITraitCollection(displayScale: 0.0)
        }
        
        
        public enum InterfaceIdiom {
            public static let phone = UITraitCollection(userInterfaceIdiom: .phone)
            public static let pad = UITraitCollection(userInterfaceIdiom: .pad)
            @available(iOS 9.0, *)
            public static let tv = UITraitCollection(userInterfaceIdiom: .tv)
            @available(iOS 9.0, *)
            public static let carPlay = UITraitCollection(userInterfaceIdiom: .carPlay)
        }
        
        public enum SizeClass {
            public enum Horizontal {
                public static let regular = UITraitCollection(horizontalSizeClass: .regular)
                public static let compact = UITraitCollection(horizontalSizeClass: .compact)
                public static let unspecified = UITraitCollection(horizontalSizeClass: .unspecified)
            }
            
            public enum Vertical {
                public static let regular = UITraitCollection(verticalSizeClass: .regular)
                public static let compact = UITraitCollection(verticalSizeClass: .compact)
                public static let unspecified = UITraitCollection(verticalSizeClass: .unspecified)
            }
        }
    }
    public enum Compability {
        @available(iOS 10.0, *)
        public enum DisplayGamut {
            public static let unspecified = UITraitCollection(displayGamut: .unspecified)
            public static let SRGB = UITraitCollection(displayGamut: .SRGB)
            public static let P3 = UITraitCollection(displayGamut: .P3)
        }
        
        @available(iOS 9.0, *)
        public enum ForceTouch {
            public static let unavailable = UITraitCollection(forceTouchCapability: .unavailable)
            public static let available = UITraitCollection(forceTouchCapability: .available)
            public static let unknown = UITraitCollection(forceTouchCapability: .unknown)
        }
    }
    
    public enum ContentCategory {
        @available(iOS 10.0, *)
        public enum LayoutDirection {
            public static let leftToRight = UITraitCollection(layoutDirection: .leftToRight)
            public static let rightToLeft = UITraitCollection(layoutDirection: .rightToLeft)
            public static let unspecified = UITraitCollection(layoutDirection: .unspecified)
        }
        
        @available(iOS 10.0, *)
        public enum ContentSizeCategory {
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
    
    enum iPhoneRegular {
        static let portrait = UITraitCollection(
            traitsFrom: [Display.InterfaceIdiom.phone,
                         Display.SizeClass.Vertical.regular,
                         Display.SizeClass.Horizontal.compact,
                         Display.Scale.x2])
        static let landscape = UITraitCollection(
            traitsFrom: [Display.InterfaceIdiom.phone,
                         Display.SizeClass.Vertical.compact,
                         Display.SizeClass.Horizontal.compact,
                         Display.Scale.x2])
    }
    enum iPhonePlus {
        static let portrait = UITraitCollection(
            traitsFrom: [Display.InterfaceIdiom.phone,
                         Display.SizeClass.Vertical.regular,
                         Display.SizeClass.Horizontal.compact,
                         Display.Scale.x3])
        static let landscape = UITraitCollection(
            traitsFrom: [Display.InterfaceIdiom.phone,
                         Display.SizeClass.Vertical.compact,
                         Display.SizeClass.Horizontal.regular,
                         Display.Scale.x3])
    }
    @available(iOS 11.0, *)
    enum iPhoneX {
        static let portrait = UITraitCollection(
            traitsFrom: [Display.InterfaceIdiom.phone,
                         Display.SizeClass.Vertical.regular,
                         Display.SizeClass.Horizontal.compact,
                         Display.Scale.x3,
                         Compability.ForceTouch.available,
                         Compability.DisplayGamut.P3])
        static let landscape = UITraitCollection(
            traitsFrom: [Display.SizeClass.Vertical.compact,
                         Display.SizeClass.Horizontal.compact,
                         Display.Scale.x3,
                         Compability.ForceTouch.available,
                         Compability.DisplayGamut.P3])
    }
    enum iPadRegular {
        enum portrait {
            static let regular = UITraitCollection(
                traitsFrom: [Display.InterfaceIdiom.pad,
                             Display.SizeClass.Vertical.regular,
                             Display.SizeClass.Horizontal.regular,
                             Display.Scale.x2])
            static let splitOneThird = UITraitCollection(
                traitsFrom: [Display.InterfaceIdiom.pad,
                             Display.SizeClass.Vertical.regular,
                             Display.SizeClass.Horizontal.compact,
                             Display.Scale.x2])
            static let splitTwoThirds = UITraitCollection(
                traitsFrom: [Display.InterfaceIdiom.pad,
                             Display.SizeClass.Vertical.regular,
                             Display.SizeClass.Horizontal.compact,
                             Display.Scale.x2])
        }
        enum landscape {
            static let regular = UITraitCollection(
                traitsFrom: [Display.InterfaceIdiom.pad,
                             Display.SizeClass.Vertical.regular,
                             Display.SizeClass.Horizontal.regular,
                             Display.Scale.x2])
            static let splitOneThird = UITraitCollection(
                traitsFrom: [Display.InterfaceIdiom.pad,
                             Display.SizeClass.Vertical.regular,
                             Display.SizeClass.Horizontal.compact,
                             Display.Scale.x2])
            static let splitTwoThirds = UITraitCollection(
                traitsFrom: [Display.InterfaceIdiom.pad,
                             Display.SizeClass.Vertical.regular,
                             Display.SizeClass.Horizontal.compact,
                             Display.Scale.x2])
            static let splitHalf = UITraitCollection(
                traitsFrom: [Display.InterfaceIdiom.pad,
                             Display.SizeClass.Vertical.regular,
                             Display.SizeClass.Horizontal.compact,
                             Display.Scale.x2])
        }
    }
    enum iPadPro12 {
        enum portrait {
            static let regular = UITraitCollection(
                traitsFrom: [Display.InterfaceIdiom.pad,
                             Display.SizeClass.Vertical.regular,
                             Display.SizeClass.Horizontal.regular,
                             Display.Scale.x2])
            static let splitOneThird = UITraitCollection(
                traitsFrom: [Display.InterfaceIdiom.pad,
                             Display.SizeClass.Vertical.regular,
                             Display.SizeClass.Horizontal.compact,
                             Display.Scale.x2])
            static let splitTwoThirds = UITraitCollection(
                traitsFrom: [Display.InterfaceIdiom.pad,
                             Display.SizeClass.Vertical.regular,
                             Display.SizeClass.Horizontal.compact,
                             Display.Scale.x2])
        }
        enum landscape {
            static let regular = UITraitCollection(
                traitsFrom: [Display.InterfaceIdiom.pad,
                             Display.SizeClass.Vertical.regular,
                             Display.SizeClass.Horizontal.regular,
                             Display.Scale.x2])
            static let splitOneThird = UITraitCollection(
                traitsFrom: [Display.InterfaceIdiom.pad,
                             Display.SizeClass.Vertical.regular,
                             Display.SizeClass.Horizontal.compact,
                             Display.Scale.x2])
            static let splitTwoThirds = UITraitCollection(
                traitsFrom: [Display.InterfaceIdiom.pad,
                             Display.SizeClass.Vertical.regular,
                             Display.SizeClass.Horizontal.compact,
                             Display.Scale.x2])
            static let splitHalf = UITraitCollection(
                traitsFrom: [Display.InterfaceIdiom.pad,
                             Display.SizeClass.Vertical.regular,
                             Display.SizeClass.Horizontal.regular,
                             Display.Scale.x2])
        }
    }
}
    //iPhone 6S and 6S Plus Trait - force touch
    //iPhone 7 and 7 Plus Trait - force touch and P3
    //iPhone 8 and 8 Plus Trait - force touch and P3
    //iPhone X Trait - force touch, P3 and x3 scale

    //iPhone Regular - 5s, 6, 6s, SE, 7, 8
    //iPhone Plus - 6 plus, 7 plus, 8 plus
    
    //iPad Pro 9 Trait - P3
    //iPad Pro 10 Trait - P3
    
    //iPad Pro 12 - Pro 12 LoL
    //iPad Regular = 9, 10, Air, Air 2, Mini, Mini 2, iPad 5th Generation

extension CGSize {
    public enum iPhone {
        static let SE = CGSize(width: 320, height: 568)
        static let X = CGSize(width: 375, height: 812)
        static let Eight = CGSize(width: 375, height: 667)
        static let EightPlus = CGSize(width: 414, height: 736)
    }
    
    public enum iPad {
        static let Pro9 = CGSize(width: 768, height: 1024)
        static let Pro10 = CGSize(width: 834, height: 1112)
        static let Pro12 = CGSize(width: 1024, height: 1366)
    }
    
    public enum Watch {
        static let as38mm = CGSize(width: 272, height: 340)
        static let as42mm = CGSize(width: 312, height: 390)
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

