import UIKit
import SwiftUI


class CategoryCollectionView: UIView{
    
    weak var delegate: FilterDelegate?
     private var selectedCategoryIndex: IndexPath?
    
    let categoryList = [
        CategoryModel(label: "Sports", imageName: "basketball.fill", color: UIColor(named: "primaryRed")!),
        CategoryModel(label: "Music", imageName: "music.note", color: UIColor(named: "primaryOrange")!),
        CategoryModel(label: "Art", imageName: "paintpalette.fill", color: UIColor(named: "primaryLightBlue")!),
        CategoryModel(label: "Business", imageName: "bubble.left.and.bubble.right", color: UIColor(named: "primaryRed")!),
        CategoryModel(label: "Cinema", imageName: "film", color: UIColor(named: "primaryOrange")!),
        CategoryModel(label: "Kids", imageName: "figure.2.and.child.holdinghands", color: UIColor(named: "primaryLightBlue")!),
        CategoryModel(label: "Parties", imageName: "figure.dance", color: UIColor(named: "primaryRed")!),
    ]
    
    private lazy var mainCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 11.28
        flowLayout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
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
            mainCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            mainCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
           // mainCollectionView.heightAnchor.constraint(equalToConstant: 39.06)
            mainCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}

extension CategoryCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Return the number of items in the collection view section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    // Configure and return the cell for a given index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        let category = categoryList[indexPath.row]
        cell.configure(label: category.label, imageName: category.imageName, buttonColor: category.color)
        return cell
    }
    
    // Return the size for the item at a given index path
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = mainCollectionView.frame.width / 3.5
        return CGSize(width: size, height: 39.06)
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           let selectedCategory = categoryList[indexPath.row]
           print("Selected category: \(selectedCategory.label)")
           
           let categoryFilter = chooseCategory(for: selectedCategory.label)
           
  
        let filter = EventFilter(location: .moscow, categories: categoryFilter, actualSince: String(Date().timeIntervalSince1970))
           
        let exploreVC = ExploreViewController()
        exploreVC.selectedCategory = categoryFilter
        
        
        delegate?.didApplyFilters(filter)

    }
           }
       


class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let element = UILabel()
        element.text = "label"
        element.textColor = .white
        //element.font = UIFont.boldSystemFont(ofSize: 15)
        element.font = UIFont(name: "AirbnbCerealApp", size: 15)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var stackView : UIStackView = {
        let element = UIStackView(arrangedSubviews: [imageView, titleLabel])
        element.axis = .horizontal
        element.spacing = 7
        element.alignment = .center
        element.translatesAutoresizingMaskIntoConstraints = false
//        element.isUserInteractionEnabled = false
        return element
    }()
    
    
        private lazy var button: UIView = {
                let view = UIView()
                view.backgroundColor = .clear
            view.layer.cornerRadius = 20
                view.translatesAutoresizingMaskIntoConstraints = false
                return view
            }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
      
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func notificationButtonPressed(){
        print("clifhfhck")
    }
    
    // Configure the cell with the image name
    func configure(label: String, imageName: String, buttonColor: UIColor) {
 
        button.backgroundColor = buttonColor
        titleLabel.text = label
 
        imageView.image = UIImage(systemName: imageName)?.withTintColor(.white, renderingMode: .alwaysOriginal)
    }
   
    private func setupView() {
        contentView.addSubview(button)
               button.addSubview(stackView)
               
               // Контрейнты для button, чтобы он занимал всю ячейку
               NSLayoutConstraint.activate([
                   button.topAnchor.constraint(equalTo: contentView.topAnchor),
                   button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                   button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                   button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                   
                   // Контрейнты для stackView
                   stackView.centerXAnchor.constraint(equalTo: button.centerXAnchor),
                   stackView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                   
                   // Размеры для imageView
                   imageView.heightAnchor.constraint(equalToConstant: 17.73),
                   imageView.widthAnchor.constraint(equalToConstant: 17.73)
        ])
    }
}


// MARK: - CategoryModel
struct CategoryModel {
    let label: String
    let imageName: String
    let color: UIColor
}
