//
//  BundleHelper.swift
//  PlayerControls
//
//  Created by amoskvin on 2/15/19.
//  Copyright © 2019 Oath Inc. All rights reserved.
//

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

