//
//  OnboardingItemCell.swift
//  EventHub
//
//  Created by Anna Melekhina on 19.11.2024.
//

import UIKit


final class OnboardingItemCell: UICollectionViewCell {
    
    // MARK: - UI Components
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.addSubview(imageView)
        contentView.layer.cornerRadius = 35
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    
    // MARK: - Methods
    func configure(with image: UIImage?) {
        imageView.image = image
    }
    
}
