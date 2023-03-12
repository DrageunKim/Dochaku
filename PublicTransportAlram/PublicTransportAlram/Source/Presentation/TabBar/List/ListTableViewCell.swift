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
        label.font = .systemFont(ofSize: 14, weight: .semibold)
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
        
        NSLayoutConstraint.activate([
            stationLabel.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: contentView.frame.width * 0.05
            ),
            stationLabel.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: contentView.frame.width * 0.05
            ),
            stationLabel.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: contentView.frame.height * 0.05
            ),
            stationLabel.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: contentView.frame.height * 0.05
            )
        ])
    }
}

// MARK: - Identifiable

extension ListTableViewCell: Identifiable {}
