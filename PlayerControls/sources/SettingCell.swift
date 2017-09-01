//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import Foundation

class SettingCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var selectionImage: UIImageView!
    
    var props: SettingsViewController.Props.Cell? {
        didSet {
            guard let props = props else { return }
            
            nameLabel.text = props.title
            selectionImage.isHidden = !props.selected
        }
    }
}
