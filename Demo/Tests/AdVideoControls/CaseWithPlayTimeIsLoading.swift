//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import SnapshotTest
@testable import PlayerControls


@available(iOS 11.0, *)
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
        verify(controller, for: Device.iPhone_X.portrait)
        verify(controller, for: Device.iPhone_X.landscapeLeft)
        
        verify(controller, for: Device.iPad_Pro9_7.Portrait.oneThird)
    }
}

