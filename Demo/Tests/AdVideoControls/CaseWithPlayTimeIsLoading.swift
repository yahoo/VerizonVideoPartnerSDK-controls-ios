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
        verify(controller, for: iPhone.X.landscapeRight)
        
        verify(controller, for: iPhone.Eight.portrait)
        verify(controller, for: iPhone.Eight.landscape)
        
        verify(controller, for: iPhone.EightPlus.portrait)
        verify(controller, for: iPhone.EightPlus.landscape)
        
        verify(controller, for: iPhone.SE.portrait)
        verify(controller, for: iPhone.SE.landscape)
        
        verify(controller, for: iPad.Pro9_7.Portrait.fullScreen)
        verify(controller, for: iPad.Pro9_7.Portrait.OneThirds)
        verify(controller, for: iPad.Pro9_7.Portrait.TwoThirds)
        verify(controller, for: iPad.Pro9_7.Landscape.fullScreen)
        verify(controller, for: iPad.Pro9_7.Landscape.oneThird)
        verify(controller, for: iPad.Pro9_7.Landscape.twoThird)
        verify(controller, for: iPad.Pro9_7.Landscape.half)
        
        verify(controller, for: iPad.Pro10_5.Portrait.fullScreen)
        verify(controller, for: iPad.Pro10_5.Portrait.OneThirds)
        verify(controller, for: iPad.Pro10_5.Portrait.TwoThirds)
        verify(controller, for: iPad.Pro10_5.Landscape.fullScreen)
        verify(controller, for: iPad.Pro10_5.Landscape.oneThird)
        verify(controller, for: iPad.Pro10_5.Landscape.twoThird)
        verify(controller, for: iPad.Pro10_5.Landscape.half)
        
        verify(controller, for: iPad.Pro12_9.Portrait.fullScreen)
        verify(controller, for: iPad.Pro12_9.Portrait.oneThirds)
        verify(controller, for: iPad.Pro12_9.Portrait.twoThirds)
        verify(controller, for: iPad.Pro12_9.Landscape.fullScreen)
        verify(controller, for: iPad.Pro12_9.Landscape.oneThird)
        verify(controller, for: iPad.Pro12_9.Landscape.twoThird)
        verify(controller, for: iPad.Pro12_9.Landscape.half)
    }
}

