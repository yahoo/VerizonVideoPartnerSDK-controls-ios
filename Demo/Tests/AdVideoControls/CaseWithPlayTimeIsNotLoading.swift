//
//  CaseWithPlayTimeIsLoading.swift
//  AdVideoControls
//
//  Created by rtysiachnik on 11/6/17.
//  Copyright © 2017 One by AOL : Publishers. All rights reserved.
//
import UIKit
import SnapshotTest
@testable import PlayerControls

class CaseWithPlayTimeIsNotLoading: SnapshotTest {
    
    var controller: AdVideoControls {
        let controller = AdVideoControls()
        
        controller.props = AdVideoControls.Props(
            mainAction: AdVideoControls.Props.MainAction.pause(nop),
            seeker: AdVideoControls.Props.Seeker(
                remainingPlayTime: "9999:59",
                currentValue: 0.5),
            tapAction: nop,
            isLoading: false)
        
        return controller
    }
    
    func testPortrait() {
        verify(controller, in: .portrait)
    }
    
    func testLandscape() {
        verify(controller, in: .landscape)
    }
}
