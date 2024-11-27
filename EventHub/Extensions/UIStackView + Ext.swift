//
//  UIStackView + Ext.swift
//  EventHub
//
//  Created by Дмирий Зядик on 24.11.2024.
//

import UIKit

extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, alignment: UIStackView.Alignment, spacing: CGFloat, subViews: [UIView] ) {
        self.init(arrangedSubviews: subViews)
        self.axis = axis
        self.distribution = distribution
        self.spacing = spacing
        self.alignment = alignment
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
