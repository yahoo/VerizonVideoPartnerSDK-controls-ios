//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

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
        RunLoop.main.add(self.timer, forMode: RunLoop.Mode.common)
    }
    
    @objc private func onFire() {
        fire.perform()
    }
    
    func cancel() {
        timer.invalidate()
    }
}
