//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import SnappyShrimp
@testable import PlayerControls

class CaseWithAirPlayActive: SnapshotTest {
    
    var controller: AdVideoControls {
        let controller = AdVideoControls()
        controller.view.backgroundColor = .red
        controller.view.tintColor = .blue
        
        controller.props = AdVideoControls.Props(
            mainAction: AdVideoControls.Props.MainAction.play(.nop),
            seeker: AdVideoControls.Props.Seeker(
                remainingPlayTime: "0:30",
                currentValue: 0.5,
                accessibilityLabel: ""),
            click: .nop,
            isLoading: false, airplayActiveViewHidden: false)
        return controller
    }
    
    func test() {
        if #available(iOS 11.0, *) {
            verify(controller, for: Device.iPhoneX.portrait)
            verify(controller, for: Device.iPhoneX.landscapeLeft)
        }
        if #available(iOS 11.0, *) {
            verify(controller, for: Device.iPadPro9.portrait.oneThird)
        }
    }
}

