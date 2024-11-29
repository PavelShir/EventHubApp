//
//  FilterViewController.swift
//  EventHub
//
//  Created by Anna Melekhina on 22.11.2024.
//

import UIKit

protocol FilterDelegate: AnyObject {
    func didApplyFilters(_ eventFilters: EventFilter)
}

class FilterViewController: UIViewController {
    
    enum SourceScreen {
            case main
            case search
        }

    var source: SourceScreen?
    
    weak var delegate: FilterDelegate?
    let currentTime = Int(Date().timeIntervalSince1970)

    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Filter"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryCircleView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 80, height: 80)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let timeStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let todayButton = createButton(title: "Today")
    private let tomorrowButton = createButton(title: "Tomorrow")
    private let thisWeekButton = createButton(title: "This week")
    private let calendarButton = createButton(title: "Choose from calendar")
    
    private let headerDate = createHeaderOfSection(title: "Time & Date")
    private let headerLocation = createHeaderOfSection(title: "Location")
    private let headerPrice = createHeaderOfSection(title: "Select price range")
    private let priceLabel = createHeaderOfSection(title: "100 rub")
    
    
    private var cityPicker: UIPickerView!
    
    private var datePicker: UIDatePicker!

    
    private let locationButton = createButton(title: "Choose city")
    
