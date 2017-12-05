//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

///An enum that has all iOS devices. Choose device, its orientation and if you going to choose iPad, you have also to choose between one of the display modes.
public enum Device {
    public enum iPhone_SE {
        public static var portrait = Presentation.iPhone_SE.portrait
        public static var landscape = Presentation.iPhone_SE.landscape
    }
    public enum iPhone_6 {
        public static var portrait = Presentation.iPhone_6.portrait
        public static var landscape = Presentation.iPhone_6.landscape
    }
    public enum iPhone_6Plus {
        public static var portrait = Presentation.iPhone_6Plus.portrait
        public static var landscape = Presentation.iPhone_6Plus.landscape
    }
    public enum iPhone_6S {
        public static var portrait = Presentation.iPhone_6S.portrait
        public static var landscape = Presentation.iPhone_6S.landscape
    }
    public enum iPhone_6SPlus {
        public static var portrait = Presentation.iPhone_6SPlus.portrait
        public static var landscape = Presentation.iPhone_6SPlus.landscape
    }
    public enum iPhone_7 {
        public static var portrait = Presentation.iPhone_7.portrait
        public static var landscape = Presentation.iPhone_7.landscape
    }
    public enum iPhone_7Plus {
        public static var portrait = Presentation.iPhone_7Plus.portrait
        public static var landscape = Presentation.iPhone_7Plus.landscape
    }
    public enum iPhone_8 {
        public static var portrait = Presentation.iPhone_8.portrait
        public static var landscape = Presentation.iPhone_8.landscape
    }
    public enum iPhone_8Plus {
        public static var portrait = Presentation.iPhone_8Plus.portrait
        public static var landscape = Presentation.iPhone_8Plus.landscape
    }
    @available(iOS 11.0, *)
    public enum iPhone_X {
        public static var portrait = Presentation.iPhone_X.portrait
        public static var landscapeRight = Presentation.iPhone_X.landscapeRight
        public static var landscapeLeft = Presentation.iPhone_X.landscapeLeft
    }
    public enum iPad_Pro12 {
        public enum Portrait{
            public static let fullScreen = Presentation.iPad_Pro12.Portrait.fullScreen
            public static let twoThirds = Presentation.iPad_Pro12.Portrait.twoThirds
            public static let oneThird = Presentation.iPad_Pro12.Portrait.oneThird
        }
        public enum Landscape {
            public static let fullScreen = Presentation.iPad_Pro12.Portrait.fullScreen
            public static let half = Presentation.iPad_Pro12.Landscape.half
            public static let twoThird = Presentation.iPad_Pro12.Landscape.twoThird
            public static let oneThird = Presentation.iPad_Pro12.Landscape.oneThird
        }
    }
    public enum iPad_Pro10 {
        public enum Portrait{
            public static let fullScreen = Presentation.iPad_Pro10.Portrait.fullScreen
            public static let twoThirds = Presentation.iPad_Pro10.Portrait.twoThirds
            public static let oneThird = Presentation.iPad_Pro10.Portrait.oneThird
        }
        public enum Landscape {
            public static let fullScreen = Presentation.iPad_Pro10.Portrait.fullScreen
            public static let half = Presentation.iPad_Pro10.Landscape.half
            public static let twoThird = Presentation.iPad_Pro10.Landscape.twoThird
            public static let oneThird = Presentation.iPad_Pro10.Landscape.oneThird
        }
    }
    public enum iPad_Pro9 {
        public enum Portrait{
            public static let fullScreen = Presentation.iPad_Pro9.Portrait.fullScreen
            public static let twoThirds = Presentation.iPad_Pro9.Portrait.twoThirds
            public static let oneThird = Presentation.iPad_Pro9.Portrait.oneThird
        }
        public enum Landscape {
            public static let fullScreen = Presentation.iPad_Pro9.Portrait.fullScreen
            public static let half = Presentation.iPad_Pro9.Landscape.half
            public static let twoThird = Presentation.iPad_Pro9.Landscape.twoThird
            public static let oneThird = Presentation.iPad_Pro9.Landscape.oneThird
        }
    }
    public enum iPad_Air {
        public enum Portrait{
            public static let fullScreen = Presentation.iPad_Air.Portrait.fullScreen
        }
        public enum Landscape {
            public static let fullScreen = Presentation.iPad_Air.Portrait.fullScreen
        }
    }
    public enum iPad_Air2{
        public enum Portrait{
            public static let fullScreen = Presentation.iPad_Air2.Portrait.fullScreen
        }
    }
    public enum iPad_mini {
        public enum Portrait{
            public static let fullScreen = Presentation.iPad_mini.Portrait.fullScreen
        }
        public enum Landscape {
            public static let fullScreen = Presentation.iPad_mini.Portrait.fullScreen
        }
    }
    public enum iPad_mini2 {
        public enum Portrait{
            public static let fullScreen = Presentation.iPad_mini2.Portrait.fullScreen
            public static let twoThirds = Presentation.iPad_mini2.Portrait.twoThirds
            public static let oneThird = Presentation.iPad_mini2.Portrait.oneThird
        }
        public enum Landscape {
            public static let fullScreen = Presentation.iPad_mini2.Portrait.fullScreen
            public static let half = Presentation.iPad_mini2.Landscape.half
            public static let twoThird = Presentation.iPad_mini2.Landscape.twoThird
            public static let oneThird = Presentation.iPad_mini2.Landscape.oneThird
        }
    }
}

