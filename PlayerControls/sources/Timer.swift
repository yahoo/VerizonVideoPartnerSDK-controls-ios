//  Copyright © 2017 Oath. All rights reserved.
import Foundation

public class Timer {
    private var timer: Foundation.Timer!
    private let fire: Command
    public init(duration: TimeInterval, fire: Command) {
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
        fire.perform()
    }
    
    func cancel() {
        timer.invalidate()
    }
}