    private let priceRangeLabel: UILabel = {
        let label = UILabel()
        label.text = "Select price range"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceRangeSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 10000
        slider.value = 50
        slider.tintColor = UIColor(named: Constants.allColors.primaryBlue)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let resetButton = createButton(title: "RESET")
    private let applyButton = createButton(title: "APPLY")
    
    var eventFilters = EventFilter()
    var selectedCity: City?
    var selectedtDate: String!
    var selectedCategory: Category?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCategoryCollection()
        setupCityPicker()
        
        calendarButton.addTarget(self, action: #selector(calendarButtonPressed), for: .touchUpInside)
        locationButton.addTarget(self, action: #selector(showCityPicker), for: .touchUpInside)
        
        priceRangeSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)

        todayButton.addTarget(self, action: #selector(selectDate(sender:)), for: .touchUpInside)
        tomorrowButton.addTarget(self, action: #selector(selectDate(sender:)), for: .touchUpInside)
        thisWeekButton.addTarget(self, action: #selector(selectDate(sender:)), for: .touchUpInside)
        calendarButton.addTarget(self, action: #selector(selectDate(sender:)), for: .touchUpInside)
        
        resetButton.addTarget(self, action: #selector(resetTapped), for: .touchUpInside)
        applyButton.addTarget(self, action: #selector(setFiltersApply), for: .touchUpInside)
        
        eventFilters.actualSince = String(currentTime)
        eventFilters.actualUntil = String(currentTime)
        eventFilters.categories = nil
        eventFilters.location = nil
      
        
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        view.addSubview(categoryCircleView)
        NSLayoutConstraint.activate([
            categoryCircleView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            categoryCircleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryCircleView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoryCircleView.heightAnchor.constraint(equalToConstant: 130)
        ])
        
        view.addSubview(headerDate)
        view.addSubview(headerLocation)
        
        NSLayoutConstraint.activate([
            headerDate.topAnchor.constraint(equalTo: categoryCircleView.bottomAnchor, constant: 20),
            headerDate.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
        ])
        
        view.addSubview(timeStackView)
        [todayButton, tomorrowButton, thisWeekButton].forEach { timeStackView.addArrangedSubview($0) }
        NSLayoutConstraint.activate([
            timeStackView.topAnchor.constraint(equalTo: headerDate.bottomAnchor, constant: 20),
            timeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            timeStackView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        view.addSubview(calendarButton)
        NSLayoutConstraint.activate([
            calendarButton.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 20),
            calendarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calendarButton.heightAnchor.constraint(equalToConstant: 44),
            calendarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            
            headerLocation.topAnchor.constraint(equalTo: calendarButton.bottomAnchor, constant: 20),
            headerLocation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
        
        view.addSubview(locationButton)
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: headerLocation.bottomAnchor, constant: 20),
            locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        view.addSubview(priceLabel)
        view.addSubview(priceRangeLabel)
        NSLayoutConstraint.activate([
            priceRangeLabel.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 20),
            priceRangeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceLabel.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(priceRangeSlider)
        NSLayoutConstraint.activate([
            priceRangeSlider.topAnchor.constraint(equalTo: priceRangeLabel.bottomAnchor, constant: 10),
            priceRangeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            priceRangeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        view.addSubview(resetButton)
        view.addSubview(applyButton)
        
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: priceRangeSlider.bottomAnchor, constant: 20),
            resetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            resetButton.heightAnchor.constraint(equalToConstant: 44),
            
            applyButton.topAnchor.constraint(equalTo: priceRangeSlider.bottomAnchor, constant: 20),
            applyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            applyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            applyButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func calendarButtonPressed() {
        showDatePicker()
        todayButton.isSelected = false
        tomorrowButton.isSelected = false
        thisWeekButton.isSelected = false
        todayButton.backgroundColor = .white
        tomorrowButton.backgroundColor = .white
        thisWeekButton.backgroundColor = .white

    }
    
    @objc private func resetTapped() {
        self.dismiss(animated: true)
        
    }
    
    @objc private func sliderValueChanged(_ sender: UISlider) {
        let priceValue = Int(sender.value)
        
        priceLabel.text = "\(priceValue)" + " rub"
    }
    
    private func setupCategoryCollection() {
        categoryCircleView.delegate = self
        categoryCircleView.dataSource = self
        categoryCircleView.register(CategoryCircleCell.self, forCellWithReuseIdentifier: CategoryCircleCell.identifier)
    }
    
    
    private static func createButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.tintColor = UIColor(named: Constants.allColors.primaryBlue)
        button.titleLabel?.font = UIFont(name: "AirbnbCerealApp", size: 18)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }
    
    private static func createHeaderOfSection(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = UIColor.black
        label.font = UIFont(name: "AirbnbCerealApp", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    @objc func selectDate(sender: UIButton) {
        todayButton.isSelected = false
        tomorrowButton.isSelected = false
        thisWeekButton.isSelected = false
      
        
        sender.isSelected = true
        sender.backgroundColor = sender.isSelected ? UIColor(named: Constants.allColors.primaryBlue) : .white
        
        switch sender {
        case todayButton: 
            
            eventFilters.actualSince = String(currentTime)
            eventFilters.actualUntil = String((currentTime) + 86400)
            thisWeekButton.backgroundColor = .white
            tomorrowButton.backgroundColor = .white
            
            
        case tomorrowButton:
            eventFilters.actualSince = String((currentTime) + 86400)
            eventFilters.actualUntil = String((currentTime) + 86400 * 2)
            todayButton.backgroundColor = .white
            thisWeekButton.backgroundColor = .white
            
            
        case thisWeekButton:
            eventFilters.actualSince = String(Int(currentTime))
            eventFilters.actualUntil = String(Int(currentTime + 86400 * 7))
            todayButton.backgroundColor = .white
            tomorrowButton.backgroundColor = .white
           

        default:
            eventFilters.actualSince = String(currentTime)
        }
        
        print(eventFilters.actualSince)
        print(eventFilters.actualUntil)
    }
    
    @objc func setFiltersApply() {
        
        switch source {
            
        case .main:
            let searchVC = SearchViewController()
            searchVC.events = loadEvents(with: eventFilters)
            present(searchVC, animated: true)
            
        case .search:
            print(eventFilters)
            delegate?.didApplyFilters(eventFilters)
            self.dismiss(animated: true)
            
        case .none:
            print("error with filterVC enum")
            dismiss(animated: true)
        }
    }
}
    


// MARK: - UICollectionView Delegate & DataSource

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Category.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryCircleCell.identifier,
            for: indexPath
        ) as? CategoryCircleCell else {
            return UICollectionViewCell()
        }
        
        let category = Category.allCases[indexPath.item]
        cell.configure(with: category)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCircleCell else {
                return
            }
        let selectedCategory = chooseCategory(for: cell.titleLabel.text ?? "Other")
        print(selectedCategory)
        eventFilters.categories = selectedCategory
        }
    

        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCircleCell else {
                return
            }

            if let category = cell.titleLabel.text {
                eventFilters.categories = nil
            }
        }
}


// MARK: - Date picker

extension FilterViewController {
    private func showDatePicker() {
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.sizeToFit()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.backgroundColor = .white
        datePicker.center = view.center
        datePicker.tintColor = UIColor(named: Constants.allColors.primaryBlue)
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        view.addSubview(datePicker)
        
    }
    
    @objc private func dateChanged() {
        let date = datePicker.date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium

        // Преобразуем дату в строку для отображения в кнопке
        let selectedDate = dateFormatter.string(from: date)
        calendarButton.setTitle(selectedDate, for: .normal)

        // Для сохранения значения в timestamp (Unix time)
        let timestamp = date.timeIntervalSince1970

        // Присваиваем значение actualSince и очищаем actualUntil
        eventFilters.actualSince = String(timestamp)
        eventFilters.actualUntil = nil
        
      
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.datePicker.isHidden = true
        }
        
    }
}

// MARK: City UIPicker

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    private func setupCityPicker() {
        cityPicker = UIPickerView()
        cityPicker.delegate = self
        cityPicker.dataSource = self
        cityPicker.backgroundColor = .white
        cityPicker.translatesAutoresizingMaskIntoConstraints = false
        cityPicker.isHidden = true
        view.addSubview(cityPicker)
        
        NSLayoutConstraint.activate([
            cityPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cityPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cityPicker.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cityPicker.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    @objc fileprivate func showCityPicker() {
        cityPicker.isHidden = false
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return City.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return City.allCases[row].fullName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // выбираем город и устанавливаем в фильтр
        
        let cityChosen = City.allCases[row].fullName
        locationButton.setTitle(cityChosen, for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.cityPicker.isHidden = true
        }
        selectedCity = chooseCity(for: cityChosen)
        eventFilters.location = selectedCity
    }
    
}

//#Preview { FilterViewController() }
