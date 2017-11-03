//
//  HostViewController.swift
//  DefaultControlsViewController
//
//  Created by adoroshko on 10/30/17.
//  Copyright © 2017 One by AOL : Publishers. All rights reserved.
//

import UIKit

class HostViewController: UIViewController {
    var overridedSupportedInterfaceOrientations: UIInterfaceOrientationMask = .all
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return overridedSupportedInterfaceOrientations
    }
    
    var childViewController: UIViewController? {
        willSet {
            guard let viewController = self.childViewController else { return }
            viewController.willMove(toParentViewController: nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParentViewController()
            viewController.didMove(toParentViewController: nil)
        }
        
        didSet {
            guard let viewController = self.childViewController else { return }
            viewController.willMove(toParentViewController: self)
            viewController.view.frame = self.view.bounds
            viewController.view.translatesAutoresizingMaskIntoConstraints = true
            viewController.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            self.view.addSubview(viewController.view)
            self.addChildViewController(viewController)
            viewController.didMove(toParentViewController: self)
        }
    }
}



