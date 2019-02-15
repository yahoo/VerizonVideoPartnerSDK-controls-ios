//  Copyright 2019, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

func controlsBundle(for class: AnyClass) -> Bundle {
    let current = Bundle(for: `class`)
    if let controlsBundleUrl = current.url(forResource: "PlayerControls",
                                              withExtension: "bundle"),
        let controls = Bundle(url: controlsBundleUrl) {
        return controls
    } else {
        return current
    }
}

