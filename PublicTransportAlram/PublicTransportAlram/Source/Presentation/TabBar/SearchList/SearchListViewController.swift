//
//  SearchListViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/19.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

enum SearchType {
    case subway
    case bus
    case address
}

class SearchListViewController: UIViewController {
    
//    private let viewModel: ListViewModel
    private let disposeBag = DisposeBag()
    private var type: SearchType
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    private var places: MKMapItem? {
        didSet {
            listTableView.reloadData()
        }
    }
    private var localSearch: MKLocalSearch? {
        willSet {
            places = nil
            localSearch?.cancel()
        }
    }
    
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
        label.text = "목적지 입력"
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
            SearchListTableViewCell.self,
            forCellReuseIdentifier: SearchListTableViewCell.identifier
        )
        return tableView
    }()
    
    init(type: SearchType) {
        self.type = type
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureStackView()
        configureLayout()
        configureTableView()
        configureSearchCompleter()
        configureSearchBar()
        configureButtonAction()
    }
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    private func configureSearchCompleter() {
        searchCompleter.delegate = self
        searchCompleter.resultTypes = .address
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
    
    private func search(for suggestedCompletion: MKLocalSearchCompletion) {
        let searchRequest = MKLocalSearch.Request(completion: suggestedCompletion)
        
        search(using: searchRequest)
    }
    
    private func search(using searchRequest: MKLocalSearch.Request) {
        searchRequest.resultTypes = .pointOfInterest
        
        localSearch = MKLocalSearch(request: searchRequest)
        localSearch?.start(completionHandler: { response, error in
            if error != nil {
                return
            }
            
            self.places = response?.mapItems[0]
            print(self.places!.placemark.coordinate)
        })
    }
}

// MARK: - UITableViewDelegate

extension SearchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        search(for: searchResults[indexPath.row])
    }
}

// MARK: - UITableViewDataSource

extension SearchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchListTableViewCell.identifier,
            for: indexPath
        ) as? SearchListTableViewCell {
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

extension SearchListViewController {
    private func configureButtonAction() {
        cancelButton.addTarget(self, action: #selector(tappedCancelButton), for: .touchDown)
    }
    
    @objc
    private func tappedCancelButton() {
        dismiss(animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension SearchListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
    }
}

// MARK: - MKLocalSearchCompleterDelegate

extension SearchListViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        listTableView.reloadData()
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - View & Layout Configure

extension SearchListViewController {
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
            topStackView.heightAnchor.constraint(equalToConstant: 100),
            
            searchBar.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor),
            searchBar.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.85),
            
            lineView.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: topStackView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 5),
            
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listTableView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
