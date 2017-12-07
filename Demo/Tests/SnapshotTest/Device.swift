//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

public struct Presentation {
    let name: String
    let size: CGSize
    let traitCollection: UITraitCollection
    let mask: UIView?
    
    public init(name: String, size: CGSize, traitCollection: UITraitCollection, mask: UIView? = nil) {
        self.name = name
        self.size = size
        self.traitCollection = traitCollection
        self.mask = mask
    }
}

///An enum that has all iOS devices. Choose device, its orientation and if you going to choose iPad, you have also to choose between one of the display modes.
public enum Device {
    public enum iPhoneSE {
        public static let portrait = Presentation(
            name: "iPhone SE Portrait",
            size: CGSize.iPhoneSE,
            traitCollection: UITraitCollection.iPhone.portrait)
        public static let landscape = Presentation(
            name: "iPhone SE Landscape",
            size: CGSize.iPhoneSE.rotated,
            traitCollection: UITraitCollection.iPhone.landscape)
    }
    public enum iPhone6 {
        public static let portrait = Presentation(
            name: "iPhone 6 Portrait",
            size: CGSize.iPhone,
            traitCollection: UITraitCollection.iPhone.portrait)
        public static let landscape = Presentation(
            name: "iPhone 6 Landscape Left",
            size: CGSize.iPhone.rotated,
            traitCollection: UITraitCollection.iPhone.landscape)
    }
    public enum iPhone6Plus {
        public static let portrait = Presentation(
            name: "iPhone6Plus Portrait",
            size: CGSize.iPhonePlus,
            traitCollection: UITraitCollection.iPhonePlus.portrait)
        public static let landscape = Presentation(
            name: "iPhone 6Plus Landscape Left",
            size: CGSize.iPhonePlus.rotated,
            traitCollection: UITraitCollection.iPhonePlus.landscape)
    }
    @available(iOS 9.0, *)
    public enum iPhone6S {
        public static let portrait = Presentation(
            name: "iPhone 6S Portrait",
            size: CGSize.iPhone,
            traitCollection: UITraitCollection.iPhone.portrait)
        public static let landscape = Presentation(
            name: "iPhone 6S Landscape Left",
            size: CGSize.iPhone.rotated,
            traitCollection: UITraitCollection(traitsFrom: [
                UITraitCollection.iPhone.landscape,
                UITraitCollection.Compability.ForceTouch.available])
        )
    }
    @available(iOS 9.0, *)
    public enum iPhone6SPlus {
        public static let portrait = Presentation(
            name: "iPhone 6SPlus Portrait",
            size: CGSize.iPhonePlus,
            traitCollection: UITraitCollection.iPhonePlus.portrait)
        public static let landscape = Presentation(
            name: "iPhone 6SPlus Landscape Left",
            size: CGSize.iPhonePlus.rotated,
            traitCollection: UITraitCollection(traitsFrom: [
                UITraitCollection.iPhonePlus.landscape,
                UITraitCollection.Compability.ForceTouch.available])
        )
    }
    @available(iOS 10.0, *)
    public enum iPhone7 {
        public static let portrait = Presentation(
            name: "iPhone 7 Portrait",
            size: CGSize.iPhone,
            traitCollection: UITraitCollection.iPhone.portrait)
        public static let landscape = Presentation(
            name: "iPhone 7 Landscape Left",
            size: CGSize.iPhone.rotated,
            traitCollection: UITraitCollection(traitsFrom: [
                UITraitCollection.iPhone.landscape,
                UITraitCollection.Compability.ForceTouch.available,
                UITraitCollection.Compability.DisplayGamut.P3])
        )
    }
    @available(iOS 10.0, *)
    public enum iPhone7Plus {
        public static let portrait = Presentation(
            name: "iPhone 7Plus Portrait",
            size: CGSize.iPhonePlus,
            traitCollection: UITraitCollection.iPhonePlus.portrait)
        public static let landscape = Presentation(
            name: "iPhone 7Plus Landscape Left",
            size: CGSize.iPhonePlus.rotated,
            traitCollection: UITraitCollection(traitsFrom: [
                UITraitCollection.iPhonePlus.landscape,
                UITraitCollection.Compability.ForceTouch.available,
                UITraitCollection.Compability.DisplayGamut.P3])
        )
    }
    @available(iOS 11.0, *)
    public enum iPhone8 {
        public static let portrait = Presentation(
            name: "iPhone 8 Portrait",
            size: CGSize.iPhone,
            traitCollection: UITraitCollection.iPhone.portrait)
        public static let landscape = Presentation(
            name: "iPhone 8 Landscape",
            size: CGSize.iPhone.rotated,
            traitCollection: UITraitCollection(traitsFrom: [
                UITraitCollection.iPhone.landscape,
                UITraitCollection.Compability.ForceTouch.available,
                UITraitCollection.Compability.DisplayGamut.P3])
        )
    }
    @available(iOS 11.0, *)
    public enum iPhone8Plus {
        public static let portrait = Presentation(
            name: "iPhone 8 Plus Portrait",
            size: CGSize.iPhonePlus,
            traitCollection: UITraitCollection.iPhonePlus.portrait)
        public static let landscape = Presentation(
            name: "iPhone 8 Plus Landscape",
            size: CGSize.iPhonePlus.rotated,
            traitCollection: UITraitCollection(traitsFrom: [
                UITraitCollection.iPhonePlus.landscape,
                UITraitCollection.Compability.ForceTouch.available,
                UITraitCollection.Compability.DisplayGamut.P3])
        )
    }
    @available(iOS 11.0, *)
    public enum iPhoneX {
        public static let portrait = Presentation(
            name: "iPhone X Portrait",
            size: CGSize.iPhoneX,
            traitCollection: UITraitCollection.iPhoneX.portrait,
            mask: iPhoneXMask.portrait)
        public static let landscapeRight = Presentation(
            name: "iPhone X Landscape Left",
            size: CGSize.iPhoneX.rotated,
            traitCollection: UITraitCollection.iPhoneX.landscape,
            mask: iPhoneXMask.landscapeLeft)
        public static let landscapeLeft = Presentation(
            name: "iPhone X Landscape Right",
            size: CGSize.iPhoneX.rotated,
            traitCollection: UITraitCollection.iPhoneX.landscape,
            mask: iPhoneXMask.landscapeRight)
    }
    public enum iPadPro12 {
        public enum portrait {
            public static let fullScreen = Presentation(
                name: "iPad Pro12 Portrait FullScreen",
                size: CGSize.iPadPro12,
                traitCollection: UITraitCollection.iPad.portrait.fullScreen)
            public static let twoThirds = Presentation(
                name: "iPad Pro12 Portrait Two Third",
                size: CGSize.iPadPro12.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad.portrait.fullScreen)
            public static let oneThird = Presentation(
                name: "iPad Pro12 Portrait SplitView One Third",
                size: CGSize.iPadPro12.splitViewOneThird,
                traitCollection: UITraitCollection.iPad.portrait.splitOneThird)
        }
        public enum landscape {
            public static let fullScreen = Presentation(
                name: "iPad Pro12 Landscape FullScreen",
                size: CGSize.iPadPro12.rotated,
                traitCollection: UITraitCollection.iPad.landscape.fullScreen)
            public static let half = Presentation(
                name: "iPad Pro12 Landscape SplitView Half",
                size: CGSize.iPadPro12.rotated.splitViewHalf,
                traitCollection: UITraitCollection(
                    traitsFrom: [UITraitCollection.Display.InterfaceIdiom.pad,
                                 UITraitCollection.Display.SizeClass.Vertical.regular,
                                 UITraitCollection.Display.SizeClass.Horizontal.regular,
                                 UITraitCollection.Display.Scale.x2]))
            public static let twoThird = Presentation(
                name: "iPad Pro12 Landscape SplitView Two-Thirds",
                size: CGSize.iPadPro12.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad.landscape.splitTwoThirds)
            public static let oneThird = Presentation(
                name: "iPad Pro12 Landscape SplitView One Third",
                size: CGSize.iPadPro12.rotated.splitViewOneThird,
                traitCollection: UITraitCollection.iPad.landscape.splitOneThird)
        }
    }
    @available(iOS 10.0, *)
    public enum iPadPro10 {
        public enum portrait {
            public static let fullScreen = Presentation(
                name: "iPad Pro10 FullScreen",
                size: CGSize.iPadPro10,
                traitCollection: UITraitCollection(traitsFrom: [
                    UITraitCollection.iPad.portrait.fullScreen,
                    UITraitCollection.Compability.ForceTouch.available,
                    UITraitCollection.Compability.DisplayGamut.P3])
            )
            public static let twoThirds = Presentation(
                name: "iPad Pro10 Portrait SplitView Two-Thirds",
                size: CGSize.iPadPro10.splitViewTwoThirds,
                traitCollection: UITraitCollection(traitsFrom: [
                    UITraitCollection.iPad.portrait.splitTwoThirds,
                    UITraitCollection.Compability.ForceTouch.available,
                    UITraitCollection.Compability.DisplayGamut.P3])
            )
            public static let oneThird = Presentation(
                name: "iPad Pro10 Portrait SplitView One Third",
                size: CGSize.iPadPro10.splitViewOneThird,
                traitCollection: UITraitCollection(traitsFrom: [
                    UITraitCollection.iPad.portrait.splitOneThird,
                    UITraitCollection.Compability.ForceTouch.available,
                    UITraitCollection.Compability.DisplayGamut.P3])
            )
        }
        public enum landscape {
            public static let fullScreen = Presentation(
                name: "iPad Pro10 Landscape FullScreen",
                size: CGSize.iPadPro10.rotated,
                traitCollection: UITraitCollection(traitsFrom: [
                    UITraitCollection.iPad.landscape.fullScreen,
                    UITraitCollection.Compability.ForceTouch.available,
                    UITraitCollection.Compability.DisplayGamut.P3])
            )
            public static let half = Presentation(
                name: "iPad Pro10 Landscape SplitView Half",
                size: CGSize.iPadPro10.rotated.splitViewHalf,
                traitCollection: UITraitCollection(traitsFrom: [
                    UITraitCollection.iPad.landscape.splitHalf,
                    UITraitCollection.Compability.ForceTouch.available,
                    UITraitCollection.Compability.DisplayGamut.P3])
            )
            public static let twoThird = Presentation(
                name: "iPad Pro10 Landscape SplitView Two-Thirds",
                size: CGSize.iPadPro10.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection(traitsFrom: [
                    UITraitCollection.iPad.landscape.splitTwoThirds,
                    UITraitCollection.Compability.ForceTouch.available,
                    UITraitCollection.Compability.DisplayGamut.P3])
            )
            public static let oneThird = Presentation(
                name: "iPad Pro10 Landscape SplitView One Third",
                size: CGSize.iPadPro10.rotated.splitViewOneThird,
                traitCollection: UITraitCollection(traitsFrom: [
                    UITraitCollection.iPad.landscape.splitOneThird,
                    UITraitCollection.Compability.ForceTouch.available,
                    UITraitCollection.Compability.DisplayGamut.P3])
            )
        }
    }
    
