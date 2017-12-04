//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import SnapshotTest
@testable import PlayerControls


@available(iOS 11.0, *)
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
    
    func test() {
        verify(controller, for: Device.iPhone_X.landscapeRight)
        
        verify(controller, for: Device.iPad_Pro12_9.Landscape.fullScreen)
    }
}
