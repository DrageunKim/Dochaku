//
//  AddViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/19.
//

import UIKit
import UserNotifications
import MapKit
import CoreLocation
import RxSwift
import RxCocoa

enum SettingType {
    case alarm
    case alarmAndBookMark
    case bookMark
}

class AddViewController: UIViewController {
    
    enum SearchType: Int {
        case subway = 0
        case bus
        case address
    }
    
    private var alarmInformation: [String: String] = [:]
    private var myAnnotations = [MKPointAnnotation]()
    private let disposeBag = DisposeBag()
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "⏰ 알람 추가"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline).withSize(20)
        return label
    }()
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["지하철", "버스", "주소"])
        control.selectedSegmentIndex = 0
        control.backgroundColor = .systemOrange.withAlphaComponent(0.4)
        control.selectedSegmentTintColor = .systemBackground
        control.layer.borderColor = UIColor.label.cgColor
        control.layer.borderWidth = 0.5
        return control
    }()
    private let locationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .systemBackground
        searchBar.placeholder = "목적지를 입력해주세요."
        searchBar.searchTextField.font = .systemFont(ofSize: 15)
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = .standard
        map.isPitchEnabled = true
        map.isZoomEnabled = true
        map.showsUserLocation = true
        map.setUserTrackingMode(.follow, animated: true)
        map.layer.cornerRadius = 20
        return map
    }()
    private let myLocationButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        return button
    }()
    private let locationManager: CLLocationManager = {
        let location = CLLocationManager()
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.startUpdatingLocation()
        location.requestWhenInUseAuthorization()
        return location
    }()
    private let optionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    private let radiusStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    private let radiusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "반경"
        label.textColor = .label
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline).withSize(16)
        return label
    }()
    private let radiusSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["250m", "500m", "1km", "1.5km", "2km"])
        control.selectedSegmentIndex = 2
        control.backgroundColor = .systemMint.withAlphaComponent(0.4)
        control.selectedSegmentTintColor = .systemBackground
        control.layer.borderColor = UIColor.label.cgColor
        control.layer.borderWidth = 0.5
        return control
    }()
    private let timesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    private let timesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "알람횟수"
        label.textColor = .label
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .headline).withSize(16)
        return label
    }()
    private let timesSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["1회", "2회", "3회", "4회", "5회"])
        control.selectedSegmentIndex = 2
        control.backgroundColor = .systemTeal.withAlphaComponent(0.4)
        control.selectedSegmentTintColor = .systemBackground
        control.layer.borderColor = UIColor.label.cgColor
        control.layer.borderWidth = 0.5
        return control
    }()
    private let borderLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label
        return view
    }()
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    private let okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .label
        button.setTitle("설정", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.layer.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.8).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    private let initButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .label
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.layer.backgroundColor = UIColor.systemRed.withAlphaComponent(0.8).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureStackView()
        configureLayout()
        configureLocationManager()
        configureButtonAction()
        configureBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        locationManager.stopUpdatingLocation()
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
    }
    
    private func configureBinding() {
        myLocationButton.rx.tap
            .subscribe { _ in
                self.mapView.showsUserLocation = true
                self.mapView.setUserTrackingMode(.follow, animated: true)
            }
            .disposed(by: disposeBag)
        
        okButton.rx.tap
            .filter {
                self.locationSearchBar.text != String()
            }
            .subscribe { _ in
                self.presentAlarmSettingActionSheet(
                    alarm: self.setAlarm,
                    bookMark: self.setBookMark,
                    alarmAndBookMark: self.setAlarmAndBookMark
                )
            }
            .disposed(by: disposeBag)
        
        initButton.rx.tap
            .filter {
                self.locationSearchBar.text != String()
            }
            .subscribe { _ in
                self.presentInitAlert {
                    self.locationSearchBar.text = .init()
                    self.mapView.removeAnnotations(self.mapView.annotations)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func checkAlarmEnable() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (didAllow, error) in
            guard let err = error else { return }
            
            print(err.localizedDescription)
        }
    }
    
    private func pushArriveAlarm() {
        guard let latitude = alarmInformation["latitude"],
              let longitude = alarmInformation["longitude"],
              let times = alarmInformation["times"],
              let radius = alarmInformation["radius"] else { return }
        
        if let latitude = Double(latitude),
           let longitude = Double(longitude),
           let times = Int(times),
           let radius = Double(radius) {
            let content = UNMutableNotificationContent()
            
            content.title = "⏰ 목적지 도착"
            content.body = "설정하신 위치에 근접하였습니다."
            content.sound = .default
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//            let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
            
            let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = CLCircularRegion(center: center, radius: radius, identifier: "settingLocation")

            region.notifyOnEntry = true
            region.notifyOnExit = false

            var requestList: [UNNotificationRequest] = []
            var requestIdentifierList: [String] = []
            
            for i in 0..<times {
                requestIdentifierList.append("timer" + String(i))
                requestList.append(
                    UNNotificationRequest(identifier: requestIdentifierList[i], content: content, trigger: trigger)
                )
                
                UNUserNotificationCenter.current().add(requestList[i], withCompletionHandler: nil)
            }
            
            presentSettingSuccessAlert()
        } else {
            presentSettingFailedAlert()
        }
    }
    
    private func setAlarm() {
        checkAlarmRadius()
        checkAlarmTimes()
        checkAlarmEnable()
        pushArriveAlarm()
    }
    
    private func setAlarmAndBookMark() {
        let alarm = self.createAlarm()
        
        switch alarm {
        case .success(let data):
            save(alarm: data)
        case .failure(_):
            break
        }
    }
    
    private func setBookMark() {
        let alarm = self.createAlarm()
        
        switch alarm {
        case .success(let data):
            save(alarm: data)
            checkAlarmEnable()
            pushArriveAlarm()
        case .failure(_):
            break
        }
    }
    
    private func configureAnnotation(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        title: String? = nil,
        subTitle: String? = nil
    ) {
        mapView.removeAnnotations(mapView.annotations)
        
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        mapView.setRegion(region, animated: true)
        
        if let title = title,
           let subTitle = subTitle {
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = center
            annotation.title = title
            annotation.subtitle = subTitle
            
            mapView.addAnnotation(annotation)
        }
    }
    
    private func createAlarm() -> Result<AlarmInformation, CoreDataError> {
        checkAlarmRadius()
        checkAlarmTimes()
        
        if let latitude = alarmInformation["latitude"],
           let longitude = alarmInformation["longitude"],
           let location = alarmInformation["location"],
           let times = alarmInformation["times"],
           let radius = alarmInformation["radius"],
           let type = alarmInformation["type"] {
            
            let alarm = AlarmInformation(
                id: UUID(),
                type: type,
                latitude: latitude,
                longitude: longitude,
                location: location,
                radius: radius,
                times: times
            )
            
            return .success(alarm)
        }
        
        return .failure(.saveError)
    }
    
    private func checkAlarmType() {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            alarmInformation.updateValue("subway", forKey: "type")
        case 1:
            alarmInformation.updateValue("bus", forKey: "type")
        case 2:
            alarmInformation.updateValue("address", forKey: "type")
        default:
            break
        }
    }
    
    private func checkAlarmLocation(location: String, latitude: String, longitude: String) {
        alarmInformation.updateValue(location, forKey: "location")
        alarmInformation.updateValue(latitude, forKey: "latitude")
        alarmInformation.updateValue(longitude, forKey: "longitude")
    }
    
    private func checkAlarmRadius() {
        switch radiusSegmentedControl.selectedSegmentIndex {
        case 0:
            alarmInformation.updateValue("250", forKey: "radius")
        case 1:
            alarmInformation.updateValue("500", forKey: "radius")
        case 2:
            alarmInformation.updateValue("1000", forKey: "radius")
        case 3:
            alarmInformation.updateValue("1500", forKey: "radius")
        case 4:
            alarmInformation.updateValue("2000", forKey: "radius")
        default:
            break
        }
    }
    
    private func checkAlarmTimes() {
        switch timesSegmentedControl.selectedSegmentIndex {
        case 0:
            alarmInformation.updateValue("1", forKey: "times")
        case 1:
            alarmInformation.updateValue("2", forKey: "times")
        case 2:
            alarmInformation.updateValue("3", forKey: "times")
        case 3:
            alarmInformation.updateValue("4", forKey: "times")
        case 4:
            alarmInformation.updateValue("5", forKey: "times")
        default:
            break
        }
    }
}

