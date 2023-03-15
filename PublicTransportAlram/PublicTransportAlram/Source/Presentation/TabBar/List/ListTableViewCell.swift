//
//  ListTableViewCell.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/05.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    // MARK: Private Properties
    
    let stationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    let laneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: PrepareForReuse
    
    override func prepareForReuse() {
        stationLabel.text = nil
    }
    
    // MARK: Private Methods

    private func configureLayout() {
        contentView.addSubview(stationLabel)
        contentView.addSubview(laneLabel)
        
        NSLayoutConstraint.activate([
            stationLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: 10
            ),
            stationLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: 10
            ),
            stationLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: 10
            ),
            
            laneLabel.leadingAnchor.constraint(equalTo: stationLabel.leadingAnchor),
            laneLabel.trailingAnchor.constraint(equalTo: stationLabel.trailingAnchor),
            laneLabel.topAnchor.constraint(
                equalTo: stationLabel.bottomAnchor,
                constant: 2
            )
        ])
    }
}

// MARK: - Identifiable

extension ListTableViewCell: Identifiable {}
