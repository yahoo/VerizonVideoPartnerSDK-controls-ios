//  Copyright © 2018 Oath. All rights reserved.

import PlayerControls

class PropsDirector {
    
    var propsArray: [DefaultControlsViewController.Props] = []
    ///Set value to false if you don't want endless applying of new props from array.
    var endlessLoop = true

    private var index = 0
    
    func updateProps() -> DefaultControlsViewController.Props? {
        guard !propsArray.isEmpty else { return nil }
        let props = propsArray[index]
        let maxIndex = propsArray.count-1
        if index == maxIndex {
            guard endlessLoop else { return nil }
            index = 0
        } else { index += 1 }
        return props
    }
}