// MARK: - AlertPresentable

extension AddViewController: AlertPresentable {}

// MARK: - LocationDataSendable

extension AddViewController: LocationDataSendable {
    func locationDataSend(longitude: Double, latitude: Double, location: String, lane: String) {
        if lane != String() {
            locationSearchBar.text = location + " " + "(\(lane))"
        } else {
            locationSearchBar.text = location
        }
        
        configureAnnotation(latitude: latitude, longitude: longitude, title: location, subTitle: lane)
        
        checkAlarmType()
        checkAlarmLocation(location: location, latitude: String(latitude), longitude: String(longitude))
    }
}

// MARK: - CoreDataProcessable

extension AddViewController: CoreDataProcessable {
    func save(alarm: AlarmInformation) {
        let result = saveCoreData(alarm: alarm)
        
        switch result {
        case .success(_):
            break
        case .failure(let error):
            print(error)
        }
    }
    
    func update(alarm: AlarmInformation) {
        let result = updateCoreData(alarm: alarm)
        
        switch result {
        case .success(_):
            break
        case .failure(let error):
            print(error)
        }
    }
    
    func delete(alarm: AlarmInformation) {
        let result = deleteCoreData(alarm: alarm)
        
        switch result {
        case .success(_):
            break
        case .failure(let error):
            print(error)
        }
    }
    
