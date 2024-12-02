import UIKit
import SwiftUI

class EventCollectionView: UIView {
    
    weak var parentViewController: UIViewController?

    private var events: [Event] = []
    var selectedEvent: Event!

    private var goToDetail: ((Event)->Void)?
    
 
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
    
    func configure(e: [Event], toDetail: @escaping ((Event)->Void))
    {
        events = e
        goToDetail = toDetail
        reloadCollectionView()
        
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
    private func toggleFavorite(for event: Event) {
            print("bookmark")
               var favorites = StorageManager.shared.loadFavorite()

               if !favorites.contains(where: { $0.id == event.id }) {
                   // Добавление в избранное
                   favorites.append(event)
                   StorageManager.shared.saveFavorites(favorites)
                   showFavoriteAddedAlert(for: event)

                   NotificationCenter.default.post(name: .favoriteEventAdded, object: event)
               } else {
                   // Удаление из избранного
                   favorites.removeAll(where: { $0.id == event.id })
                   StorageManager.shared.saveFavorites(favorites)
                   showAlreadyInFavoritesAlert(for: event)
               }
           }
    private func showFavoriteAddedAlert(for event: Event) {
          guard let parentVC = parentViewController else { return }
          let alertController = UIAlertController(
              title: "Added to Favorites",
              message: "\(event.title)",
              preferredStyle: .alert
          )
          alertController.addAction(UIAlertAction(title: "OK", style: .default))
          parentVC.present(alertController, animated: true)
      }

        private func showAlreadyInFavoritesAlert(for event: Event) {
               guard let parentVC = parentViewController else { return }
               let alertController = UIAlertController(
                   title: "Removed from Favorites",
                   message: "\(event.title)",
                   preferredStyle: .alert
               )
               alertController.addAction(UIAlertAction(title: "OK", style: .default))
               parentVC.present(alertController, animated: true)
           }
       }
    

extension EventCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
                          withReuseIdentifier: EventCollectionViewCell.identifier,
                          for: indexPath
                      ) as? EventCollectionViewCell else {
                          return UICollectionViewCell()
                      }

                      let event = events[indexPath.row]

                      cell.configure(event: event) { [weak self] in
                          self?.toggleFavorite(for: event)
                      }

                      return cell
                  }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = 237//mainCollectionView.frame.width / 1.58
        return CGSize(width: size, height: 255)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("go to event details")
        
        goToDetail?(events[indexPath.row])
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
    func configure(event: Event, bookmarkAction: @escaping () -> Void) {
        
        backgroundColor = .white
        layer.cornerRadius = 10
        eventCardView.configure(with: event)
        eventCardView.bookmarkAction = bookmarkAction
    }
    
    
   
    private func setupView() {
        eventCardView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(eventCardView)
        NSLayoutConstraint.activate([
            eventCardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            eventCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            eventCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),           
        ])
    }
}

//#Preview { EventCollectionView()}