@available(iOS 10.0, *)
public struct Presentation {
    
    let name: String
    let size: CGSize
    var traitCollection: UITraitCollection
    let mask: UIView?
    
    //MARK: Presentations for iPhones
    public enum iPhone_SE {
        public static var portrait: Presentation {
            return Presentation(
                name: "iPhone_SE_Portrait",
                size: CGSize.iPhone.SE,
                traitCollection: UITraitCollection.iPhone_SE.portrait)
        }
        public static var landscape: Presentation {
            return Presentation(
                name: "iPhone_SE_Landscape",
                size: CGSize.iPhone.SE.rotated,
                traitCollection: UITraitCollection.iPhone_SE.landscape)
        }
    }
    public enum iPhone_6 {
        public static var portrait: Presentation {
            return Presentation(
                name: "iPhone_6_Portrait",
                size: CGSize.iPhone.Eight,
                traitCollection: UITraitCollection.iPhone_6.portrait)
        }
        public static var landscape: Presentation {
            return Presentation(
                name: "iPhone_6_Landscape_Left",
                size: CGSize.iPhone.Eight.rotated,
                traitCollection: UITraitCollection.iPhone_6.landscape)
        }
    }
    public enum iPhone_6Plus {
        public static var portrait: Presentation {
            return Presentation(
                name: "iPhone6Plus_Portrait",
                size: CGSize.iPhone.EightPlus,
                traitCollection: UITraitCollection.iPhone_6Plus.portrait)
        }
        public static var landscape: Presentation {
            return Presentation(
                name: "iPhone_6Plus_Landscape_Left",
                size: CGSize.iPhone.EightPlus.rotated,
                traitCollection: UITraitCollection.iPhone_6Plus.landscape)
        }
    }
    public enum iPhone_6S {
        public static var portrait: Presentation {
            return Presentation(
                name: "iPhone_6S_Portrait",
                size: CGSize.iPhone.Eight,
                traitCollection: UITraitCollection.iPhone_6S.portrait)
        }
        public static var landscape: Presentation {
            return Presentation(
                name: "iPhone_6S_Landscape_Left",
                size: CGSize.iPhone.Eight.rotated,
                traitCollection: UITraitCollection.iPhone_6S.landscape)
        }
    }
    public enum iPhone_6SPlus {
        public static var portrait: Presentation {
            return Presentation(
                name: "iPhone_6SPlus_Portrait",
                size: CGSize.iPhone.EightPlus,
                traitCollection: UITraitCollection.iPhone_6SPlus.portrait)
        }
        public static var landscape: Presentation {
            return Presentation(
                name: "iPhone_6SPlus_Landscape_Left",
                size: CGSize.iPhone.EightPlus.rotated,
                traitCollection: UITraitCollection.iPhone_6SPlus.landscape)
        }
    }
    public enum iPhone_7 {
        public static var portrait: Presentation {
            return Presentation(
                name: "iPhone_7_Portrait",
                size: CGSize.iPhone.Eight,
                traitCollection: UITraitCollection.iPhone_7.portrait)
        }
        public static var landscape: Presentation {
            return Presentation(
                name: "iPhone_7_Landscape_Left",
                size: CGSize.iPhone.Eight.rotated,
                traitCollection: UITraitCollection.iPhone_7.landscape)
        }
    }
    public enum iPhone_7Plus {
        public static var portrait: Presentation {
            return Presentation(
                name: "iPhone_7Plus_Portrait",
                size: CGSize.iPhone.EightPlus,
                traitCollection: UITraitCollection.iPhone_7Plus.portrait)
        }
        public static var landscape: Presentation {
            return Presentation(
                name: "iPhone_7Plus_Landscape_Left",
                size: CGSize.iPhone.EightPlus.rotated,
                traitCollection: UITraitCollection.iPhone_7Plus.landscape)
        }
    }
    public enum iPhone_8 {
        public static var portrait: Presentation {
            return Presentation(
                name: "iPhone_8_Portrait",
                size: CGSize.iPhone.Eight,
                traitCollection: UITraitCollection.iPhone_8.portrait)
        }
        public static var landscape: Presentation {
            return Presentation(
                name: "iPhone_8_Landscape",
                size: CGSize.iPhone.Eight.rotated,
                traitCollection: UITraitCollection.iPhone_8.landscape)
        }
        
    }
    public enum iPhone_8Plus {
        public static var portrait: Presentation {
            return Presentation(
                name: "iPhone_8_Plus_Portrait",
                size: CGSize.iPhone.EightPlus,
                traitCollection: UITraitCollection.iPhone_8Plus.portrait)
        }
        public static var landscape: Presentation {
            return Presentation(
                name: "iPhone_8_Plus_Landscape",
                size: CGSize.iPhone.EightPlus.rotated,
                traitCollection: UITraitCollection.iPhone_8Plus.landscape)
        }
    }
    @available(iOS 11.0, *)
    public enum iPhone_X {
        public static var portrait: Presentation {
            return Presentation(
                name: "iPhone_X_Portrait",
                size: CGSize.iPhone.X,
                traitCollection: UITraitCollection.iPhone_X.portrait,
                mask: iPhoneXMask.portrait)
        }
        public static var landscapeLeft: Presentation {
            return Presentation(
                name: "iPhone_X_Landscape_Left",
                size: CGSize.iPhone.X.rotated,
                traitCollection: UITraitCollection.iPhone_X.landscape,
                mask: iPhoneXMask.landscapeLeft)
        }
        public static var landscapeRight: Presentation {
            return Presentation(
                name: "iPhone_X_Landscape_Right",
                size: CGSize.iPhone.X.rotated,
                traitCollection: UITraitCollection.iPhone_X.landscape,
                mask: iPhoneXMask.landscapeRight)
        }
    }
    //MARK: Presentations for iPad
    public enum iPad_Pro12 {
        public enum Portrait{
            public static let fullScreen = Presentation(
                name: "iPad_Pro12_Portrait_FullScreen",
                size: CGSize.iPad.Pro12,
                traitCollection: UITraitCollection.iPad_Pro12_9.portrait.regular)
            
