//
//  DateSelectViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class DateSelectViewController: UIViewController {
    
    private let dayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 30
        return stackView
    }()
    private let daySelectLabel: UILabel = {
        let label = UILabel()
        label.text = "[알람 요일 설정]"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private let dayButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    private let mondayButton: UIButton = {
        let button = UIButton()
        button.setTitle("월", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let tuesdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("화", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let wednesdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("수", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let thursdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("목", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let fridayButton: UIButton = {
        let button = UIButton()
        button.setTitle("금", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let saturdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("토", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let sundayButton: UIButton = {
        let button = UIButton()
        button.setTitle("일", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let borderLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label
        return view
    }()
    private let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    private let startTimeSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "[시작 시간 설정]"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private let startTimeSelectPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        return picker
    }()
    private let endTimeSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "[종료 시간 설정]"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private let endTimeSelectPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureStackView()
        configureLayout()
        configureBinding()
    }
    
    private func configureBinding() {
        mondayButton.rx.tap
            .map {
                self.buttonSelectedToggle(sender: self.mondayButton)
                self.buttonColorToggle(sender: self.mondayButton)
            }
            .subscribe { _ in
                print("mondayButton")
            }
        
        tuesdayButton.rx.tap
            .map {
                self.buttonSelectedToggle(sender: self.tuesdayButton)
                self.buttonColorToggle(sender: self.tuesdayButton)
            }
            .subscribe { _ in
                print("tuesdayButton")
            }
        
        wednesdayButton.rx.tap
            .map {
                self.buttonSelectedToggle(sender: self.wednesdayButton)
                self.buttonColorToggle(sender: self.wednesdayButton)
            }
            .subscribe { _ in
                print("wednesdayButton")
            }
        
        thursdayButton.rx.tap
            .map {
                self.buttonSelectedToggle(sender: self.thursdayButton)
                self.buttonColorToggle(sender: self.thursdayButton)
            }
            .subscribe { _ in
                print("thursdayButton")
            }
        
        fridayButton.rx.tap
            .map {
                self.buttonSelectedToggle(sender: self.fridayButton)
                self.buttonColorToggle(sender: self.fridayButton)
            }
            .subscribe { _ in
                print("fridayButton")
            }
        
        saturdayButton.rx.tap
            .map {
                self.buttonSelectedToggle(sender: self.saturdayButton)
                self.buttonColorToggle(sender: self.saturdayButton)
            }
            .subscribe { _ in
                print("saturdayButton")
            }
        
        sundayButton.rx.tap
            .map {
                self.buttonSelectedToggle(sender: self.sundayButton)
                self.buttonColorToggle(sender: self.sundayButton)
            }
            .subscribe { _ in
                print("sundayButton")
            }
    }
    
    private func buttonSelectedToggle(sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
    private func buttonColorToggle(sender: UIButton) {
        if sender.isSelected {
            sender.backgroundColor = .systemBlue.withAlphaComponent(0.7)
        } else {
            sender.backgroundColor = .systemBackground
        }
    }
}

extension DateSelectViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    @objc
    private func tappedRightBarButtonItem() {
        dismiss(animated: true)
    }
    
    private func configureStackView() {
        dayButtonStackView.addArrangedSubview(mondayButton)
        dayButtonStackView.addArrangedSubview(tuesdayButton)
        dayButtonStackView.addArrangedSubview(wednesdayButton)
        dayButtonStackView.addArrangedSubview(thursdayButton)
        dayButtonStackView.addArrangedSubview(fridayButton)
        dayButtonStackView.addArrangedSubview(saturdayButton)
        dayButtonStackView.addArrangedSubview(sundayButton)
        
        dayStackView.addArrangedSubview(daySelectLabel)
        dayStackView.addArrangedSubview(dayButtonStackView)
        timeStackView.addArrangedSubview(startTimeSelectLabel)
        timeStackView.addArrangedSubview(startTimeSelectPicker)
        timeStackView.addArrangedSubview(endTimeSelectLabel)
        timeStackView.addArrangedSubview(endTimeSelectPicker)
    }
    
    private func configureLayout() {
        view.addSubview(dayStackView)
        view.addSubview(borderLine)
        view.addSubview(timeStackView)

        NSLayoutConstraint.activate([
            dayStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dayStackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 30
            ),
            
            borderLine.widthAnchor.constraint(equalTo: dayStackView.widthAnchor),
            borderLine.heightAnchor.constraint(equalToConstant: 1),
            borderLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            borderLine.topAnchor.constraint(equalTo: dayStackView.bottomAnchor, constant: 30),
            
            timeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeStackView.topAnchor.constraint(equalTo: borderLine.bottomAnchor, constant: 30)
        ])
    }
}
