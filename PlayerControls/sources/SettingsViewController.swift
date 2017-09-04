//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import Foundation

public class SettingsViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    @IBAction func closeButtonTouched(_ sender: Any) {
        props?.dismissAction()
    }
    
    public init() {
        super.init(nibName: "SettingsViewController",
                   bundle: Bundle(for: type(of: self)))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var props: Props? {
        didSet {
            guard isViewLoaded else { return }
            tableView.reloadData()
        }
    }
}

extension SettingsViewController {
    struct Props {
        struct Section {
            let title: String
            let cells: [Cell]
        }
        
        struct Cell {
            let title: String
            let selected: Bool
            let select: Action<Void>
        }
        
        let sections: [Section]
        let dismissAction: Action<Void>
    }
}

extension ContentControlsViewController {
    static func settingProps(from props: Props) -> SettingsViewController.Props? {
        guard case .player(let player) = props else { return nil }
        guard case .playable(let controls) = player.item else { return nil }
        guard let toggleSettings = controls.settingsButtonAction else { return nil }
        
        var sections: [SettingsViewController.Props.Section] = []
        if let audible = controls.audible, audible.options.count > 0 {
            sections.append(
                SettingsViewController.Props.Section(
                title: "AUDIO",
                cells: audible.options.map {
                    SettingsViewController.Props.Cell(
                        title: $0.name,
                        selected: $0.selected,
                        select: $0.select)
                }))
        }
        
        if let legible = controls.legible, legible.options.count > 0 {
            sections.append(
                SettingsViewController.Props.Section(
                    title: "SUBTITLES",
                    cells: legible.options.map {
                        SettingsViewController.Props.Cell(
                            title: $0.name,
                            selected: $0.selected,
                            select: $0.select)
                }))
        }
        
        return SettingsViewController.Props(
            sections: sections,
            dismissAction: toggleSettings)
    }
}
