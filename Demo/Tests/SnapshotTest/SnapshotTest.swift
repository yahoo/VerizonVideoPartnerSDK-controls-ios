//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import FBSnapshotTestCase
import UIKit

open class SnapshotTest: FBSnapshotTestCase {
    
    override open func setUp() {
        super.setUp()
        isDeviceAgnostic = false
        recordMode = ProcessInfo.processInfo.environment["RECORD_MODE"] == "TRUE"
    }
    
    @available(iOS 10.0, *)
    public func verify(
        _ controller: UIViewController,
        for presentation: Presentation,
        file: StaticString = #file,
        line: UInt = #line) {
        
        let window = HostWindow(presentation: presentation)
        controller.view.backgroundColor = .red 
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
        FBSnapshotVerifyView(window, identifier: presentation.name, suffixes: [""], file: file, line: line)
    }
}
