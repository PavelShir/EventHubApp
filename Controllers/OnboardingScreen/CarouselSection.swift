//
//  CarouselSection.swift
//  EventHub
//
//  Created by Anna Melekhina on 19.11.2024.
//

import UIKit

final class CarouselSection {
    
    var currentPage = 0

    private weak var collectionView: UICollectionView?
    private weak var pageControl: CustomPageControl?
    private var scales: [IndexPath: CGFloat] = [:]

    private let itemScale: CGFloat = 1

    init(collectionView: UICollectionView, pageControl: CustomPageControl) {
        self.collectionView = collectionView
        self.pageControl = pageControl
    }

    var didUpdatePage: ((Int) -> Void)?

    func layoutSection(for sectionIndex: Int, layoutEnvironment: any NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(itemScale * 0.9),
            heightDimension: .fractionalWidth(itemScale * 1.6)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 0
        section.orthogonalScrollingBehavior = .groupPagingCentered

        section.visibleItemsInvalidationHandler = { [self] visibleItems, offset, environment in
            
            let centerX = offset.x + environment.container.effectiveContentSize.width / 2

            for item in visibleItems {
                let distanceFromCenter = abs(item.center.x - centerX)
                let minScale: CGFloat = 0.9
                let maxScale: CGFloat = 1.0
                let scale = max(minScale, maxScale - (distanceFromCenter / environment.container.effectiveContentSize.width))

                self.scales[item.indexPath] = scale
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }

            if let centeredItem = visibleItems.min(by: { abs($0.center.x - centerX) < abs($1.center.x - centerX) }) {
                
                currentPage = centeredItem.indexPath.row
                self.didUpdatePage?(currentPage)
            }
        }
        return section
    }
    
    
    // MARK: - Transform And Transition

    func applyTransform(to cell: UIView, at indexPath: IndexPath) {
        guard let scale = scales[indexPath] else { return }
        cell.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
    
    func scrollToNextPage(completion: (Int) -> Void = { _ in } ) {
        let nextPage = currentPage + 1
        scrollTo(page: nextPage)
        
        completion(nextPage)
    }

    func scrollTo(page: Int) {
        guard let collectionView, currentPage != page else { return }
        guard page <= collectionView.numberOfItems(inSection: 0) - 1 else { return }
        guard page > 0 else { return }
        
        let indexPath = IndexPath(item: page, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        currentPage = page
    }
}
