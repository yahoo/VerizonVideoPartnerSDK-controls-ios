//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit

@available(iOS 10.0, *)
public class HostWindow: UIWindow {
    
    public var presentation: Presentation
    private var traits: UITraitCollection
    
    override public var traitCollection: UITraitCollection {
        return traits
    }
    
    struct Context {
        var layoutDirection = UITraitEnvironmentLayoutDirection.unspecified
        var contentSizeCategory = UIContentSizeCategory.unspecified
        
        public func getTraits() -> UITraitCollection {
            return UITraitCollection(traitsFrom: [UITraitCollection(layoutDirection: self.layoutDirection),
                                                  UITraitCollection(preferredContentSizeCategory: self.contentSizeCategory)])
        }
    }
    
    
    init(presentation: Presentation, context: Context = .init()) {
        
        self.presentation = presentation
        self.traits = UITraitCollection(traitsFrom: [presentation.traitCollection, context.getTraits()])
        super.init(frame: presentation.size.asRect)
        self.mask = presentation.mask
        self.mask?.frame = self.bounds
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public struct Presentation {
        
        let name: String
        let size: CGSize
        var traitCollection: UITraitCollection
        let mask: UIView?
        
        
        public enum iPhone{
            @available(iOS 10.0, *)
            public enum X {
                
                public static var portrait: Presentation {
                    return Presentation(
                        name: "iPhone_X_Portrait",
                        size: CGSize.iPhone.X,
                        traitCollection: UITraitCollection.iPhone.X.portrait,
                        mask: iPhoneXMask.portrait)
                }
                public static var landscapeLeft: Presentation {
                    return Presentation(
                        name: "iPhone_X_Landscape_Left",
                        size: CGSize.iPhone.X.rotated,
                        traitCollection: UITraitCollection.iPhone.X.landscape,
                        mask: iPhoneXMask.landscapeLeft)
                }
                public static var landscapeRight: Presentation {
                    return Presentation(
                        name: "iPhone_X_Landscape_Right",
                        size: CGSize.iPhone.X.rotated,
                        traitCollection: UITraitCollection.iPhone.X.landscape,
                        mask: iPhoneXMask.landscapeRight)
                }
            }
            public enum Eight {
                public static var portrait: Presentation {
                    return Presentation(
                        name: "iPhone_8_Portrait",
                        size: CGSize.iPhone.Eight,
                        traitCollection: UITraitCollection.iPhone._8.portrait,
                        mask: nil)
                }
                public static var landscape: Presentation {
                    return Presentation(
                        name: "iPhone_8_Landscape",
                        size: CGSize.iPhone.Eight.rotated,
                        traitCollection: UITraitCollection.iPhone._8.landscape,
                        mask: nil)
                }
                
            }
            public enum EightPlus {
                public static var portrait: Presentation {
                    return Presentation(
                        name: "iPhone_8_Plus_Portrait",
                        size: CGSize.iPhone.EightPlus,
                        traitCollection: UITraitCollection.iPhone._8Plus.portrait,
                        mask: nil)
                }
                public static var landscape: Presentation {
                    return Presentation(
                        name: "iPhone_8_Plus_Landscape",
                        size: CGSize.iPhone.EightPlus.rotated,
                        traitCollection: UITraitCollection.iPhone._8Plus.landscape,
                        mask: nil)
                }
            }
            public enum SevenPlus{
                public static var portrait = Presentation.iPhone.EightPlus.portrait
                public static var landscape = Presentation.iPhone.EightPlus.landscape
            }
            public enum SE {
                public static var portrait: Presentation {
                    return Presentation(
                        name: "iPhone_SE_Portrait",
                        size: CGSize.iPhone.SE,
                        traitCollection: UITraitCollection.iPhone.SE.portrait,
                        mask: nil)
                }
                public static var landscape: Presentation {
                    return Presentation(
                        name: "iPhone_SE_Landscape",
                        size: CGSize.iPhone.SE.rotated,
                        traitCollection: UITraitCollection.iPhone.SE.landscape,
                        mask: nil)
                }
                
            }
        }
        
        
        public enum iPad {
            public enum Pro12_9 {
                public enum Portrait{
                    public static let fullScreen = Presentation(
                        name: "iPad_12.9_Portrait_FullScreen",
                        size: CGSize.iPad.Pro12_9,
                        traitCollection: UITraitCollection.iPad.Pro12_9.regular)
                    
                    public static let twoThirds = Presentation(
                        name: "iPad_12.9_Portrait_SplitView_2_3",
                        size: CGSize.iPad.Pro12_9.splitViewTwoThirds,
                        traitCollection: UITraitCollection.iPad.Pro12_9.regular)
                    
                    public static let oneThirds = Presentation(
                        name: "iPad_12.9_Portrait_SplitView_1_3",
                        size: CGSize.iPad.Pro12_9.splitViewOneThird,
                        traitCollection: UITraitCollection.iPad.Pro12_9.splitOneThird)
                    
                }
                public enum Landscape {
                    
                    public static let fullScreen = Presentation(
                        name: "iPad_12.9_Landscape_FullScreen",
                        size: CGSize.iPad.Pro12_9.rotated,
                        traitCollection: UITraitCollection.iPad.Pro12_9.regular)
                    
                    public static let half = Presentation(
                        name: "iPad_12.9_Landscape_SplitView_1_2",
                        size: CGSize.iPad.Pro12_9.rotated.splitViewHalf,
                        traitCollection: UITraitCollection.iPad.Pro12_9.regular)
                    
                    public static let twoThird = Presentation(
                        name: "iPad_12.9_Landscape_SplitView_2_3",
                        size: CGSize.iPad.Pro12_9.rotated.splitViewTwoThirds,
                        traitCollection: UITraitCollection.iPad.Pro12_9.regular)
                    
                    public static let oneThird = Presentation(
                        name: "iPad_12.9_Landscape_SplitView_1_3",
                        size: CGSize.iPad.Pro12_9.rotated.splitViewOneThird,
                        traitCollection: UITraitCollection.iPad.Pro12_9.splitOneThird)
                    
                }
            }
            public enum Pro10_5 {
                public enum Portrait {
                    
                    public static let fullScreen = Presentation(
                        name: "iPad_10.5_FullScreen",
                        size: CGSize.iPad.Pro10_5,
                        traitCollection: UITraitCollection.iPad.Pro10_5.regular)
                    
                    public static let TwoThirds = Presentation(
                        name: "iPad_10.5_Portrait_SplitView_2_3",
                        size: CGSize.iPad.Pro10_5.splitViewTwoThirds,
                        traitCollection: UITraitCollection.iPad.Pro10_5.regular)
                    
                    public static let OneThirds = Presentation(
                        name: "iPad_10.5_Portrait_SplitView_1_3",
                        size: CGSize.iPad.Pro10_5.splitViewOneThird,
                        traitCollection: UITraitCollection.iPad.Pro10_5.splitOneThird)
                }
                public enum Landscape {
                    public static let fullScreen = Presentation(
                        name: "iPad_10.5_Landscape_FullScreen",
                        size: CGSize.iPad.Pro10_5.rotated,
                        traitCollection: UITraitCollection.iPad.Pro10_5.regular)
                    
                    public static let half = Presentation(
                        name: "iPad_10.5_Landscape_SplitView_1_2",
                        size: CGSize.iPad.Pro10_5.rotated.splitViewHalf,
                        traitCollection: UITraitCollection.iPad.Pro10_5.splitHalf)
                    
                    public static let twoThird = Presentation(
                        name: "iPad_10.5_Landscape_SplitView_2_3",
                        size: CGSize.iPad.Pro10_5.rotated.splitViewTwoThirds,
                        traitCollection: UITraitCollection.iPad.Pro10_5.regular)
                    
                    public static let oneThird = Presentation(
                        name: "iPad_10.5_Landscape_SplitView_1_3",
                        size: CGSize.iPad.Pro10_5.rotated.splitViewOneThird,
                        traitCollection: UITraitCollection.iPad.Pro10_5.splitHalf)
                }
            }
            
            public enum Pro9_7 {
                public enum Portrait {
                    public static let fullScreen = Presentation(
                        name: "iPad_9.7_FullScreen",
                        size: CGSize.iPad.Pro9_7,
                        traitCollection: UITraitCollection.iPad.Pro9_7.regular)
                    
                    public static let TwoThirds = Presentation(
                        name: "iPad_9.7_Portrait_SplitView_2_3",
                        size: CGSize.iPad.Pro9_7.splitViewTwoThirds,
                        traitCollection: UITraitCollection.iPad.Pro9_7.regular)
                    
                    public static let OneThirds = Presentation(
                        name: "iPad_9.7_Portrait_SplitView_1_3",
                        size: CGSize.iPad.Pro9_7.splitViewOneThird,
                        traitCollection: UITraitCollection.iPad.Pro9_7.splitOneThird)
                }
                public enum Landscape {
                    public static let fullScreen = Presentation(
                        name: "iPad_9.7_Landscape_FullScreen",
                        size: CGSize.iPad.Pro9_7.rotated,
                        traitCollection: UITraitCollection.iPad.Pro9_7.regular)
                    
                    public static let half = Presentation(
                        name: "iPad_9.7_Landscape_SplitView_1_2",
                        size: CGSize.iPad.Pro9_7.rotated.splitViewHalf,
                        traitCollection: UITraitCollection.iPad.Pro9_7.splitHalf)// [idiom.pad, vertical.regular, horizontal.regulat, scale.3]
                    
                    public static let twoThird = Presentation(
                        name: "iPad_9.7_Landscape_SplitView_2_3",
                        size: CGSize.iPad.Pro9_7.rotated.splitViewTwoThirds,
                        traitCollection: UITraitCollection.iPad.Pro9_7.regular)
                    
                    public static let oneThird = Presentation(
                        name: "iPad_9.7_Landscape_SplitView_1_3",
                        size: CGSize.iPad.Pro9_7.rotated.splitViewOneThird,
                        traitCollection: UITraitCollection.iPad.Pro9_7.splitHalf)
                }
            }
        }
        
        private init(name: String, size: CGSize, traitCollection: UITraitCollection, mask: UIView? = nil){
            self.name = name
            self.size = size
            self.traitCollection = traitCollection
            self.mask = mask
            
            
        }
    }
}





