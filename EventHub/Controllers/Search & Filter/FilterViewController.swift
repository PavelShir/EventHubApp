//
//  FilterViewController.swift
//  EventHub
//
//  Created by Anna Melekhina on 22.11.2024.
//

import UIKit

class FilterViewController: UIViewController {
    
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
    private let priceLabel = createHeaderOfSection(title: "100$")
    
    
    private var cityPicker: UIPickerView!
    var selectedCity: String!
    private var datePicker: UIDatePicker!
    var selectedtDate: String!
    
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
        slider.maximumValue = 100
        slider.value = 50
        slider.tintColor = UIColor(named: Constants.allColors.primaryBlue)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let resetButton = createButton(title: "RESET")
    private let applyButton = createButton(title: "APPLY")
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCategoryCollection()
        setupCityPicker()
        
        calendarButton.addTarget(self, action: #selector(calendarButtonPressed), for: .touchUpInside)
        locationButton.addTarget(self, action: #selector(showCityPicker), for: .touchUpInside)
        
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
            categoryCircleView.heightAnchor.constraint(equalToConstant: 80)
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
}

// MARK: - UICollectionView layout

extension FilterViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
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
        
        
        selectedtDate = dateFormatter.string(from: date)
        calendarButton.setTitle(selectedtDate, for: .normal)
        
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
        return 1 // Один компонент для списка городов
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return City.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return City.allCases[row].fullName
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCity = City.allCases[row].fullName
        locationButton.setTitle(selectedCity, for: .normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.cityPicker.isHidden = true
        }    }
}

#Preview { FilterViewController() }
