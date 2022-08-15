//
//  UITableViewExtension.swift
//  Directory App
//
//  Created by Kacper Cichosz on 24/07/2022.
//

import UIKit

extension UITableView {
    func reloadOnMainThread() {
        Thread.runOnMain {
            self.reloadData()
        }
    }
}
