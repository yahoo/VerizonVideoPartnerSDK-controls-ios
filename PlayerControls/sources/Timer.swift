//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import Foundation

public class Timer {
    private var timer: Foundation.Timer!
    private let fire: Action<Void>
    public init(duration: TimeInterval, fire: @escaping Action<Void>) {
        self.fire = fire
        self.timer = Foundation.Timer(timeInterval: duration,
                                      target: self,
                                      selector: #selector(onFire),
                                      userInfo: nil,
                                      repeats: false)
        // http://bynomial.com/blog/?p=67
        RunLoop.main.add(self.timer, forMode: RunLoopMode.commonModes)
    }
    
    @objc private func onFire() {
        fire()
    }
    
    func cancel() {
        timer.invalidate()
    }
}