            public static let twoThirds = Presentation(
                name: "iPad_Pro12_Portrait_SplitView_2_3",
                size: CGSize.iPad.Pro12.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad_Pro12_9.portrait.regular)
            
            public static let oneThird = Presentation(
                name: "iPad_Pro12_Portrait_SplitView_1_3",
                size: CGSize.iPad.Pro12.splitViewOneThird,
                traitCollection: UITraitCollection.iPad_Pro12_9.portrait.splitOneThird)
            
        }
        public enum Landscape {
            
            public static let fullScreen = Presentation(
                name: "iPad_Pro12_Landscape_FullScreen",
                size: CGSize.iPad.Pro12.rotated,
                traitCollection: UITraitCollection.iPad_Pro12_9.landscape.regular)
            
            public static let half = Presentation(
                name: "iPad_Pro12_Landscape_SplitView_1_2",
                size: CGSize.iPad.Pro12.rotated.splitViewHalf,
                traitCollection: UITraitCollection.iPad_Pro12_9.landscape.regular)
            
            public static let twoThird = Presentation(
                name: "iPad_Pro12_Landscape_SplitView_2_3",
                size: CGSize.iPad.Pro12.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad_Pro12_9.landscape.regular)
            
            public static let oneThird = Presentation(
                name: "iPad_Pro12_Landscape_SplitView_1_3",
                size: CGSize.iPad.Pro12.rotated.splitViewOneThird,
                traitCollection: UITraitCollection.iPad_Pro12_9.landscape.splitOneThird)
            
        }
    }
    public enum iPad_Pro10 {
        public enum Portrait {
            public static let fullScreen = Presentation(
                name: "iPad_Pro10_FullScreen",
                size: CGSize.iPad.Pro10,
                traitCollection: UITraitCollection.iPad_Pro10_5.portrait.regular)
            
