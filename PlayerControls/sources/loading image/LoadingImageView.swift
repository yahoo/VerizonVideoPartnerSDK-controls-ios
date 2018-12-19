//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import UIKit

public class LoadingImageView: UIImageView {

    public var isLoading: Bool = false {
        didSet {
            isHidden = !isLoading
            
            isLoading
                ? enableRotation()
                : disableRotation()
        }
    }
    
    func enableRotation() {
        /* Configure loading animation. */ do {
            guard layer.animation(forKey: "Spin") == nil else { return }
            let rotation = CABasicAnimation(keyPath: "transform.rotation")
            rotation.fromValue = 0
            rotation.toValue = 2 * Double.pi
            rotation.duration = 1.1
            rotation.repeatCount = .greatestFiniteMagnitude
            layer.add(rotation, forKey: "Spin")
        }
    }
    
    func disableRotation() {
        layer.removeAnimation(forKey: "Spin")
    }

}
