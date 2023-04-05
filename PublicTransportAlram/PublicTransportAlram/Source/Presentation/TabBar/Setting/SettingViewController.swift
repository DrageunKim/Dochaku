//
//  SettingViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/02/23.
//

import UIKit

class SettingViewController: UIViewController {
    
    // MARK: Private Properties
    
    private let settingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "⚙️ 정보 & 가이드"
        label.textColor = .label
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline).withSize(20)
        return label
    }()
    
    private let versionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    private let versionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "exclamationmark.circle")
        imageView.tintColor = .label
        return imageView
    }()
    private let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "버전 : 1.0.0"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline).withSize(20)
        return label
    }()
    
    private let guideStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.layer.borderColor = UIColor.label.cgColor
        stackView.layer.borderWidth = 2
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    private let alarmGuideStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    private let alarmGuideImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bell.and.waves.left.and.right")
        imageView.tintColor = .label
        return imageView
    }()
    private let alarmGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "알람이 오지 않을 경우!"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline).withSize(20)
        return label
    }()
    private let locationGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "1. 설정-도차쿠-위치(항상)으로 설정"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .caption1).withSize(18)
        return label
    }()
    private let pushGuideLabel: UILabel = {
        let label = UILabel()
        label.text = "2. 설정-도차쿠-알림(알림 허용)으로 설정"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .caption1).withSize(18)
        return label
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureStackView()
        configureLayout()
    }
}

// MARK: - Configure Layout

extension SettingViewController {
    private func configureStackView() {
        versionStackView.addArrangedSubview(versionImageView)
        versionStackView.addArrangedSubview(versionLabel)
        
        alarmGuideStackView.addArrangedSubview(alarmGuideImageView)
        alarmGuideStackView.addArrangedSubview(alarmGuideLabel)
        
        guideStackView.addArrangedSubview(alarmGuideStackView)
        guideStackView.addArrangedSubview(locationGuideLabel)
        guideStackView.addArrangedSubview(pushGuideLabel)
    }
    
    private func configureLayout() {
        view.addSubview(settingLabel)
        view.addSubview(versionStackView)
        view.addSubview(guideStackView)

        NSLayoutConstraint.activate([
            settingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            settingLabel.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: view.bounds.height * 0.09
            ),
            settingLabel.heightAnchor.constraint(
                equalTo: view.heightAnchor,
                multiplier: 0.03
            ),
            settingLabel.widthAnchor.constraint(
                equalTo: view.widthAnchor,
                multiplier: 0.5
            ),
            
            versionImageView.widthAnchor.constraint(
                equalTo: view.widthAnchor,
                multiplier: 0.05
            ),
            
            versionStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: view.bounds.width * 0.05
            ),
            versionStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: view.bounds.width * -0.05
            ),
            versionStackView.topAnchor.constraint(
                equalTo: settingLabel.bottomAnchor,
                constant: view.bounds.height * 0.03
            ),
            versionStackView.heightAnchor.constraint(equalToConstant: 30),
            
            alarmGuideImageView.leadingAnchor.constraint(
                equalTo: guideStackView.leadingAnchor,
                constant: 10
            ),
            alarmGuideImageView.topAnchor.constraint(
                equalTo: guideStackView.topAnchor,
                constant: 10
            ),
            locationGuideLabel.leadingAnchor.constraint(
                equalTo: guideStackView.leadingAnchor,
                constant: 20
            ),
            pushGuideLabel.leadingAnchor.constraint(
                equalTo: guideStackView.leadingAnchor,
                constant: 20
            ),
            pushGuideLabel.bottomAnchor.constraint(
                equalTo: guideStackView.bottomAnchor,
                constant: -20
            ),
            
            guideStackView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: view.bounds.width * 0.05
            ),
            guideStackView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: view.bounds.width * -0.05
            ),
            guideStackView.topAnchor.constraint(
                equalTo: versionStackView.bottomAnchor,
                constant: view.bounds.height * 0.03),
            guideStackView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
}
