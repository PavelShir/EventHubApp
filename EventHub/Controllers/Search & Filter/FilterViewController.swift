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
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let categoryCollectionView: UICollectionView = {
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

    private let todayButton = FilterViewController.makeTimeButton(title: "Today")
    private let tomorrowButton = FilterViewController.makeTimeButton(title: "Tomorrow")
    private let thisWeekButton = FilterViewController.makeTimeButton(title: "This week")

    private let calendarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Choose from calendar", for: .normal)
        button.setImage(UIImage(systemName: "calendar"), for: .normal)
        button.tintColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.contentHorizontalAlignment = .left
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var datePicker: UIDatePicker!
    private var datePickerBackgroundView: UIView!
    private lazy var dateLabel = UILabel()

    private let locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("New York, USA", for: .normal)
        button.setImage(UIImage(systemName: "mappin.and.ellipse"), for: .normal)
        button.tintColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.contentHorizontalAlignment = .left
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

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

    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("RESET", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("APPLY", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = UIColor(named: Constants.allColors.primaryBlue)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCategoryCollection()
    }

    // MARK: - Setup UI

    private func setupUI() {
        view.backgroundColor = .white

         view.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

         view.addSubview(categoryCollectionView)
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 80)
        ])

         view.addSubview(timeStackView)
        [todayButton, tomorrowButton, thisWeekButton].forEach { timeStackView.addArrangedSubview($0) }
        NSLayoutConstraint.activate([
            timeStackView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 20),
            timeStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            timeStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

         view.addSubview(calendarButton)
        NSLayoutConstraint.activate([
            calendarButton.topAnchor.constraint(equalTo: timeStackView.bottomAnchor, constant: 20),
            calendarButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calendarButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calendarButton.heightAnchor.constraint(equalToConstant: 44)
        ])

         view.addSubview(locationButton)
        NSLayoutConstraint.activate([
            locationButton.topAnchor.constraint(equalTo: calendarButton.bottomAnchor, constant: 20),
            locationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            locationButton.heightAnchor.constraint(equalToConstant: 44)
        ])

         view.addSubview(priceRangeLabel)
        NSLayoutConstraint.activate([
            priceRangeLabel.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 20),
            priceRangeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
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
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        categoryCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }


    private static func makeTimeButton(title: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

// MARK: - UICollectionView Delegate & DataSource

extension FilterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(named: Constants.allColors.primaryBlue)
        cell.layer.cornerRadius = 40
        return cell
    }
    
    
}

// MARK: - Date picker

extension FilterViewController {
    private func showDatePicker() {
        // Create background view to block the rest of the screen
        datePickerBackgroundView = UIView()
        datePickerBackgroundView.frame = view.bounds
        datePickerBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(datePickerBackgroundView)
        
        // Initialize UIDatePicker
        datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 0, y: view.bounds.height - 250, width: view.bounds.width, height: 250)
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels // For iOS 14+ (iPhone)
        datePicker.backgroundColor = .white
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        view.addSubview(datePicker)
        
        // Add a button to dismiss the date picker
        let doneButton = UIButton(type: .system)
        doneButton.setTitle("Done", for: .normal)
        doneButton.frame = CGRect(x: view.bounds.width - 100, y: view.bounds.height - 300, width: 80, height: 50)
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        view.addSubview(doneButton)
    }
    
    @objc private func dateChanged() {
        let selectedDate = datePicker.date
        // Optionally, update the label immediately when the date changes
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateLabel.text = dateFormatter.string(from: selectedDate)
    }
    
    @objc private func doneButtonPressed() {
        // Hide the date picker and the background view
        datePicker.removeFromSuperview()
        datePickerBackgroundView.removeFromSuperview()
        
        // Update label with the selected date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
}

#Preview { FilterViewController() }
