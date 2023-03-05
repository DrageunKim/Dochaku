//
//  BusViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

import UIKit

class BusViewController: UIViewController {

    private let nowStationLabel: UILabel = {
        let label = UILabel()
        label.text = "버스번호 :"
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .label
        return label
    }()
    private let nowStationBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .systemBackground
        searchBar.placeholder = "버스번호"
        return searchBar
    }()
    private let nowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let targetStationLabel: UILabel = {
        let label = UILabel()
        label.text = "도착위치 :"
        label.font = .preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        label.textAlignment = .right
        label.textColor = .label
        return label
    }()
    private let targetStationBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .systemBackground
        searchBar.placeholder = "버스역"
        return searchBar
    }()
    private let targetStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .label
        button.setTitle("조회", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 10
        return button
    }()
    private let initButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .label
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.layer.backgroundColor = UIColor.systemRed.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 10
        return button
    }()
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    private let settingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private let arrivalTimeGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "[도착 예정 시간]   -   "
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .headline).withSize(20)
        label.textColor = .label
        return label
    }()
    private let arrivalTimePicker: UIDatePicker = {
        let timePicker = UIDatePicker()
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .automatic
        timePicker.date = .now
        return timePicker
    }()
    private let arrivalTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    private let arrivalTimePickerGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "필요시 원하시는 시간에 타이머를 맞춰주세요 😃"
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .label
        return label
    }()
    private let timerStartButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .label
        button.setTitle("타이머 시작", for: .normal)
        button.setTitleColor(.systemBackground, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.layer.backgroundColor = UIColor.label.cgColor
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 10
        return button
    }()
    private let arrivalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.layoutMargins = UIEdgeInsets(top: 25, left: 20, bottom: 25, right: 20)
        stackView.layer.borderWidth = 3
        stackView.layer.borderColor = UIColor.systemMint.cgColor
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureStackView()
        configureLayout()
        configureButtonAction()
    }
}


// MARK: - Button Action Configure

extension BusViewController {
    private func configureButtonAction() {
        okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchDown)
        initButton.addTarget(self, action: #selector(tappedInitButton), for: .touchDown)
    }
    
    @objc
    private func tappedOkButton() {
        let presentViewController = ListViewController()
        
        navigationController?.present(presentViewController, animated: true)
    }
    
    @objc
    private func tappedInitButton() {
    }
}


// MARK: - View & Layout Configure

extension BusViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "🔔   버스 도착 알림   🔔"
    }
    
    private func configureStackView() {
        nowStackView.addArrangedSubview(nowStationLabel)
        nowStackView.addArrangedSubview(nowStationBar)
        
        targetStackView.addArrangedSubview(targetStationLabel)
        targetStackView.addArrangedSubview(targetStationBar)
        
        buttonStackView.addArrangedSubview(okButton)
        buttonStackView.addArrangedSubview(initButton)
        
        settingStackView.addArrangedSubview(nowStackView)
        settingStackView.addArrangedSubview(targetStackView)
        settingStackView.addArrangedSubview(buttonStackView)
        
        arrivalTimeStackView.addArrangedSubview(arrivalTimeGuideLabel)
        arrivalTimeStackView.addArrangedSubview(arrivalTimePicker)
        
        arrivalStackView.addArrangedSubview(arrivalTimeStackView)
        arrivalStackView.addArrangedSubview(arrivalTimePickerGuideLabel)
        arrivalStackView.addArrangedSubview(timerStartButton)
    }
    
    private func configureLayout() {
        view.addSubview(settingStackView)
        view.addSubview(arrivalStackView)
        
        NSLayoutConstraint.activate([
            nowStackView.widthAnchor.constraint(equalTo: settingStackView.widthAnchor),
            targetStackView.widthAnchor.constraint(equalTo: settingStackView.widthAnchor),
            buttonStackView.widthAnchor.constraint(equalTo: settingStackView.widthAnchor),
            
            settingStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.75),
            settingStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23),
            settingStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingStackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: view.bounds.height * 0.18
            ),
            
            timerStartButton.widthAnchor.constraint(equalTo: buttonStackView.widthAnchor),
            
            arrivalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            arrivalStackView.topAnchor.constraint(
                equalTo: settingStackView.bottomAnchor,
                constant: view.bounds.height * 0.1
            )
        ])
    }
}
