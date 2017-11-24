//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import FBSnapshotTestCase
import UIKit

public typealias iPhone = HostWindow.Presentation.iPhone
public typealias iPad = HostWindow.Presentation.iPad

open class SnapshotTest: FBSnapshotTestCase {
    
    override open func setUp() {
        super.setUp()
        isDeviceAgnostic = false
        recordMode = ProcessInfo.processInfo.environment["RECORD_MODE"] == "TRUE"
    }
    
    public func verify(
        _ controller: UIViewController,
        for presentation: HostWindow.Presentation,
        file: StaticString = #file,
        line: UInt = #line) {
        
        let window = HostWindow(presentation: presentation)
        controller.view.backgroundColor = .red 
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
        FBSnapshotVerifyView(window, identifier: presentation.name, suffixes: [""], file: file, line: line)
    }
}
