//
//  Extensions.swift
//  TA1Swift
//
//  Created by Сергей Иванчихин on 29.10.2023.
//

import Foundation
import UIKit


extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
