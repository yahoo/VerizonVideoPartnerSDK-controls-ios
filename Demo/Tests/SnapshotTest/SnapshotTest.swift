//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import FBSnapshotTestCase
import UIKit

///The base class of view snapshotting tests on all possible screens. By default, you have to create schemes for testing and for record. Both of them must contain enviroment arguments with paths to save images and with a value that indicates the record mode state ("RECORD_MODE" by default). For your own implementation of setting record mode true or false, override the setUp method and design your own way of running tests.
open class SnapshotTest: FBSnapshotTestCase {
    
    ///Settings for snapshot testing.
    override open func setUp() {
        super.setUp()
        isDeviceAgnostic = false
        recordMode = ProcessInfo.processInfo.environment["RECORD_MODE"] == "TRUE"
    }
    
    ///Verifies your snapshots with specified controller, whose view you're going to test and a device with its parameteres.
    @available(iOS 10.0, *)
    public final func verify(
        _ controller: UIViewController,
        for presentation: Presentation,
        with context: Context = Context(),
        file: StaticString = #file,
        line: UInt = #line) {
        
        let window = HostWindow(presentation: presentation, context: context)
        
        window.rootViewController = controller
        window.makeKeyAndVisible()
        
        FBSnapshotVerifyView(window, identifier: presentation.name, suffixes: [""], file: file, line: line)
    }
    
    ///Verifies your snapshots with specified view and device with its parameteres (controller is a UIViewController).
    @available(iOS 10.0, *)
    public final func verify(
        _ view: UIView,
        for presentation: Presentation,
        with context: Context = Context(),
        file: StaticString = #file,
        line: UInt = #line) {

        let controller = UIViewController()
        controller.view.addSubview(view)

        let window = HostWindow(presentation: presentation)
        window.rootViewController = controller
        window.makeKeyAndVisible()

        FBSnapshotVerifyView(window, identifier: presentation.name, suffixes: [""], file: file, line: line)
    }

    ///Verifies your snapshots with specified view and with custom size of the window.
    @available(iOS 10.0, *)
    public final func verify(
        _ view: UIView,
        height: Int,
        width: Int,
        with context: Context = Context(),
        file: StaticString = #file,
        line: UInt = #line) {
        
        let controller = UIViewController()
        let window = UIWindow(frame: CGRect(x: 0, y: 0, width: width, height: height))
        view.frame = window.bounds
        controller.view.addSubview(view)
        
        window.rootViewController = controller
        window.makeKeyAndVisible()

        FBSnapshotVerifyView(window, identifier: "customSize_\(width)x\(height)", suffixes: [""], file: file, line: line)
    }
}
