//
//  ListViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/05.
//

import UIKit

class ListViewController: UIViewController {

    let tableView: UITableView = {
       let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        tableView.register(
            ListTableViewCell.self,
            forCellReuseIdentifier: ListTableViewCell.identifier
        )
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
        configureLayout()
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - TableView Delegate

extension ListViewController: UITableViewDelegate {}

// MARK: - TableView Datasource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListTableViewCell.identifier,
            for: indexPath
        ) as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}

// MARK: - View & Layout Configure

extension ListViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(
                equalTo: safeArea.leadingAnchor,
                constant: view.frame.width * 0.03
            ),
            tableView.trailingAnchor.constraint(
                equalTo: safeArea.trailingAnchor,
                constant: view.frame.width * -0.03
            ),
            tableView.topAnchor.constraint(
                equalTo: safeArea.topAnchor,
                constant: view.frame.height * 0.02
            ),
            tableView.bottomAnchor.constraint(
                equalTo: safeArea.bottomAnchor,
                constant: view.frame.height * -0.02
            )
        ])
    }
}
