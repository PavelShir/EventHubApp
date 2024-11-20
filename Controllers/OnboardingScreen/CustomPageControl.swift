//
//  CustomPageControl.swift
//  EventHub
//
//  Created by Anna Melekhina on 19.11.2024.
//

import UIKit

class CustomPageControl: UIView {

    var numberOfPages: Int = 3 {
        didSet { setupDots() }
    }
    
    var currentPage: Int = 0 {
        didSet { updateActiveDot() }
    }

    private var dotViews: [UIView] = []
    private let activeDotView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupActiveDot()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupActiveDot()
    }

   

    private func setupDots() {
        dotViews.forEach { $0.removeFromSuperview() }
        dotViews.removeAll()

        for _ in 0..<numberOfPages {
            let dotView = UIView()
            dotView.backgroundColor = UIColor(white: 1, alpha: 0.5)
            dotView.layer.cornerRadius = 4
            addSubview(dotView)
            dotViews.append(dotView)
        }
        layoutDots()
        updateActiveDot()
    }
    
    private func setupActiveDot() {
        activeDotView.backgroundColor = .white
        activeDotView.layer.cornerRadius = 4
        addSubview(activeDotView)
    }

    private func layoutDots() {
        let dotSize: CGFloat = 8
        let dotSpacing: CGFloat = 10
        for (index, dotView) in dotViews.enumerated() {
            dotView.frame = CGRect(x: CGFloat(index) * (dotSize + dotSpacing), y: 0, width: dotSize, height: dotSize)
        }
        activeDotView.frame = CGRect(x: 0, y: 0, width: dotSize, height: dotSize)
    }

    private func updateActiveDot() {
        guard currentPage < dotViews.count else { return }
        
        for (index, dotView) in dotViews.enumerated() {
                    dotView.alpha = (index == currentPage ) ? 0 : 1
                }
        
        UIView.animate(withDuration: 0.3, animations: {
            let dotSize: CGFloat = 8
            self.activeDotView.frame = CGRect(x: 0, y: 0, width: dotSize, height: dotSize)
        })
        
    }
}
