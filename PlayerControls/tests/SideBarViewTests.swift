//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import XCTest
import UIKit
import Nimble
@testable import OneMobileSDK

class SideBarViewTests: XCTestCase {
    func testNoButtons() {
        let origins = SideBarView.buttonOrigins(
            buttonSize:[],
            parentSize: CGSize(width: 200, height: 200),
            spacingY: 20)
        expect(origins.count) == 0
    }
    
    func testThreeButtons() {
        let origins = SideBarView.buttonOrigins(
            buttonSize:[
                CGSize(width: 100, height: 100),
                CGSize(width: 50, height: 50),
                CGSize(width: 75, height: 75)],
            parentSize: CGSize(width: 200, height: 200),
            spacingY: 20)
        
        let firstButton = origins[0]
        expect(firstButton.x) == 100
        expect(firstButton.y) == 20

        let secondButton = origins[1]
        expect(secondButton.x) == 150
        expect(secondButton.y) == 140
        
        let thirdButton = origins[2]
        expect(thirdButton.x) == 125
        expect(thirdButton.y) == 210
    }
    
    func test1ButtonVerticalSpacing() {
        expect(SideBarView.verticalSpacingForButtons(withHeights: [10], in: 100)) == 45
    }
    
    func test2ButtonsVerticalSpacing() {
        expect(SideBarView.verticalSpacingForButtons(withHeights: [10, 10], in: 98)) == 26
    }
    
    func test2ButtonsWithDifferentFramesVerticalSpacing() {
        expect(SideBarView.verticalSpacingForButtons(withHeights: [10, 20], in: 93)) == 21
    }
    
    func testZeroHeightVerticalSpacing() {
        expect(SideBarView.verticalSpacingForButtons(withHeights: [10, 10], in: 0)) == -20
    }
    
    func testNoButtonsVerticalSpacing() {
        expect(SideBarView.verticalSpacingForButtons(withHeights: [], in: 100)) == 0
    }
    
    func test3ButtonsVerticalSpacing() {
        expect(SideBarView.verticalSpacingForButtons(
            withHeights: [10, 10, 10], in: 100)) == 17.5
    }
    
    func test4ButtonsVerticalSpacing() {
        expect(SideBarView.verticalSpacingForButtons(
            withHeights: [10, 10, 10, 10], in: 100)) == 12.0
    }
    
    func testButtonBiggerThanContainer() {
        expect(SideBarView.verticalSpacingForButtons(
            withHeights: [200, 200], in: 100)) == -300
    }
    
    func test1ButtonBiggerThanContainer() {
        expect(SideBarView.verticalSpacingForButtons(
            withHeights: [200], in: 100)) == 0
    }
}
