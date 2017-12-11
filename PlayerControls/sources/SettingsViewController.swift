//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import Foundation

public class SettingsViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dimmedAreaTouchRecognizer: UITapGestureRecognizer!
    @IBOutlet var closeButtonView: UIView!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBAction func closeButtonTouched(_ sender: Any) {
        props?.dismissCommand.perform()
    }
    
    public init() {
        super.init(nibName: "SettingsViewController",
                   bundle: Bundle(for: type(of: self)))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public var props: Props? {
        didSet {
            guard isViewLoaded else { return }
            tableView.reloadData()
            view.setNeedsLayout()
        }
    }
}

extension SettingsViewController {
    public struct Props {
        public struct Section {
            public let title: String
            public let cells: [Cell]
        }
        
        public struct Cell {
            public let title: String
            public let selected: Bool
            public let select: Command
        }
        
        public let sections: [Section]
        public let dismissCommand: Command
    }
}

extension ContentControlsViewController {
    public static func settingProps(from props: Props) -> SettingsViewController.Props? {        
        guard case .player(let player) = props else { return nil }
        guard case .playable(let controls) = player.item else { return nil }
        guard case .enabled(let command) = controls.settings else { return nil }
        
        var sections: [SettingsViewController.Props.Section] = []
    
        func appendSection(with title: String,
                           group: Props.Player.Item.Controls.MediaGroupControl?) {
            guard let group = group else { return }
            guard group.options.count > 1 else { return }
            sections.append(
                SettingsViewController.Props.Section(
                    title: title,
                    cells: group.options.map {
                        SettingsViewController.Props.Cell(
                            title: $0.name,
                            selected: $0.selected,
                            select: $0.select)
                }))
        }
        
        if let audible = controls.audible {
            appendSection(with: "AUDIO", group: audible)
        }

        switch controls.legible {
        case .external(_ , let group):
            appendSection(with: "SUBTITLES", group: group)
        case .`internal`(let group):
            appendSection(with: "SUBTITLES", group: group)
        }
        
        return SettingsViewController.Props(
            sections: sections,
            dismissCommand: command)
    }
}
