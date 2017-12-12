//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import SnappyShrimp
@testable import PlayerControls


@available(iOS 11.0, *)
class CaseWithPlayTimeIsNotLoading: SnapshotTest {
    
    var controller: AdVideoControls {
        let controller = AdVideoControls()
        controller.view.backgroundColor = .red
        
        controller.props = AdVideoControls.Props(
            mainAction: AdVideoControls.Props.MainAction.pause(nop()),
            seeker: AdVideoControls.Props.Seeker(
                remainingPlayTime: "9999:59",
                currentValue: 0.5),
            tapAction: nop() ,
            isLoading: false, airplayActiveViewHidden: false)
        return controller
    }
    
    func test() {
        verify(controller, for: Device.iPadPro12.landscape.fullScreen)
        
        verify(controller, for: Device.iPhoneX.landscapeRight)
    }
}
