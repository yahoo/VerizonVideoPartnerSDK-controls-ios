//  Copyright © 2017 Oath. All rights reserved.

import Foundation

final class AnimationDelegate: NSObject, CAAnimationDelegate {
    let didStart: ((CAAnimation) -> ())?
    let didStop: ((CAAnimation, Bool) -> ())?
    
    init(didStart: ((CAAnimation) -> ())? = nil, didStop: ((CAAnimation, Bool) -> ())? = nil) {
        self.didStart = didStart
        self.didStop = didStop
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        self.didStart?(anim)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.didStop?(anim, flag)
    }
}
