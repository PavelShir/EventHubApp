//
//  OnboardingViewController.swift
//  EventHub
//
//  Created by Anna Melekhina on 19.11.2024.
//

import UIKit

final class OnboardingViewController: UIViewController {
    typealias DataSource = UICollectionViewDiffableDataSource<Int, Item>
    
    // MARK: - UI Components
    
    private lazy var carouselSection = CarouselSection(collectionView: collectionView, pageControl: pageControl)
    
    private lazy var pageControl: CustomPageControl = {
        let pageControl = CustomPageControl()
        pageControl.numberOfPages = CarouselItems.imageNames.count
        pageControl.currentPage = 0
        return pageControl
    }()
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = false
        view.isPagingEnabled = true
//        view.delegate = self
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.text = "Explore Upcoming and Nearby Events"
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AirbnbCerealApp", size: 18)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "Your favourite Upcoming and Nearby Events are now in one app"
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: "AirbnbCerealApp", size: 30)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "primaryBlue")
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = UIFont(name: "AirbnbCerealApp", size: 15)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "primaryBlue")
        return button
    }()
    
    private lazy var blueView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "primaryBlue") 
        view.layer.cornerRadius = 50
        return view
    }()
    
    
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        reloadData()
    }
    
    // MARK: - Layout
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        blueView.addSubview(pageControl)
        
        blueView.addSubview(titleLabel)
        blueView.addSubview(descriptionLabel)
        blueView.addSubview(nextButton)
        blueView.addSubview(skipButton)
        
        view.addSubview(blueView)
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        makeConstraints()
    }
    
    private func makeConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor, constant: -390),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.70),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -25),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            pageControl.heightAnchor.constraint(equalToConstant: 10)
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50),
            nextButton.heightAnchor.constraint(equalToConstant: 10),
            nextButton.widthAnchor.constraint(equalToConstant: 50)

        ])
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            skipButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            skipButton.heightAnchor.constraint(equalToConstant: 10),
            skipButton.widthAnchor.constraint(equalToConstant: 50)

            ])
            
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -40),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -30),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),

        ])
        
        blueView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 1.8/3),
            blueView.widthAnchor.constraint(equalTo: view.widthAnchor),
            blueView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            blueView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100)
        ])
    }
    
    private lazy var layout: UICollectionViewLayout = UICollectionViewCompositionalLayout { [self] sectionIndex, layoutEnvironment in
        
        self.carouselSection.didUpdatePage = { page in
            self.pageControl.currentPage = page
        }
        
        return self.carouselSection.layoutSection(for: sectionIndex, layoutEnvironment: layoutEnvironment)
    }
    
    private lazy var dataSource: DataSource = {
        let carouselCellRegistration = UICollectionView.CellRegistration<OnboardingItemCell, Item> { cell, indexPath, itemIdentifier in
            cell.configure(with: itemIdentifier.image)
        }
        let dataSource = DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            collectionView.dequeueConfiguredReusableCell(using: carouselCellRegistration, for: indexPath, item: itemIdentifier)
        }
        return dataSource
    }()
    
    private func reloadData() {
        var snap = NSDiffableDataSourceSnapshot<Int, Item>()
        snap.appendSections([0])
        snap.appendItems(CarouselItems.makeItems())
        
        dataSource.apply(snap) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.collectionView.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: false)
                self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: false)
            }
        }
    }
    
    private func didPageChange(_ currentPage: Int) {
        let indexPath = IndexPath(item: currentPage, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
    }
    
    // MARK: - Next button methods
    private func updateElementsState(for page: Int) {
        switch page {
        case 1:
            self.titleLabel.text = "To Look Up More Events or Activities Nearby By Map"
            self.descriptionLabel.text = "In publishing and graphic design, Lorem is a placeholder text commonly"

        case 2:
            UIView.transition(with: titleLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.titleLabel.text = "Highlight most interesting events"
            }, completion: nil)
            
            UIView.transition(with: descriptionLabel, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.descriptionLabel.text = "Search for your favourite events and add them to favourites"
            }, completion: nil)
            
            UIView.transition(with: nextButton, duration: 0.2, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
                self.nextButton.setTitle("Start", for: .normal)
            }, completion: nil)
            
        default:
            let mainViewController = TabBarViewController()
            let navigationController = UINavigationController(rootViewController: mainViewController)
        }
    }
    
    @objc private func nextButtonTapped() {
        print("tapped")
        carouselSection.scrollToNextPage() { nextPage in
            updateElementsState(for: nextPage)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        carouselSection.applyTransform(to: cell, at: indexPath)
        
        
    }
}

#Preview { OnboardingViewController() }



