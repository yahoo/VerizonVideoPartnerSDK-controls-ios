// Copyright © 2017 Oath. All rights reserved.

import SnappyShrimp

class DefaulController: SnapshotTest {
    
    func testExample() {
        let vc = UIViewController()
        vc.view.backgroundColor = .blue
        
        if #available(iOS 11.0, *) {
            verify(vc, for: Device.iPhone8Plus.portrait)
        }
    }
}
