//
//  SearchListTableViewCell.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/19.
//

import UIKit

class SearchListTableViewCell: UITableViewCell {
    
    // MARK: - Private Properties
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        return stackView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializer
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = .init()
        subTitleLabel.text = .init()
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
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: contentView.frame.width * 0.05
            ),
            stackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: contentView.frame.width * 0.05
            ),
            stackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: contentView.frame.height * 0.2
            ),
            stackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: contentView.frame.height * 0.2
            ),
        ])
    }
}

extension SearchListTableViewCell: Identifiable {}