            public static let twoThirds = Presentation(
                name: "iPad_Pro10_Portrait_SplitView_2_3",
                size: CGSize.iPad.Pro10.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad_Pro10_5.portrait.regular)
            
            public static let oneThird = Presentation(
                name: "iPad_Pro10_Portrait_SplitView_1_3",
                size: CGSize.iPad.Pro10.splitViewOneThird,
                traitCollection: UITraitCollection.iPad_Pro10_5.portrait.splitOneThird)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_Pro10_Landscape_FullScreen",
                size: CGSize.iPad.Pro10.rotated,
                traitCollection: UITraitCollection.iPad_Pro10_5.landscape.regular)
            
            public static let half = Presentation(
                name: "iPad_Pro10_Landscape_SplitView_1_2",
                size: CGSize.iPad.Pro10.rotated.splitViewHalf,
                traitCollection: UITraitCollection.iPad_Pro10_5.landscape.splitHalf)
            
            public static let twoThird = Presentation(
                name: "iPad_Pro10_Landscape_SplitView_2_3",
                size: CGSize.iPad.Pro10.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad_Pro10_5.landscape.regular)
            
            public static let oneThird = Presentation(
                name: "iPad_Pro10_Landscape_SplitView_1_3",
                size: CGSize.iPad.Pro10.rotated.splitViewOneThird,
                traitCollection: UITraitCollection.iPad_Pro10_5.landscape.splitHalf)
        }
    }
    public enum iPad_Pro9 {
        public enum Portrait {
            public static let fullScreen = Presentation(
                name: "iPad_Pro9_FullScreen",
                size: CGSize.iPad.mini_air_Pro9,
                traitCollection: UITraitCollection.iPad_Pro9_7.portrait.regular)
            
            public static let twoThirds = Presentation(
                name: "iPad_Pro9_Portrait_SplitView_2_3",
                size: CGSize.iPad.mini_air_Pro9.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad_Pro9_7.portrait.regular)
            
            public static let oneThird = Presentation(
                name: "iPad_Pro9_Portrait_SplitView_1_3",
                size: CGSize.iPad.mini_air_Pro9.splitViewOneThird,
                traitCollection: UITraitCollection.iPad_Pro9_7.portrait.splitOneThird)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_Pro9_Landscape_FullScreen",
                size: CGSize.iPad.mini_air_Pro9.rotated,
                traitCollection: UITraitCollection.iPad_Pro9_7.landscape.regular)
            
            public static let half = Presentation(
                name: "iPad_Pro9_Landscape_SplitView_1_2",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewHalf,
                traitCollection: UITraitCollection.iPad_Pro9_7.landscape.splitHalf)
            
            public static let twoThird = Presentation(
                name: "iPad_Pro9_Landscape_SplitView_2_3",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad_Pro9_7.landscape.regular)
            
            public static let oneThird = Presentation(
                name: "iPad_Pro9_Landscape_SplitView_1_3",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewOneThird,
                traitCollection: UITraitCollection.iPad_Pro9_7.landscape.splitHalf)
        }
    }
    public enum iPad_Air {
        public enum Portrait {
            public static let fullScreen = Presentation(
                name: "iPad_Air_FullScreen",
                size: CGSize.iPad.mini_air_Pro9,
                traitCollection: UITraitCollection.iPad_Air.portrait.regular)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_Air_Landscape_FullScreen",
                size: CGSize.iPad.mini_air_Pro9.rotated,
                traitCollection: UITraitCollection.iPad_Air.landscape.regular)
        }
    }
    public enum iPad_Air2 {
        public enum Portrait {
            public static let fullScreen = Presentation(
                name: "iPad_Air2_FullScreen",
                size: CGSize.iPad.mini_air_Pro9,
                traitCollection: UITraitCollection.iPad_Air2.portrait.regular)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_Air2_Landscape_FullScreen",
                size: CGSize.iPad.mini_air_Pro9.rotated,
                traitCollection: UITraitCollection.iPad_Air2.landscape.regular)
        }
    }
    public enum iPad_mini {
        public enum Portrait {
            public static let fullScreen = Presentation(
                name: "iPad_mini_FullScreen",
                size: CGSize.iPad.mini_air_Pro9,
                traitCollection: UITraitCollection.iPad_mini.regular)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_mini_Landscape_FullScreen",
                size: CGSize.iPad.mini_air_Pro9.rotated,
                traitCollection: UITraitCollection.iPad_mini.regular)
        }
    }
    public enum iPad_mini2 {
        public enum Portrait {
            public static let fullScreen = Presentation(
                name: "iPad_mini2_FullScreen",
                size: CGSize.iPad.mini_air_Pro9,
                traitCollection: UITraitCollection.iPad_mini2.portrait.regular)
            
            public static let twoThirds = Presentation(
                name: "iPad_mini2_Portrait_SplitView_2_3",
                size: CGSize.iPad.mini_air_Pro9.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad_mini2.portrait.regular)
            
            public static let oneThird = Presentation(
                name: "iPad_mini2_Portrait_SplitView_1_3",
                size: CGSize.iPad.mini_air_Pro9.splitViewOneThird,
                traitCollection: UITraitCollection.iPad_mini2.portrait.splitOneThird)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_mini2_Landscape_FullScreen",
                size: CGSize.iPad.mini_air_Pro9.rotated,
                traitCollection: UITraitCollection.iPad_mini2.landscape.regular)
            
            public static let half = Presentation(
                name: "iPad_mini2_Landscape_SplitView_1_2",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewHalf,
                traitCollection: UITraitCollection.iPad_mini2.landscape.splitHalf)
            
            public static let twoThird = Presentation(
                name: "iPad_mini2_Landscape_SplitView_2_3",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad_mini2.landscape.regular)
            
            public static let oneThird = Presentation(
                name: "iPad_mini2_Landscape_SplitView_1_3",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewOneThird,
                traitCollection: UITraitCollection.iPad_mini2.landscape.splitHalf)
        }
    }
    public enum iPad_5thGen {
        public enum Portrait {
            public static let fullScreen = Presentation(
                name: "iPad_5thGen_FullScreen",
                size: CGSize.iPad.mini_air_Pro9,
                traitCollection: UITraitCollection.iPad_5thGen.portrait.regular)
            
            public static let TwoThirds = Presentation(
                name: "iPad_5thGen_Portrait_SplitView_2_3",
                size: CGSize.iPad.mini_air_Pro9.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad_5thGen.portrait.regular)
            
            public static let oneThird = Presentation(
                name: "iPad_5thGenPortrait_SplitView_1_3",
                size: CGSize.iPad.mini_air_Pro9.splitViewOneThird,
                traitCollection: UITraitCollection.iPad_5thGen.portrait.splitOneThird)
        }
        public enum Landscape {
            public static let fullScreen = Presentation(
                name: "iPad_5thGen_Landscape_FullScreen",
                size: CGSize.iPad.mini_air_Pro9.rotated,
                traitCollection: UITraitCollection.iPad_5thGen.landscape.regular)
            
            public static let half = Presentation(
                name: "iPad_5thGen_Landscape_SplitView_1_2",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewHalf,
                traitCollection: UITraitCollection.iPad_5thGen.landscape.splitHalf)
            
            public static let twoThird = Presentation(
                name: "iPad_5thGen_Landscape_SplitView_2_3",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewTwoThirds,
                traitCollection: UITraitCollection.iPad_5thGen.landscape.regular)
            
            public static let oneThird = Presentation(
                name: "iPad_5thGen_Landscape_SplitView_1_3",
                size: CGSize.iPad.mini_air_Pro9.rotated.splitViewOneThird,
                traitCollection: UITraitCollection.iPad_5thGen.landscape.splitHalf)
        }
    }
    
    public init(name: String, size: CGSize, traitCollection: UITraitCollection, mask: UIView? = nil){
        self.name = name
        self.size = size
        self.traitCollection = traitCollection
        self.mask = mask
    }
}