    @available(iOS 10.0, *)
    public enum iPadPro9 {
        public enum portrait {
            public static let fullScreen = Presentation(
                name: "iPad Pro10 FullScreen",
                size: CGSize.iPadPro10,
                traitCollection: UITraitCollection(traitsFrom: [
                    UITraitCollection.iPad.portrait.fullScreen,
                    UITraitCollection.Compability.ForceTouch.available,
                    UITraitCollection.Compability.DisplayGamut.P3])
            )
            public static let twoThirds = Presentation(
                name: "iPad Pro10 Portrait SplitView Two-Thirds",
                size: CGSize.iPadPro10.splitViewTwoThirds,
                traitCollection: UITraitCollection(traitsFrom: [
                    UITraitCollection.iPad.portrait.splitTwoThirds,
                    UITraitCollection.Compability.ForceTouch.available,
                    UITraitCollection.Compability.DisplayGamut.P3])
            )
            public static let oneThird = Presentation(
                name: "iPad Pro10 Portrait SplitView One Third",
                size: CGSize.iPadPro10.splitViewOneThird,
                traitCollection: UITraitCollection(traitsFrom: [
                    UITraitCollection.iPad.portrait.splitOneThird,
                    UITraitCollection.Compability.ForceTouch.available,
                    UITraitCollection.Compability.DisplayGamut.P3])
            )
        }
        public enum landscape {
            public static let fullScreen = Presentation(
                name: "iPad Pro10 Landscape FullScreen",
                size: CGSize.iPadPro10.rotated,
                traitCollection: UITraitCollection(traitsFrom: [
                    UITraitCollection.iPad.landscape.fullScreen,
                    UITraitCollection.Compability.ForceTouch.available,
                    UITraitCollection.Compability.DisplayGamut.P3])
            )
            public static let half = Presentation(
                name: "iPad Pro10 Landscape SplitView Half",
                size: CGSize.iPadPro10.rotated.splitViewHalf,
                traitCollection: UITraitCollection(traitsFrom: [
                    UITraitCollection.iPad.landscape.splitHalf,
                    UITraitCollection.Compability.ForceTouch.available,
                    UITraitCollection.Compability.DisplayGamut.P3])
            )
            public static let twoThird = Presentation(
                name: "iPad Pro10 Landscape SplitView Two-Thirds",
                size: CGSize.iPadPro10.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection(traitsFrom: [
                    UITraitCollection.iPad.landscape.splitTwoThirds,
                    UITraitCollection.Compability.ForceTouch.available,
                    UITraitCollection.Compability.DisplayGamut.P3])
            )
            public static let oneThird = Presentation(
                name: "iPad Pro10 Landscape SplitView One Third",
                size: CGSize.iPadPro10.rotated.splitViewOneThird,
                traitCollection: UITraitCollection(traitsFrom: [
                    UITraitCollection.iPad.landscape.splitOneThird,
                    UITraitCollection.Compability.ForceTouch.available,
                    UITraitCollection.Compability.DisplayGamut.P3])
            )
        }
    }
    public enum iPadAir {
            public static let portrait = Presentation(
                name: "iPad Air FullScreen",
                size: CGSize.iPadPro9,
                traitCollection: UITraitCollection.iPadOld.fullScreen)
            public static let landscape = Presentation(
                name: "iPad Air Landscape FullScreen",
                size: CGSize.iPadPro9.rotated,
                traitCollection: UITraitCollection.iPadOld.fullScreen)
    }
    public enum iPadAir2{
            public static let portrait = Presentation(
                name: "iPad Air2 FullScreen",
                size: CGSize.iPadPro9,
                traitCollection: UITraitCollection.iPadOld.fullScreen)
            public static let landscape = Presentation(
                name: "iPad Air2 Landscape FullScreen",
                size: CGSize.iPadPro9.rotated,
                traitCollection: UITraitCollection.iPadOld.fullScreen)
    }
    public enum iPadMini {
            public static let portrait = Presentation(
                name: "iPad mini FullScreen",
                size: CGSize.iPadPro9,
                traitCollection: UITraitCollection.iPadOld.fullScreen)
            public static let landscape = Presentation(
                name: "iPad mini Landscape FullScreen",
                size: CGSize.iPadPro9.rotated,
                traitCollection: UITraitCollection.iPadOld.fullScreen)
    }
    public enum iPadMini2 {
        public enum portrait {
            public static let fullScreen = Presentation(
                name: "iPad mini2 FullScreen",
                size: CGSize.iPadPro9,
                traitCollection: UITraitCollection.iPad.portrait.fullScreen)
            public static let twoThirds = Presentation(
                name: "iPad mini2 Portrait SplitView Two-Thirds",
                size: CGSize.iPadPro9.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad.portrait.fullScreen)
            public static let oneThird = Presentation(
                name: "iPad mini2 Portrait SplitView One Third",
                size: CGSize.iPadPro9.splitViewOneThird,
                traitCollection: UITraitCollection.iPad.portrait.splitOneThird)
        }
        public enum landscape {
            public static let fullScreen = Presentation(
                name: "iPad mini2 Landscape FullScreen",
                size: CGSize.iPadPro9.rotated,
                traitCollection: UITraitCollection.iPad.landscape.fullScreen)
            public static let half = Presentation(
                name: "iPad mini2 Landscape SplitView Half",
                size: CGSize.iPadPro9.rotated.splitViewHalf,
                traitCollection: UITraitCollection.iPad.landscape.splitHalf)
            public static let twoThird = Presentation(
                name: "iPad mini2 Landscape SplitView Two-Thirds",
                size: CGSize.iPadPro9.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad.landscape.fullScreen)
            public static let oneThird = Presentation(
                name: "iPad mini2 Landscape SplitView One Third",
                size: CGSize.iPadPro9.rotated.splitViewOneThird,
                traitCollection: UITraitCollection.iPad.landscape.splitHalf)
        }
    }
    public enum iPad5thGen {
        public enum portrait {
            public static let fullScreen = Presentation(
                name: "iPad 5thGen FullScreen",
                size: CGSize.iPadPro9,
                traitCollection: UITraitCollection.iPad.portrait.fullScreen)
            
