//
//  CustomSegmentControl.swift
//  EventHub
//
//  Created by Anna Melekhina on 22.11.2024.
//

import UIKit

class CapsuleSegmentedControl: UISegmentedControl {
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.bounds.size.height / 2.0
//        layer.borderColor = UIColor.gray.cgColor
//        layer.borderWidth = 1.0
        layer.masksToBounds = true
        clipsToBounds = true
        if #available(iOS 13.0, *) {
            selectedSegmentTintColor = .clear
        } else {
            tintColor = .clear
        }

        for (index, subview) in subviews.enumerated() {
            if ((subviews[index] as? UIImageView) != nil) && index == selectedSegmentIndex {
                subview.backgroundColor = .white
                subview.layer.cornerRadius = subview.bounds.size.height / 2.0
            } else {
                subview.backgroundColor = .clear
            }
        }
    }
    
    
    
}

