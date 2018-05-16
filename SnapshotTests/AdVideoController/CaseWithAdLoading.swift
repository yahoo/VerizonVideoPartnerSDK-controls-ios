//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import SnappyShrimp
@testable import PlayerControls

class CaseWithAdLoading: SnapshotTest {
    
    var controller: AdVideoControls {
        let controller = AdVideoControls()
        controller.view.backgroundColor = .red
        controller.view.tintColor = .blue
        
        controller.props = AdVideoControls.Props(
            mainAction: AdVideoControls.Props.MainAction.pause(.nop),
            seeker: AdVideoControls.Props.Seeker(
                remainingPlayTime: "9999:59",
                currentValue: 0,
                accessibilityLabel: ""),
            click: .nop,
            isLoading: true, airplayActiveViewHidden: true)
        return controller
    }
    
    func test() {
        if #available(iOS 11.0, *) {
            verify(controller, for: Device.iPhoneX.landscapeLeft)
        }
        verify(controller, for: Device.iPadPro12.portrait.fullScreen)
    }
}
