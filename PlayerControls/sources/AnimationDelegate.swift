//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.


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