            public static let TwoThirds = Presentation(
                name: "iPad 5thGen Portrait SplitView Two-Thirds",
                size: CGSize.iPadPro9.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad.portrait.fullScreen)
            
            public static let oneThird = Presentation(
                name: "iPad 5thGenPortrait SplitView One Third",
                size: CGSize.iPadPro9.splitViewOneThird,
                traitCollection: UITraitCollection.iPad.portrait.splitOneThird)
        }
        public enum landscape {
            public static let fullScreen = Presentation(
                name: "iPad 5thGen Landscape FullScreen",
                size: CGSize.iPadPro9.rotated,
                traitCollection: UITraitCollection.iPad.landscape.fullScreen)
            
            public static let half = Presentation(
                name: "iPad 5thGen Landscape SplitView Half",
                size: CGSize.iPadPro9.rotated.splitViewHalf,
                traitCollection: UITraitCollection.iPad.landscape.splitHalf)
            
            public static let twoThird = Presentation(
                name: "iPad 5thGen Landscape SplitView Two-Thirds",
                size: CGSize.iPadPro9.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad.landscape.fullScreen)
            
            public static let oneThird = Presentation(
                name: "iPad 5thGen Landscape SplitView One Third",
                size: CGSize.iPadPro9.rotated.splitViewOneThird,
                traitCollection: UITraitCollection.iPad.landscape.splitHalf)
        }
    }
}
