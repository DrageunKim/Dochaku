//
//  DateSelectViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/21.
//

import UIKit
import RxSwift
import RxCocoa

class DateSelectViewController: UIViewController {
    
    var delegate: DateDataSendable?
    
    private var dateList = [false, false, false, false, false, false, false]
    private var startTime = String()
    private var endTime = String()
    
    private let disposeBag = DisposeBag()
    
    private let settingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("설정", for: .normal)
        button.setTitleColor(.systemBlue.withAlphaComponent(0.8), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.systemRed.withAlphaComponent(0.8), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    private let dayStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 30
        return stackView
    }()
    private let daySelectLabel: UILabel = {
        let label = UILabel()
        label.text = "[알람 요일 설정]"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private let dayButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        return stackView
    }()
    private let mondayButton: UIButton = {
        let button = UIButton()
        button.setTitle("월", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let tuesdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("화", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let wednesdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("수", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let thursdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("목", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let fridayButton: UIButton = {
        let button = UIButton()
        button.setTitle("금", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let saturdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("토", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let sundayButton: UIButton = {
        let button = UIButton()
        button.setTitle("일", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    private let borderLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label
        return view
    }()
    private let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    private let startTimeSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "[시작 시간 설정]"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private let startTimeSelectPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.minuteInterval = 30
        return picker
    }()
    private let endTimeSelectLabel: UILabel = {
        let label = UILabel()
        label.text = "[종료 시간 설정]"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private let endTimeSelectPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.minuteInterval = 30
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureStackView()
        configureLayout()
        configureBinding()
    }
    
    private func configureBinding() {
        settingButton.rx.tap
            .subscribe { _ in
                self.delegate?.DateDataSend(
                    date: self.convertDateButtonSelectedToString(self.dateList),
                    startTime: self.startTime,
                    endTime: self.endTime
                )
                
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .subscribe { _ in
                self.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        mondayButton.rx.tap
            .scan(false) { lastState, newState in !lastState }
            .subscribe(onNext: { bool in
                self.toggleButtonColor(self.mondayButton, bool)
                self.checkDateButtonSelected(self.mondayButton, bool)
            })
            .disposed(by: disposeBag)
        
        tuesdayButton.rx.tap
            .scan(false) { lastState, newState in !lastState }
            .subscribe(onNext: { bool in
                self.toggleButtonColor(self.tuesdayButton, bool)
                self.checkDateButtonSelected(self.tuesdayButton, bool)
            })
            .disposed(by: disposeBag)
        
        wednesdayButton.rx.tap
            .scan(false) { lastState, newState in !lastState }
            .subscribe(onNext: { bool in
                self.toggleButtonColor(self.wednesdayButton, bool)
                self.checkDateButtonSelected(self.wednesdayButton, bool)
            })
            .disposed(by: disposeBag)
        
        thursdayButton.rx.tap
            .scan(false) { lastState, newState in !lastState }
            .subscribe(onNext: { bool in
                self.toggleButtonColor(self.thursdayButton, bool)
                self.checkDateButtonSelected(self.thursdayButton, bool)
            })
            .disposed(by: disposeBag)
                
        fridayButton.rx.tap
            .scan(false) { lastState, newState in !lastState }
            .subscribe(onNext: { bool in
                self.toggleButtonColor(self.fridayButton, bool)
                self.checkDateButtonSelected(self.fridayButton, bool)
            })
            .disposed(by: disposeBag)
        
        saturdayButton.rx.tap
            .scan(false) { lastState, newState in !lastState }
            .subscribe(onNext: { bool in
                self.toggleButtonColor(self.saturdayButton, bool)
                self.checkDateButtonSelected(self.saturdayButton, bool)
            })
            .disposed(by: disposeBag)
        
        sundayButton.rx.tap
            .scan(false) { lastState, newState in !lastState }
            .subscribe(onNext: { bool in
                self.toggleButtonColor(self.sundayButton, bool)
                self.checkDateButtonSelected(self.sundayButton, bool)
            })
            .disposed(by: disposeBag)
        
        startTimeSelectPicker.rx.date
            .subscribe { date in
                self.startTime = self.convertDateToString(date)
            }
            .disposed(by: disposeBag)
        
        endTimeSelectPicker.rx.date
            .subscribe { date in
                self.endTime = self.convertDateToString(date)
            }
            .disposed(by: disposeBag)
    }
    
    private func toggleButtonColor(_ button: UIButton, _ clicked: Bool) {
        if clicked {
            button.backgroundColor = .systemBlue.withAlphaComponent(0.6)
        } else {
            button.backgroundColor = .systemBackground
        }
    }
    
    private func checkDateButtonSelected(_ button: UIButton, _ clicked: Bool) {
        switch button {
        case mondayButton:
            dateList[0] = clicked
        case tuesdayButton:
            dateList[1] = clicked
        case wednesdayButton:
            dateList[2] = clicked
        case thursdayButton:
            dateList[3] = clicked
        case fridayButton:
            dateList[4] = clicked
        case saturdayButton:
            dateList[5] = clicked
        case sundayButton:
            dateList[6] = clicked
        default:
            break
        }
    }
    
    private func convertDateButtonSelectedToString(_ selectedList: [Bool]) -> String {
        var dateString = String()
        
        if selectedList[0] == true {
            dateString += "월"
        }
        if selectedList[1] == true {
            dateString += "화"
        }
        if selectedList[2] == true {
            dateString += "수"
        }
        if selectedList[3] == true {
            dateString += "목"
        }
        if selectedList[4] == true {
            dateString += "금"
        }
        if selectedList[5] == true {
            dateString += "토"
        }
        if selectedList[6] == true {
            dateString += "일"
        }
        
        if dateString == "월화수목금" {
            dateString = "주중"
        } else if dateString == "토일" {
            dateString = "주말"
        }
        
        return dateString
    }
    
    private func convertDateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: date)
    }
}

extension DateSelectViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }

    private func configureStackView() {
        dayButtonStackView.addArrangedSubview(mondayButton)
        dayButtonStackView.addArrangedSubview(tuesdayButton)
        dayButtonStackView.addArrangedSubview(wednesdayButton)
        dayButtonStackView.addArrangedSubview(thursdayButton)
        dayButtonStackView.addArrangedSubview(fridayButton)
        dayButtonStackView.addArrangedSubview(saturdayButton)
        dayButtonStackView.addArrangedSubview(sundayButton)
        
        dayStackView.addArrangedSubview(daySelectLabel)
        dayStackView.addArrangedSubview(dayButtonStackView)
        timeStackView.addArrangedSubview(startTimeSelectLabel)
        timeStackView.addArrangedSubview(startTimeSelectPicker)
        timeStackView.addArrangedSubview(endTimeSelectLabel)
        timeStackView.addArrangedSubview(endTimeSelectPicker)
    }
    
    private func configureLayout() {
        view.addSubview(settingButton)
        view.addSubview(cancelButton)
        view.addSubview(dayStackView)
        view.addSubview(borderLine)
        view.addSubview(timeStackView)

        NSLayoutConstraint.activate([
            settingButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            settingButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            settingButton.widthAnchor.constraint(equalToConstant: 40),
            settingButton.heightAnchor.constraint(equalTo: settingButton.widthAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            cancelButton.widthAnchor.constraint(equalToConstant: 40),
            cancelButton.heightAnchor.constraint(equalTo: settingButton.widthAnchor),
            
            dayStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dayStackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 30
            ),
            
            borderLine.widthAnchor.constraint(equalTo: dayStackView.widthAnchor),
            borderLine.heightAnchor.constraint(equalToConstant: 1),
            borderLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            borderLine.topAnchor.constraint(equalTo: dayStackView.bottomAnchor, constant: 30),
            
            timeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeStackView.topAnchor.constraint(equalTo: borderLine.bottomAnchor, constant: 30)
        ])
    }
}
