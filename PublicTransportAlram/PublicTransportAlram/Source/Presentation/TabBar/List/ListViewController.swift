//
//  ListViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/05.
//

import UIKit
import RxSwift
import RxCocoa
import MapKit

class ListViewController: UIViewController {
    
//    private let viewModel: ListViewModel
    private let disposeBag = DisposeBag()
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    private var searchLocation = MKLocalSearchCompletion()
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .systemBackground.withAlphaComponent(0.9)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "출발지 & 도착지 입력"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    private let searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        return stackView
    }()
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.becomeFirstResponder()
        searchBar.keyboardAppearance = .default
        searchBar.showsCancelButton = false
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.leftView?.tintColor = UIColor.systemBackground.withAlphaComponent(0.8)
        searchBar.searchTextField.backgroundColor = .label.withAlphaComponent(0.5)
        searchBar.searchTextField.textColor = .systemBackground
        searchBar.searchTextField.tintColor = .systemBackground
        searchBar.searchTextField.font = .systemFont(ofSize: 14, weight: .semibold)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "검색",
            attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.systemBackground.withAlphaComponent(0.5)
            ]
        )
        return searchBar
    }()
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.tintColor = .label
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        return button
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    private let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground.withAlphaComponent(0.9)
        tableView.register(
            ListTableViewCell.self,
            forCellReuseIdentifier: ListTableViewCell.identifier
        )
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureStackView()
        configureLayout()
        configureTableView()
        configureSearchCompleter()
        configureSearchBar()
        configureButtonAction()
        configureBindings()
    }
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    private func configureSearchCompleter() {
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .pointOfInterest
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
    
    private func configureBindings() {
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        searchLocation = searchResults[indexPath.row]
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: ListTableViewCell.identifier,
            for: indexPath
        ) as? ListTableViewCell {
            cell.stationLabel.text = searchResults[indexPath.row].title
            cell.backgroundColor = .systemBackground
            cell.selectionStyle = .none
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

// MARK: - Button Action

extension ListViewController {
    private func configureButtonAction() {
        cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchDown)
    }
    
    @objc
    private func tappedCancelButton() {
        dismiss(animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension ListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
}

// MARK: - MKLocalSearchCompleterDelegate

extension ListViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        listTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - View & Layout Configure

extension ListViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground.withAlphaComponent(0.5)
    }
    
    private func configureStackView() {
        searchStackView.addArrangedSubview(searchBar)
        searchStackView.addArrangedSubview(cancelButton)
        
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(searchStackView)
    }
    
    private func configureLayout() {
        view.addSubview(topStackView)
        view.addSubview(lineView)
        view.addSubview(listTableView)

        NSLayoutConstraint.activate([
            topStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topStackView.topAnchor.constraint(equalTo: view.topAnchor),
            topStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.13),
            
            searchBar.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor),
            searchBar.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.85),
            
            lineView.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: topStackView.bottomAnchor),
            lineView.heightAnchor.constraint(
                equalTo: topStackView.heightAnchor,
                multiplier: 0.05
            ),
            
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listTableView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
