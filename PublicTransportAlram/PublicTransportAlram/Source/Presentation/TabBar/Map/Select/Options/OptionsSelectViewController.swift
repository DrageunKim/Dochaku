//
//  OptionsSelectViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class OptionsSelectViewController: UIViewController {
    
    var delegate: OptionsDataSendable?
    
    private var radius = String()
    private var alarmTimes = String()
    
    private let disposeBag = DisposeBag()
    
    private let settingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("설정", for: .normal)
        button.setTitleColor(.systemBlue.withAlphaComponent(0.8), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.systemRed.withAlphaComponent(0.8), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 40
        return stackView
    }()
    private let radiusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    private let radiusSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "[반경 설정]"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private let radiusSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["250m", "500m", "1km", "1.5km", "2km"])
        control.selectedSegmentIndex = 1
        control.backgroundColor = .systemMint.withAlphaComponent(0.4)
        control.selectedSegmentTintColor = .systemBackground
        control.layer.borderColor = UIColor.label.cgColor
        control.layer.borderWidth = 0.5
        return control
    }()
    private let timesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    private let timesSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "[알림 횟수 설정]"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private let timesSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["1회", "3회", "5회", "7회", "10회"])
        control.selectedSegmentIndex = 1
        control.backgroundColor = .systemTeal.withAlphaComponent(0.4)
        control.selectedSegmentTintColor = .systemBackground
        control.layer.borderColor = UIColor.label.cgColor
        control.layer.borderWidth = 0.5
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureStackView()
        configureLayout()
        configureBinding()
    }
    
    private func configureBinding() {
        settingButton.rx.tap
            .subscribe { _ in
                self.delegate?.OptionsDataSend(radius: self.radius, times: self.alarmTimes)
                
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .subscribe { _ in
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        radiusSegmentedControl.rx.selectedSegmentIndex
            .subscribe { index in
                self.checkRadiusSegmentedControl(index)
            }
            .disposed(by: disposeBag)
        
        timesSegmentedControl.rx.selectedSegmentIndex
            .subscribe { index in
                self.checkTimesSegmentedControl(index)
            }
            .disposed(by: disposeBag)
    }
    
    private func checkRadiusSegmentedControl(_ index: Int) {
        switch index {
        case 0:
            self.radius = "250m"
        case 1:
            self.radius = "500m"
        case 2:
            self.radius = "1km"
        case 3:
            self.radius = "1.5km"
        case 4:
            self.radius = "2km"
        default:
            break
        }
    }
    
    private func checkTimesSegmentedControl(_ index: Int) {
        switch index {
        case 0:
            self.alarmTimes = "1회"
        case 1:
            self.alarmTimes = "3회"
        case 2:
            self.alarmTimes = "5회"
        case 3:
            self.alarmTimes = "7회"
        case 4:
            self.alarmTimes = "10회"
        default:
            break
        }
    }
}

extension OptionsSelectViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureStackView() {
        radiusStackView.addArrangedSubview(radiusSelectLabel)
        radiusStackView.addArrangedSubview(radiusSegmentedControl)
        timesStackView.addArrangedSubview(timesSelectLabel)
        timesStackView.addArrangedSubview(timesSegmentedControl)
        
        totalStackView.addArrangedSubview(radiusStackView)
        totalStackView.addArrangedSubview(timesStackView)
    }
    
    private func configureLayout() {
        view.addSubview(settingButton)
        view.addSubview(cancelButton)
        view.addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            settingButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            settingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingButton.widthAnchor.constraint(equalToConstant: 40),
            settingButton.heightAnchor.constraint(equalTo: settingButton.widthAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cancelButton.widthAnchor.constraint(equalToConstant: 40),
            cancelButton.heightAnchor.constraint(equalTo: settingButton.widthAnchor),

            totalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            totalStackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 50
            ),
            
            radiusSegmentedControl.widthAnchor.constraint(equalTo: totalStackView.widthAnchor),
            timesSegmentedControl.widthAnchor.constraint(equalTo: totalStackView.widthAnchor)
        ])
    }
}
