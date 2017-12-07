//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

///An enum that has all iOS devices. Choose device, its orientation and if you going to choose iPad, you have also to choose between one of the display modes.
public enum Device {
    public enum iPhoneSE {
        public static let portrait = Presentation(
            name: "iPhone_SE_Portrait",
            size: CGSize.iPhone.SE,
            traitCollection: UITraitCollection.iPhoneSE.portrait)
        public static let landscape = Presentation(
                name: "iPhone_SE_Landscape",
                size: CGSize.iPhone.SE.rotated,
                traitCollection: UITraitCollection.iPhoneSE.landscape)
    }
    public enum iPhone6 {
        public static let portrait = Presentation(
            name: "iPhone_6_Portrait",
            size: CGSize.iPhone.Eight,
            traitCollection: UITraitCollection.iPhone6.portrait)
        public static let landscape = Presentation(
            name: "iPhone_6_Landscape_Left",
            size: CGSize.iPhone.Eight.rotated,
            traitCollection: UITraitCollection.iPhone6.landscape)
    }
    public enum iPhone6Plus {
        public static let portrait = Presentation(
            name: "iPhone6Plus_Portrait",
            size: CGSize.iPhone.EightPlus,
            traitCollection: UITraitCollection.iPhone6Plus.portrait)
        public static let landscape = Presentation(
            name: "iPhone_6Plus_Landscape_Left",
            size: CGSize.iPhone.EightPlus.rotated,
            traitCollection: UITraitCollection.iPhone6Plus.landscape)
    }
    @available(iOS 9.0, *)
    public enum iPhone6S {
        public static let portrait = Presentation(
            name: "iPhone_6S_Portrait",
            size: CGSize.iPhone.Eight,
            traitCollection: UITraitCollection.iPhone6S.portrait)
        public static let landscape = Presentation(
            name: "iPhone_6S_Landscape_Left",
            size: CGSize.iPhone.Eight.rotated,
            traitCollection: UITraitCollection.iPhone6S.landscape)
    }
    @available(iOS 9.0, *)
    public enum iPhone6SPlus {
        public static let portrait = Presentation(
            name: "iPhone_6SPlus_Portrait",
            size: CGSize.iPhone.EightPlus,
            traitCollection: UITraitCollection.iPhone6SPlus.portrait)
        public static let landscape = Presentation(
            name: "iPhone_6SPlus_Landscape_Left",
            size: CGSize.iPhone.EightPlus.rotated,
            traitCollection: UITraitCollection.iPhone6SPlus.landscape)
    }
    @available(iOS 10.0, *)
    public enum iPhone7 {
        public static let portrait = Presentation(
            name: "iPhone_7_Portrait",
            size: CGSize.iPhone.Eight,
            traitCollection: UITraitCollection.iPhone7.portrait)
        public static let landscape = Presentation(
            name: "iPhone_7_Landscape_Left",
            size: CGSize.iPhone.Eight.rotated,
            traitCollection: UITraitCollection.iPhone7.landscape)
    }
    @available(iOS 10.0, *)
    public enum iPhone7Plus {
        public static let portrait = Presentation(
            name: "iPhone_7Plus_Portrait",
            size: CGSize.iPhone.EightPlus,
            traitCollection: UITraitCollection.iPhone7Plus.portrait)
        public static let landscape = Presentation(
            name: "iPhone_7Plus_Landscape_Left",
            size: CGSize.iPhone.EightPlus.rotated,
            traitCollection: UITraitCollection.iPhone7Plus.landscape)
    }
    @available(iOS 10.0, *)
    public enum iPhone8 {
        public static let portrait = Presentation(
            name: "iPhone_8_Portrait",
            size: CGSize.iPhone.Eight,
            traitCollection: UITraitCollection.iPhone8.portrait)
        public static let landscape = Presentation(
            name: "iPhone_8_Landscape",
            size: CGSize.iPhone.Eight.rotated,
            traitCollection: UITraitCollection.iPhone8.landscape)
    }
    @available(iOS 10.0, *)
    public enum iPhone8Plus {
        public static let portrait = Presentation(
            name: "iPhone_8_Plus_Portrait",
            size: CGSize.iPhone.EightPlus,
            traitCollection: UITraitCollection.iPhone8Plus.portrait)
        public static let landscape = Presentation(
            name: "iPhone_8_Plus_Landscape",
            size: CGSize.iPhone.EightPlus.rotated,
            traitCollection: UITraitCollection.iPhone8Plus.landscape)
    }
    @available(iOS 11.0, *)
    public enum iPhoneX {
        public static let portrait = Presentation(
            name: "iPhone_X_Portrait",
            size: CGSize.iPhone.X,
            traitCollection: UITraitCollection.iPhoneX.portrait,
            mask: iPhoneXMask.portrait)
        public static let landscapeRight = Presentation(
            name: "iPhone_X_Landscape_Left",
            size: CGSize.iPhone.X.rotated,
            traitCollection: UITraitCollection.iPhoneX.landscape,
            mask: iPhoneXMask.landscapeLeft)
        public static let landscapeLeft = Presentation(
            name: "iPhone_X_Landscape_Right",
            size: CGSize.iPhone.X.rotated,
            traitCollection: UITraitCollection.iPhoneX.landscape,
            mask: iPhoneXMask.landscapeRight)
    }
    public enum iPadPro12 {
        public enum Portrait{
            public static let fullScreen = Presentation(
                name: "iPad_Pro12_Portrait_FullScreen",
                size: CGSize.iPad.Pro12,
                traitCollection: UITraitCollection.iPadPro12.portrait.regular)
            public static let twoThirds = Presentation(
                name: "iPad_Pro12_Portrait_SplitView_2_3",
                size: CGSize.iPad.Pro12.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPadPro12.portrait.regular)
            public static let oneThird = Presentation(
                name: "iPad_Pro12_Portrait_SplitView_1_3",
                size: CGSize.iPad.Pro12.splitViewOneThird,
                traitCollection: UITraitCollection.iPadPro12.portrait.splitOneThird)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_Pro12_Landscape_FullScreen",
                size: CGSize.iPad.Pro12.rotated,
                traitCollection: UITraitCollection.iPadPro12.landscape.regular)
            public static let half = Presentation(
                name: "iPad_Pro12_Landscape_SplitView_1_2",
                size: CGSize.iPad.Pro12.rotated.splitViewHalf,
                traitCollection: UITraitCollection.iPadPro12.landscape.regular)
            public static let twoThird = Presentation(
                name: "iPad_Pro12_Landscape_SplitView_2_3",
                size: CGSize.iPad.Pro12.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPadPro12.landscape.regular)
            public static let oneThird = Presentation(
                name: "iPad_Pro12_Landscape_SplitView_1_3",
                size: CGSize.iPad.Pro12.rotated.splitViewOneThird,
                traitCollection: UITraitCollection.iPadPro12.landscape.splitOneThird)
        }
    }
    public enum iPadPro10 {
        public enum Portrait{
            public static let fullScreen = Presentation(
                name: "iPad_Pro10_FullScreen",
                size: CGSize.iPad.Pro10,
                traitCollection: UITraitCollection.iPadPro10.portrait.regular)
            public static let twoThirds = Presentation(
                name: "iPad_Pro10_Portrait_SplitView_2_3",
                size: CGSize.iPad.Pro10.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPadPro10.portrait.regular)
            public static let oneThird = Presentation(
                name: "iPad_Pro10_Portrait_SplitView_1_3",
                size: CGSize.iPad.Pro10.splitViewOneThird,
                traitCollection: UITraitCollection.iPadPro10.portrait.splitOneThird)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_Pro10_Landscape_FullScreen",
                size: CGSize.iPad.Pro10.rotated,
                traitCollection: UITraitCollection.iPadPro10.landscape.regular)
            public static let half = Presentation(
                name: "iPad_Pro10_Landscape_SplitView_1_2",
                size: CGSize.iPad.Pro10.rotated.splitViewHalf,
                traitCollection: UITraitCollection.iPadPro10.landscape.splitHalf)
            public static let twoThird = Presentation(
                name: "iPad_Pro10_Landscape_SplitView_2_3",
                size: CGSize.iPad.Pro10.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPadPro10.landscape.regular)
            public static let oneThird = Presentation(
                name: "iPad_Pro10_Landscape_SplitView_1_3",
                size: CGSize.iPad.Pro10.rotated.splitViewOneThird,
                traitCollection: UITraitCollection.iPadPro10.landscape.splitHalf)
        }
    }
    public enum iPadPro9 {
        public enum Portrait{
            public static let fullScreen = Presentation(
                name: "iPad_Pro9_FullScreen",
                size: CGSize.iPad.mini_air_Pro9,
                traitCollection: UITraitCollection.iPadPro9.portrait.regular)
            public static let twoThirds = Presentation(
                name: "iPad_Pro9_Portrait_SplitView_2_3",
                size: CGSize.iPad.mini_air_Pro9.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPadPro9.portrait.regular)
            public static let oneThird = Presentation(
                name: "iPad_Pro9_Portrait_SplitView_1_3",
                size: CGSize.iPad.mini_air_Pro9.splitViewOneThird,
                traitCollection: UITraitCollection.iPadPro9.portrait.splitOneThird)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_Pro9_Landscape_FullScreen",
                size: CGSize.iPad.mini_air_Pro9.rotated,
                traitCollection: UITraitCollection.iPadPro9.landscape.regular)
            public static let half = Presentation(
                name: "iPad_Pro9_Landscape_SplitView_1_2",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewHalf,
                traitCollection: UITraitCollection.iPadPro9.landscape.splitHalf)
            public static let twoThird = Presentation(
                name: "iPad_Pro9_Landscape_SplitView_2_3",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPadPro9.landscape.regular)
            public static let oneThird = Presentation(
                name: "iPad_Pro9_Landscape_SplitView_1_3",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewOneThird,
                traitCollection: UITraitCollection.iPadPro9.landscape.splitHalf)
        }
    }
    public enum iPadAir {
        public enum Portrait{
            public static let fullScreen = Presentation(
                name: "iPad_Air_FullScreen",
                size: CGSize.iPad.mini_air_Pro9,
                traitCollection: UITraitCollection.iPadAir.portrait.regular)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_Air_Landscape_FullScreen",
                size: CGSize.iPad.mini_air_Pro9.rotated,
                traitCollection: UITraitCollection.iPadAir.landscape.regular)
        }
    }
    public enum iPadAir2{
        public enum Portrait{
            public static let fullScreen = Presentation(
                name: "iPad_Air2_FullScreen",
                size: CGSize.iPad.mini_air_Pro9,
                traitCollection: UITraitCollection.iPadAir2.portrait.regular)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_Air2_Landscape_FullScreen",
                size: CGSize.iPad.mini_air_Pro9.rotated,
                traitCollection: UITraitCollection.iPadAir2.landscape.regular)
        }
    }
    public enum iPadMini {
        public enum Portrait{
            public static let fullScreen = Presentation(
                name: "iPad_mini_FullScreen",
                size: CGSize.iPad.mini_air_Pro9,
                traitCollection: UITraitCollection.iPadMini.regular)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_mini_Landscape_FullScreen",
                size: CGSize.iPad.mini_air_Pro9.rotated,
                traitCollection: UITraitCollection.iPadMini.regular)
        }
    }
    public enum iPadMini2 {
        public enum Portrait{
            public static let fullScreen = Presentation(
                name: "iPad_mini2_FullScreen",
                size: CGSize.iPad.mini_air_Pro9,
                traitCollection: UITraitCollection.iPadMini2.portrait.regular)
            public static let twoThirds = Presentation(
                name: "iPad_mini2_Portrait_SplitView_2_3",
                size: CGSize.iPad.mini_air_Pro9.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPadMini2.portrait.regular)
            public static let oneThird = Presentation(
                name: "iPad_mini2_Portrait_SplitView_1_3",
                size: CGSize.iPad.mini_air_Pro9.splitViewOneThird,
                traitCollection: UITraitCollection.iPadMini2.portrait.splitOneThird)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_mini2_Landscape_FullScreen",
                size: CGSize.iPad.mini_air_Pro9.rotated,
                traitCollection: UITraitCollection.iPadMini2.landscape.regular)
            public static let half = Presentation(
                name: "iPad_mini2_Landscape_SplitView_1_2",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewHalf,
                traitCollection: UITraitCollection.iPadMini2.landscape.splitHalf)
            public static let twoThird = Presentation(
                name: "iPad_mini2_Landscape_SplitView_2_3",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPadMini2.landscape.regular)
            public static let oneThird = Presentation(
                name: "iPad_mini2_Landscape_SplitView_1_3",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewOneThird,
                traitCollection: UITraitCollection.iPadMini2.landscape.splitHalf)
        }
    }
    public enum iPad5thGen {
        public enum Portrait {
            public static let fullScreen = Presentation(
                name: "iPad_5thGen_FullScreen",
                size: CGSize.iPad.mini_air_Pro9,
                traitCollection: UITraitCollection.iPad5thGen.portrait.regular)
            
            public static let TwoThirds = Presentation(
                name: "iPad_5thGen_Portrait_SplitView_2_3",
                size: CGSize.iPad.mini_air_Pro9.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad5thGen.portrait.regular)
            
            public static let oneThird = Presentation(
                name: "iPad_5thGenPortrait_SplitView_1_3",
                size: CGSize.iPad.mini_air_Pro9.splitViewOneThird,
                traitCollection: UITraitCollection.iPad5thGen.portrait.splitOneThird)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_5thGen_Landscape_FullScreen",
                size: CGSize.iPad.mini_air_Pro9.rotated,
                traitCollection: UITraitCollection.iPad5thGen.landscape.regular)
            
            public static let half = Presentation(
                name: "iPad_5thGen_Landscape_SplitView_1_2",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewHalf,
                traitCollection: UITraitCollection.iPad5thGen.landscape.splitHalf)
            
            public static let twoThird = Presentation(
                name: "iPad_5thGen_Landscape_SplitView_2_3",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad5thGen.landscape.regular)
            
            public static let oneThird = Presentation(
                name: "iPad_5thGen_Landscape_SplitView_1_3",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewOneThird,
                traitCollection: UITraitCollection.iPad5thGen.landscape.splitHalf)
        }
    }
}

public struct Presentation {
    
    let name: String
    let size: CGSize
    let traitCollection: UITraitCollection
    let mask: UIView?
    
    public init(name: String, size: CGSize, traitCollection: UITraitCollection, mask: UIView? = nil){
        self.name = name
        self.size = size
        self.traitCollection = traitCollection
        self.mask = mask
    }
}
