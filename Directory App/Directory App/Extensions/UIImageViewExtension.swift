//
//  UIImageViewExtension.swift
//  Directory App
//
//  Created by Kacper Cichosz on 24/07/2022.
//

import UIKit

extension UIImageView {
    func makeRounded(borderWidth: CGFloat = 1, borderColor: CGColor = Constants.MainBrandColour.cgColor) {
        layer.borderWidth = borderWidth
        layer.masksToBounds = false
        layer.borderColor = borderColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
