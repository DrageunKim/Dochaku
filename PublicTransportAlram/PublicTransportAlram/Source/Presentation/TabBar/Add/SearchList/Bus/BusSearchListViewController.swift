//
//  BusSearchListViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/19.
//

import UIKit
import MapKit
import RxSwift
import RxCocoa

class BusSearchListViewController: UIViewController {
    
    // MARK: Delegate
    
    var delegate: LocationDataSendable?
    
    // MARK: Private Properties
    
    private let viewModel = BusSearchListViewModel()
    private let disposeBag = DisposeBag()
    private var stationList: [POI] = [] {
        didSet {
            listTableView.reloadData()
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
        label.text = "정류장근처 위치 입력"
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
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureStackView()
        configureLayout()
        configureTableView()
        configureSearchCompleter()
        configureSearchBar()
        configureBinding()
    }
    
    // MARK: Private Methods
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
    
    private func configureSearchCompleter() {
        viewModel.searchCompleter.delegate = self
        viewModel.searchCompleter.resultTypes = .pointOfInterest
    }
    
    private func configureBinding() {
        cancelButton.rx.tap
            .subscribe { _ in
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.stationName
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                self.stationList = data
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate

extension BusSearchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let station = stationList[indexPath.row]
        let stationName = station.stationName
        let longitude = station.x
        let latitude = station.y
        let laneName = station.laneName ?? String()
        
        delegate?.locationDataSend(
            longitude: longitude,
            latitude: latitude,
            location: stationName,
            lane: laneName
        )
        
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource

extension BusSearchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchListTableViewCell.identifier,
            for: indexPath
        ) as? SearchListTableViewCell {
            cell.titleLabel.text = stationList[indexPath.row].stationName
            cell.subTitleLabel.text = stationList[indexPath.row].laneName
            cell.backgroundColor = .systemBackground
            cell.selectionStyle = .none
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

// MARK: - UISearchBarDelegate

extension BusSearchListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCompleter.queryFragment = searchText
    }
}

// MARK: - MKLocalSearchCompleterDelegate

extension BusSearchListViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        viewModel.searchResults = completer.results
        
        let observable = Observable<[MKLocalSearchCompletion]>.just(viewModel.searchResults)
        
        observable
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
            .subscribe { result in
                if let firstResult = result.first {
                    self.viewModel.search(for: firstResult, completion: { data in
                        let observable = Observable<String>.just("\(data.latitude) \(data.longitude)")
                        
                        observable
                            .observe(on: ConcurrentDispatchQueueScheduler(qos: .default))
                            .subscribe(onNext: self.viewModel.xyData.onNext)
                            .disposed(by: self.disposeBag)
                    })
                }
            }
            .disposed(by: disposeBag)
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - Configure View & Layout

extension BusSearchListViewController {
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
            searchBar.widthAnchor.constraint(
                equalTo: topStackView.widthAnchor,
                multiplier: 0.85
            ),
            
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
