//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import Foundation

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
