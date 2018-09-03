//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation

public class SettingsViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dimmedAreaTouchRecognizer: UITapGestureRecognizer!
    @IBOutlet var closeButtonView: UIView!
    @IBOutlet var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBAction func closeButtonTouched(_ sender: Any) {
        props?.dismissAction.perform()
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
        public let dismissAction: Command
    }
}

extension ContentControlsViewController {
    public static func settingProps(from props: Props) -> SettingsViewController.Props? {        
        guard case .player(let player) = props else { return nil }
        guard case .playable(let controls) = player.item else { return nil }
        guard case .enabled(let action) = controls.settings else { return nil }
        
        var sections: [SettingsViewController.Props.Section] = []
    
        func appendSection(with title: String,
                           group: Props.MediaGroupControl?) {
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
        
        if let legible = controls.legible {
            appendSection(with: "SUBTITLES", group: legible)
        }
        
        return SettingsViewController.Props(
            sections: sections,
            dismissAction: action)
    }
}


extension SettingsViewController: UITableViewDataSource {
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let constant: CGFloat = {
            let contentHeight = self.tableView.contentSize.height
            let emptyHeight = self.view.frame.size.height
                - self.closeButtonView.frame.size.height
                - UIApplication.shared.statusBarFrame.size.height
            if contentHeight < emptyHeight {
                return contentHeight
            } else {
                return emptyHeight
            }
        }()
        
        UIView.animate(withDuration: 0.5, animations: {
            self.tableViewHeightConstraint.constant = constant
        })
    }
    
    override public func loadView() {
        super.loadView()
        
        tableView.register(UINib(nibName: "SettingCell",
                                 bundle: Bundle(for: type(of: self))),
                           forCellReuseIdentifier: "SettingCell")
        tableView.register(UINib(nibName: "SettingHeaderView",
                                 bundle: Bundle(for: type(of: self))),
                           forHeaderFooterViewReuseIdentifier: "SettingHeaderView")
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return props?.sections.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props?.sections[section].cells.count ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as? SettingCell else {
            fatalError("Unknown cell!")
        }
        
        cell.props = props?.cell(at: indexPath)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "SettingHeaderView") as? SettingHeaderView else {
            fatalError("Unknown header view!")
        }
        view.nameLabel.text = props?.sections[section].title
        
        return view
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34.0
    }
}

extension SettingsViewController.Props {
    func section(at indexPath: IndexPath) -> Section {
        return sections[indexPath.section]
    }
    
    func cell(at indexPath: IndexPath) -> Cell {
        return section(at: indexPath).cells[indexPath.row]
    }
}

extension SettingsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = props?.sections[indexPath.section].cells[indexPath.row] else {
            fatalError("Cell not found!")
        }
        
        cell.select.perform()
    }
}

extension SettingsViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard gestureRecognizer === dimmedAreaTouchRecognizer else { return true }
        guard touch.view === view else { return false }
        return true
    }
}

