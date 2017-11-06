//
//  File.swift
//  Tests
//
//  Created by rtysiachnik on 11/1/17.
//  Copyright © 2017 One by AOL : Publishers. All rights reserved.
//
//
import FBSnapshotTestCase
import UIKit

open class SnapshotTest: FBSnapshotTestCase {
    
    override open func setUp() {
        super.setUp()
        recordMode = nil != ProcessInfo.processInfo.environment["RECORD_MODE"]
        isDeviceAgnostic = true
    }
    
    public func verify(
        _ controller: UIViewController,
        in orientation: UIInterfaceOrientationMask,
        file: StaticString = #file,
        line: UInt = #line) {
        
        let hostViewController = HostViewController()
        hostViewController.overridedSupportedInterfaceOrientations = orientation
        hostViewController.childViewController = controller
        hostViewController.view.backgroundColor = .green
        hostViewController.view.tintColor = .blue
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = hostViewController
        
        FBSnapshotVerifyView(hostViewController.view, file: file, line: line)
    }
}


