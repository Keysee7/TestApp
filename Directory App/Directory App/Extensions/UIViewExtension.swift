//
//  UIViewExtension.swift
//  Directory App
//
//  Created by Kacper Cichosz on 23/07/2022.
//

import Foundation
import UIKit

private let WaveHeight: CGFloat = 1.5
private let LeftDrop: CGFloat = 0.4 / WaveHeight
private let RightDrop: CGFloat = 0.3 / WaveHeight
private let LeftInflexionX: CGFloat = 0.4 / WaveHeight
private let LeftInflexionY: CGFloat = 0.47 / WaveHeight
private let RightInflexionX: CGFloat = 0.6 / WaveHeight
private let RightInflexionY: CGFloat = 0.22 / WaveHeight

extension UIView {
    func addWaveBackground(colour: UIColor){
        let backView = UIView(frame: self.frame)
        backView.backgroundColor = colour
        self.addSubview(backView)
        let backLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:0, y: self.frame.height * LeftDrop))
        path.addCurve(to: CGPoint(x: self.frame.width, y: self.frame.height * RightDrop),
                      controlPoint1: CGPoint(x: self.frame.width * LeftInflexionX, y: self.frame.height * LeftInflexionY),
                      controlPoint2: CGPoint(x: self.frame.width * RightInflexionX, y: self.frame.height * RightInflexionY))
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.close()
        backLayer.fillColor = self.backgroundColor?.cgColor
        backLayer.path = path.cgPath
        backView.layer.addSublayer(backLayer)
    }
    
    func madeRounded(borderWidth: CGFloat = 1, borderColor: CGColor = Constants.MainBrandColour.cgColor) {
        layer.borderWidth = borderWidth
        layer.masksToBounds = false
        layer.borderColor = borderColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
}
