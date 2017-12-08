//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import SnapshotTest
@testable import PlayerControls


@available(iOS 11.0, *)
class CaseWithPlayTimeIsLoading: SnapshotTest {
    
    var controller: AdVideoControls {
        let controller = AdVideoControls()
        controller.view.backgroundColor = .red
        
        controller.props = AdVideoControls.Props(
            mainAction: AdVideoControls.Props.MainAction.play(nop),
            seeker: AdVideoControls.Props.Seeker(remainingPlayTime: "0:00", currentValue: 1),
            tapAction: nop,
            isLoading: true, airplayActiveViewHidden: true)
        return controller
    }
    
   private enum Errors: Error {
        case notValidIdiom
    }
    
    func test()throws {
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            verifyPads()
        case .phone:
            verifyPhones()
        default:
            throw Errors.notValidIdiom
        }
    }
    
    func verifyPads() {
        verify(controller, for: Device.iPhoneX.portrait)
        verify(controller, for: Device.iPhoneX.landscapeLeft)
    }
    
    func verifyPhones() {
        verify(controller, for: Device.iPadPro9.portrait.oneThird)
    }
}

