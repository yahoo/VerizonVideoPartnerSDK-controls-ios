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


class CaseWithPlayTimeIsLoading: SnapshotTest {
    
    var controller: AdVideoControls {
        let controller = AdVideoControls()
        
        controller.props = AdVideoControls.Props(
            mainAction: AdVideoControls.Props.MainAction.play(nop),
            seeker: AdVideoControls.Props.Seeker(remainingPlayTime: "0:00", currentValue: 1),
            tapAction: nop,
            isLoading: true)
        
        return controller
    }
    
    func test() {
        verify(controller, for: iPhone.X.portrait)
        verify(controller, for: iPhone.X.landscapeLeft)
        
        verify(controller, for: iPad.Pro9_7.Portrait.OneThirds)
    }
}

