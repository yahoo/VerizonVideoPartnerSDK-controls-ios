//  Copyright © 2017 Oath. All rights reserved.

import Foundation

final class AnimationDelegate: NSObject, CAAnimationDelegate {
    let didStop: ((CAAnimation, Bool) -> ())?
    
    init(didStop: ((CAAnimation, Bool) -> ())? = nil) {
        self.didStop = didStop
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.didStop?(anim, flag)
    }
}
