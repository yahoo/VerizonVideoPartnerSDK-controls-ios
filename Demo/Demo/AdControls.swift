//  Copyright 2019, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import PlayerControls

extension Controls {
    static let ad: AdVideoControls = {
        let vc = AdVideoControls()
        vc.view.backgroundColor = .red
        vc.view.tintColor = .blue
        vc.props = .init(mainAction: .play(.nop),
                         seeker: AdVideoControls.Props.Seeker(
                            remainingPlayTime: "0:30",
                            currentValue: 0,
                            accessibilityLabel: ""),
                         click: .nop,
                         isLoading: false,
                         airplayActiveViewHidden: true)
        return vc
    }()
}
