//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

extension UIView {
    var preferredTraitCollection: UITraitCollection {
        func sizeClass(forSize size: CGFloat) -> UIUserInterfaceSizeClass {
            precondition(size >= 0, "Width should be non negative")
            
            if size > 400 {
                return .regular
            } else {
                return .compact
            }
        }
        
        return UITraitCollection(traitsFrom: [
            UITraitCollection(verticalSizeClass: sizeClass(forSize: bounds.size.width)),
            UITraitCollection(horizontalSizeClass: sizeClass(forSize: bounds.size.height))])
    }
    
    func createImage(named name: String) -> UIImage {
        return UIImage(named: name,
                       in: Bundle(for: type(of: self)),
                       compatibleWith: traitCollection)!
    }
}
