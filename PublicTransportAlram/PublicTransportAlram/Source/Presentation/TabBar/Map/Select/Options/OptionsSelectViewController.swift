//
//  OptionsSelectViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/21.
//

import UIKit

class OptionsSelectViewController: UIViewController {

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
    }
    
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
        view.addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            totalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            totalStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            totalStackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 30
            ),
            
            radiusSegmentedControl.widthAnchor.constraint(equalTo: totalStackView.widthAnchor),
            timesSegmentedControl.widthAnchor.constraint(equalTo: totalStackView.widthAnchor)
        ])
    }
}
