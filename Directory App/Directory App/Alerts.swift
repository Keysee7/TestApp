//
//  File.swift
//  Directory App
//
//  Created by Kacper Cichosz on 11/08/2022.
//

import Foundation
import UIKit

struct Alerts {
    func showAlert(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .cancel, handler: { (_) in
            DispatchQueue.main.async {
                viewController.tabBarController?.selectedIndex = 0
            }
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
}
