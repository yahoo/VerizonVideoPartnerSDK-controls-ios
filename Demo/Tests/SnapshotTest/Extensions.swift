//
//  Extensions.swift
//  SnapshotTest
//
//  Created by rtysiachnik on 11/10/17.
//  Copyright © 2017 One by AOL : Publishers. All rights reserved.
//

extension UITraitCollection {
    enum iPhone {
        enum iPhoneRegular {
            static let portrait = UITraitCollection(
                traitsFrom: [UITraitCollection(userInterfaceIdiom: .phone),
                             UITraitCollection(verticalSizeClass: .regular),
                             UITraitCollection(horizontalSizeClass: .compact)])
            static let landscape = UITraitCollection(
                traitsFrom: [UITraitCollection(userInterfaceIdiom: .phone),
                             UITraitCollection(verticalSizeClass: .compact),
                             UITraitCollection(horizontalSizeClass: .compact)])
        }
        enum iPhonePlus {
            static let portrait = UITraitCollection(
                traitsFrom: [UITraitCollection(userInterfaceIdiom: .phone),
                             UITraitCollection(verticalSizeClass: .regular),
                             UITraitCollection(horizontalSizeClass: .compact)])
            static let landscape = UITraitCollection(
                traitsFrom: [UITraitCollection(userInterfaceIdiom: .phone),
                             UITraitCollection(verticalSizeClass: .compact),
                             UITraitCollection(horizontalSizeClass: .regular)])
        }
    }
    enum iPad {
        static let fullScreen = UITraitCollection(
            traitsFrom: [UITraitCollection(userInterfaceIdiom: .pad),
                         UITraitCollection(horizontalSizeClass: .regular),
                         UITraitCollection(verticalSizeClass: .regular),])
        static let splitOneThird = UITraitCollection(
            traitsFrom: [UITraitCollection(userInterfaceIdiom: .pad),
                         UITraitCollection(horizontalSizeClass: .regular),
                         UITraitCollection(verticalSizeClass: .compact),])
        static let splitTwoThirds = UITraitCollection(
            traitsFrom: [UITraitCollection(userInterfaceIdiom: .pad),
                         UITraitCollection(horizontalSizeClass: .regular),
                         UITraitCollection(verticalSizeClass: .regular),])
        static let splitHalf = UITraitCollection(
            traitsFrom: [UITraitCollection(userInterfaceIdiom: .pad),
                         UITraitCollection(horizontalSizeClass: .compact),
                         UITraitCollection(verticalSizeClass: .compact),])
        static let splitHalfFor12_9 = UITraitCollection(
            traitsFrom: [UITraitCollection(userInterfaceIdiom: .pad),
                         UITraitCollection(horizontalSizeClass: .regular),
                         UITraitCollection(verticalSizeClass: .regular),])
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

extension CGRect {
    static func getCGRectBy(size: CGSize) -> CGRect {
        return CGRect(origin: CGPoint(x: 0, y: 0), size: size)
    }
}

enum iPhoneXMask {
    static let portrait = UIImageView(image: UIImage(named: "maskPortrait"))
    static let landscapeLeft = UIImageView(image: UIImage(named: "maskLandscapeLeft"))
    static let landscapeRight = UIImageView(image: UIImage(named: "maskLandscapeRight"))
}

