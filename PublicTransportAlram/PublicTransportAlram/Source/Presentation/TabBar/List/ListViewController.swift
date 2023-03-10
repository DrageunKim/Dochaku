//
//  ListViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/05.
//

import UIKit
import MapKit

class ListViewController: UIViewController {
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    
    private let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray.withAlphaComponent(0.7)
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "위치 입력"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.becomeFirstResponder()
        searchBar.keyboardAppearance = .dark
        searchBar.showsCancelButton = false
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.leftView?.tintColor = UIColor.white.withAlphaComponent(0.5)
        searchBar.searchTextField.backgroundColor = .lightGray
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.tintColor = .white
        searchBar.searchTextField.font = .systemFont(ofSize: 14, weight: .semibold)
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "검색",
            attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.5)
            ]
        )
        return searchBar
    }()
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        button.addTarget(ListViewController.self, action: #selector(tappedCancelButton), for: .touchDown)
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
        tableView.backgroundColor = .clear
        tableView.register(
            ListTableViewCell.self,
            forCellReuseIdentifier: ListTableViewCell.identifier
        )
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureLayout()
        configureTableView()
        configureSearchCompleter()
        configureSearchBar()
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
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {}

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
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            
            return cell
        }
        
        return UITableViewCell()
    }
}

// MARK: - Button Action

extension ListViewController {
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
        view.backgroundColor = .black.withAlphaComponent(0.4)
    }
    
    private func configureLayout() {
        view.addSubview(topView)
        view.addSubview(listTableView)
        
        topView.addSubview(titleLabel)
        topView.addSubview(searchBar)
        topView.addSubview(cancelButton)
        topView.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12),
            
            titleLabel.topAnchor.constraint(
                equalTo: topView.topAnchor,
                constant: view.frame.height * 0.01
            ),
            titleLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            
            searchBar.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            searchBar.topAnchor.constraint(
                equalTo: titleLabel.bottomAnchor,
                constant: view.frame.height * 0.01
            ),
            searchBar.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.4),
            
            lineView.leadingAnchor.constraint(equalTo: topView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: topView.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: topView.bottomAnchor),
            lineView.heightAnchor.constraint(
                equalTo: topView.heightAnchor,
                multiplier: 0.05
            ),
            
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listTableView.topAnchor.constraint(equalTo: topView.bottomAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
