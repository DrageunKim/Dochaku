//
//  ListTableViewCell.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/05.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    // MARK: Private Properties
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let destinationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let optionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    private let radiusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    private let timesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        configureStackView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: PrepareForReuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        typeLabel.text = nil
        locationLabel.text = nil
        radiusLabel.text = nil
        timesLabel.text = nil
    }
    
    // MARK: Internal Methods
    
    func configureCellText(with alarm: AlarmInformation) {
        typeLabel.text = "[" + alarm.type + "]"
        locationLabel.text = alarm.location
        radiusLabel.text = "반경: " + alarm.radius + "미터"
        timesLabel.text = "알람횟수: " + alarm.times + "회"
    }
}

// MARK: - Identifiable

extension ListTableViewCell: Identifiable {}

// MARK: - Configure Layout

extension ListTableViewCell {
    private func configureStackView() {
        destinationStackView.addArrangedSubview(typeLabel)
        destinationStackView.addArrangedSubview(locationLabel)
        
        optionsStackView.addArrangedSubview(radiusLabel)
        optionsStackView.addArrangedSubview(timesLabel)
        
        totalStackView.addArrangedSubview(destinationStackView)
        totalStackView.addArrangedSubview(optionsStackView)
    }
    
    private func configureLayout() {
        contentView.addSubview(totalStackView)
        
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 15
            ),
            totalStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -15
            ),
            totalStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 5
            ),
            totalStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -5
            )
        ])
    }
}