    func fetchDiaryData() -> [AlarmData]? {
        let result = readCoreData()
        
        switch result {
        case .success(let entity):
            return entity
        case .failure(_):
            return nil
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension AddViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            configureAnnotation(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}

// MARK: - Configure Button Action

extension AddViewController {
    private func configureButtonAction() {
        let longGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(addWaypoint)
        )
        longGesture.minimumPressDuration = 1.0
        
        mapView.addGestureRecognizer(longGesture)
        locationSearchBar.searchTextField.addTarget(
            self,
            action: #selector(tappedLocationSearchBar),
            for: .touchDown
        )
    }
    
    @objc
    private func tappedLocationSearchBar() {
        switch segmentedControl.selectedSegmentIndex {
        case SearchType.subway.rawValue:
            let presentViewController = SubwaySearchListViewController()
            presentViewController.delegate = self
            present(presentViewController, animated: true)
        case SearchType.bus.rawValue:
            let presentViewController = BusSearchListViewController()
            presentViewController.delegate = self
            present(presentViewController, animated: true)
        case SearchType.address.rawValue:
            let presentViewController = AddressSearchListViewController()
            presentViewController.delegate = self
            present(presentViewController, animated: true)
        default:
            break
        }
    }
    
    @objc
    private func addWaypoint(longGesture: UIGestureRecognizer) {
        mapView.removeAnnotations(mapView.annotations)
        
        let touchPoint = longGesture.location(in: mapView)
        let newCoordinates = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = newCoordinates
        mapView.addAnnotation(annotation)
    }
}

// MARK: - Configure View & Layout

extension AddViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureStackView() {
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(segmentedControl)
        topStackView.addArrangedSubview(locationSearchBar)
        topStackView.addArrangedSubview(mapView)
        
        radiusStackView.addArrangedSubview(radiusLabel)
        radiusStackView.addArrangedSubview(radiusSegmentedControl)
        
        timesStackView.addArrangedSubview(timesLabel)
        timesStackView.addArrangedSubview(timesSegmentedControl)
        
        buttonStackView.addArrangedSubview(okButton)
        buttonStackView.addArrangedSubview(initButton)
        
        optionsStackView.addArrangedSubview(radiusStackView)
        optionsStackView.addArrangedSubview(timesStackView)
    }
    
    private func configureLayout() {
        view.addSubview(topStackView)
        view.addSubview(optionsStackView)
        view.addSubview(borderLine)
        view.addSubview(buttonStackView)
        
        mapView.addSubview(myLocationButton)
        
        NSLayoutConstraint.activate([
            topStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            topStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.55),
            topStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topStackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: view.bounds.height * 0.09
            ),
            
            segmentedControl.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.8),
            locationSearchBar.widthAnchor.constraint(equalTo: topStackView.widthAnchor),
            mapView.widthAnchor.constraint(equalTo: topStackView.widthAnchor),
            
            myLocationButton.leadingAnchor.constraint(
                equalTo: mapView.leadingAnchor,
                constant: view.frame.width * 0.04
            ),
            myLocationButton.widthAnchor.constraint(
                equalTo: view.widthAnchor,
                multiplier: 0.08
            ),
            myLocationButton.heightAnchor.constraint(equalTo: myLocationButton.widthAnchor),
            myLocationButton.bottomAnchor.constraint(
                equalTo: mapView.bottomAnchor,
                constant: view.frame.height * -0.04
            ),
            
            optionsStackView.widthAnchor.constraint(equalTo: topStackView.widthAnchor),
            optionsStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            optionsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            optionsStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 20),
            
            timesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            radiusLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            
            borderLine.widthAnchor.constraint(equalTo: topStackView.widthAnchor),
            borderLine.heightAnchor.constraint(equalToConstant: 1),
            borderLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            borderLine.topAnchor.constraint(equalTo: optionsStackView.bottomAnchor, constant: 20),
            
            buttonStackView.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.9),
            buttonStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: borderLine.bottomAnchor, constant: 20)
        ])
    }
}
