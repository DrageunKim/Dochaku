//
//  SearchListTableViewCell.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/19.
//

import UIKit

class SearchListTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    let stationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.backgroundColor = .init(white: 1.0, alpha: 0.1)
        } else {
            self.backgroundColor = .none
        }
    }
    
    // MARK: - Private Methods
    private func configureLayout() {
        addSubview(stationLabel)
        
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

extension SearchListTableViewCell: Identifiable {}
