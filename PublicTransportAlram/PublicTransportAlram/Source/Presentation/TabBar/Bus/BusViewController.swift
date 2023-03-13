//
//  BusViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

import UIKit

class BusViewController: UIViewController {
    
    private let settingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private let nowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 5
        return stackView
    }()
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
    
    private let targetStackView: UIStackView = {
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
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    private let okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .label
        button.setTitle("조회", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.layer.backgroundColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    private let initButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .label
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.layer.backgroundColor = UIColor.systemRed.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let arrivalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 25, left: 20, bottom: 25, right: 20)
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.layer.borderWidth = 3
        stackView.layer.borderColor = UIColor.systemMint.cgColor
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    private let arrivalTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    private let arrivalTimeGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "[도착 예정 시간]   -  "
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
    private let arrivalTimePickerGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "필요시 원하시는 시간으로 변경해주세요 ⏰"
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
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let timerGuideLineStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    private let timerFirstGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "✅  설정된 시간에서 -1분으로 타이머를 설정합니다."
        label.numberOfLines = 1
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .label
        return label
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
        nowStationBar.searchTextField.addTarget(
            self,
            action: #selector(tappedNowStationBar),
            for: .touchDown
        )
        targetStationBar.searchTextField.addTarget(
            self,
            action: #selector(tappedTargetStationBar),
            for: .touchDown
        )
        okButton.addTarget(self, action: #selector(tappedOkButton), for: .touchDown)
        initButton.addTarget(self, action: #selector(tappedInitButton), for: .touchDown)
        timerStartButton.addTarget(self, action: #selector(tappedTimerStartButton), for: .touchDown)
    }
    
    @objc
    private func tappedNowStationBar() {
        present(ListViewController(viewModel: ListViewModel(type: .busNow)), animated: true)
    }
    
    @objc
    private func tappedTargetStationBar() {
        present(ListViewController(viewModel: ListViewModel(type: .busTarget)), animated: true)
    }
    
    @objc
    private func tappedInitButton() {
        nowStationBar.text = nil
        targetStationBar.text = nil
    }
    
    @objc
    private func tappedOkButton() {
        
    }
    
    @objc
    private func tappedTimerStartButton() {
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
        
        timerGuideLineStackView.addArrangedSubview(timerFirstGuideLabel)
        
        arrivalTimeStackView.addArrangedSubview(arrivalTimeGuideLabel)
        arrivalTimeStackView.addArrangedSubview(arrivalTimePicker)
        
        arrivalStackView.addArrangedSubview(arrivalTimeStackView)
        arrivalStackView.addArrangedSubview(arrivalTimePickerGuideLabel)
        arrivalStackView.addArrangedSubview(timerStartButton)
    }
    
    private func configureLayout() {
        view.addSubview(settingStackView)
        view.addSubview(arrivalStackView)
        view.addSubview(timerGuideLineStackView)
        
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
            ),
            
            timerGuideLineStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: view.bounds.width * 0.1
            ),
            timerGuideLineStackView.topAnchor.constraint(
                equalTo: arrivalStackView.bottomAnchor,
                constant: view.bounds.height * 0.03
            )
        ])
    }
}
