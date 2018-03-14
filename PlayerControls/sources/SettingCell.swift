//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

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
