import UIKit
import SwiftUI

class EventCollectionView: UIView{
    
    
    private var events: [Event] = []
    {
        didSet {
            mainCollectionView.reloadData()
            }
    }
    
    
        //            EventModel(date: "1698764400", title: "Jo Malone London's Mother's", place: "39 Santa Cruz, CA", imageName: "hands"),
//            EventModel(date: "1732027600", title: "International Kids Safe Parents Night Out", place: "Oakland, CA", imageName: "foots"),
//            EventModel(date: "1698850800", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "hands"),
//            EventModel(date: "1732017600", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "hands"),
//            EventModel(date: "1698850800", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "foots"),
//            EventModel(date: "1732017600", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "hands"),
//            EventModel(date: "1698850800", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "foots"),
//            EventModel(date: "1698764400", title: "Jo Malone London's Mother's International Kids", place: "Santa Cruz, CA", imageName: "hands")
        
    
    private lazy var mainCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 16
        flowLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: EventCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
        
            events = loadEvents(with: EventFilter(location: .moscow, actualSince: String(Date().timeIntervalSince1970)))
            setupView()
        }
    required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    func reloadCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.mainCollectionView.reloadData()
        }
    }
    
    private func setupView() {
        addSubview(mainCollectionView)
        
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: topAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            mainCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension EventCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionViewCell.identifier, for: indexPath) as! EventCollectionViewCell
        let event = events[indexPath.row]
        
        cell.configure(event: event)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = mainCollectionView.frame.width / 1.7
        return CGSize(width: size, height: 255)
    }
   
}

class EventCollectionViewCell: UICollectionViewCell {
    static let identifier = "EventCollectionViewCell"
    var eventCardView = EventCardView()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
      
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func notificationButtonPressed(){
        print("click")
    }
    
    // Configure the cell with the image name
    func configure(event: Event) {
 
        backgroundColor = .white
        layer.cornerRadius = 10
        eventCardView.configure(event: event)
    }
   
    private func setupView() {
        
        contentView.addSubview(eventCardView)
        NSLayoutConstraint.activate([
            eventCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            eventCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            eventCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),           
        ])
    }
}
