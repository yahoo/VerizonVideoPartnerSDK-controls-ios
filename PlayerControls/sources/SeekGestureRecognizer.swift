//  Copyright © 2017 Oath. All rights reserved.
import Foundation
import UIKit.UIGestureRecognizerSubclass

class SeekGestureRecognizer: UIPanGestureRecognizer {

    var progress: CGFloat {
        guard let view = view else { fatalError("WTF. Free gesture recognizer?") }
        
        let tap = self.location(in: view).x
        let width = view.frame.width
        
        return max(0, min(tap / width, 1))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        guard state == .possible else { return }
        
        state = .began
    }
}
