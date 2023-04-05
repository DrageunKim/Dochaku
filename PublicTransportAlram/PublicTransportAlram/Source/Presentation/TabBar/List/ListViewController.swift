//
//  ListViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/05.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {
    
    // MARK: Private Properties
    
    private let viewModel = ListViewModel()
    private let disposeBag = DisposeBag()
    
    private let bookMarkLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "⭐️ 즐겨찾기 목록"
        label.textColor = .label
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline).withSize(20)
        return label
    }()
    private let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(
            ListTableViewCell.self,
            forCellReuseIdentifier: ListTableViewCell.identifier
        )
        return tableView
    }()
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAlarmFromCoreData()
    }
    
    // MARK: Private Methods
    
    private func configureTableView() {
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    private func showDeleteAlert(alarm: AlarmInformation) {
        presentDeleteAlert({
            self.viewModel.delete(alarm: alarm)
            self.fetchAlarmFromCoreData()
        })
    }
    
    private func fetchAlarmFromCoreData() {
        if let entity = viewModel.fetchData() {
            viewModel.alarmList = viewModel.convertToAlarm(from: entity)
            listTableView.reloadData()
        }
    }
    
    private func setPushAlarm() {
        guard let latitude = viewModel.alarm["latitude"],
              let longitude = viewModel.alarm["longitude"],
              let times = viewModel.alarm["times"],
              let radius = viewModel.alarm["radius"] else {
            presentSettingFailedAlert()
            return
        }
        
        if pushArriveAlarm(latitude: latitude, longitude: longitude, times: times, radius: radius) {
            presentAlarmSettingSuccessAlert()
        } else {
            presentSettingFailedAlert()
        }
    }
}

// MARK: - AlertPresentable

extension ListViewController: AlertPresentable {}

// MARK: - LocalAlarmPushable

extension ListViewController: LocalAlarmPushable {}

// MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt
        indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let setting = UIContextualAction(
                style: .normal,
                title: "알람 설정"
            ) { _, _, _ in
                let alarm = self.viewModel.alarmList[indexPath.row]
                
                self.viewModel.alarm["latitude"] = alarm.latitude
                self.viewModel.alarm["longitude"] = alarm.longitude
                self.viewModel.alarm["times"] = alarm.times
                self.viewModel.alarm["radius"] = alarm.radius
                
                self.setPushAlarm()
            }
            setting.backgroundColor = .systemBlue
            
            let delete = UIContextualAction(
                style: .destructive,
                title: "삭제"
            ) { _, _, _ in
                let alarm = self.viewModel.alarmList[indexPath.row]
                
                self.showDeleteAlert(alarm: alarm)
            }
            
            return UISwipeActionsConfiguration(actions: [delete, setting])
    }
}

// MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.alarmList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(
            withIdentifier: ListTableViewCell.identifier,
            for: indexPath
        ) as? ListTableViewCell {
            cell.backgroundColor = .systemBackground
            cell.selectionStyle = .none
            
            let alarm = viewModel.alarmList[indexPath.row]

            cell.configureCellText(with: alarm)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}


// MARK: - View & Layout Configure

extension ListViewController {
    private func configureLayout() {
        view.addSubview(bookMarkLabel)
        view.addSubview(listTableView)

        NSLayoutConstraint.activate([
            bookMarkLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookMarkLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.height * 0.09),
            bookMarkLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.03),
            bookMarkLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listTableView.topAnchor.constraint(equalTo: bookMarkLabel.bottomAnchor, constant: view.bounds.height * 0.03),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
