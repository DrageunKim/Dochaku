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

enum stationType {
    case now
    case target
}

protocol Sendable {
    func dataSend(type: stationType , data: String, code: Int)
}

class ListViewController: UIViewController {
    
    var delegate: Sendable?
    
    private let viewModel = ListViewModel()
    private let disposeBag = DisposeBag()
    private let type: stationType
    
    private var stationList: [POI] = []
    
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
            ListTableViewCell.self,
            forCellReuseIdentifier: ListTableViewCell.identifier
        )
        return tableView
    }()
    
    init(type: stationType) {
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
        configureButtonAction()
        configureBindings()
    }
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    private func configureBindings() {
        searchBar.rx.text.orEmpty
            .bind(to: viewModel.stationText)
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .subscribe { _ in
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.stationName
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { data in
                self.stationList = data
                self.listTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let station = stationList[indexPath.row]
        let data = station.stationName + "(\(station.laneName))"
        guard let code = Int(station.ebid) else { return }
        delegate?.dataSend(type: type, data: data, code: code)
        
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: ListTableViewCell.identifier,
            for: indexPath
        ) as? ListTableViewCell {
            cell.stationLabel.text = stationList[indexPath.row].stationName
            cell.laneLabel.text = stationList[indexPath.row].laneName
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
