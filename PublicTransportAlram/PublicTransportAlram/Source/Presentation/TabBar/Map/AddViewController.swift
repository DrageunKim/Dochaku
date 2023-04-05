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

class AddViewController: UIViewController {
    enum SearchType: Int {
        case subway = 0
        case bus
        case address
    }
    
    private let viewModel = AddViewModel()
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
        searchBar.searchTextField.clearButtonMode = .never
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
                    self.initLocation()
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func setAlarm() {
        checkAlarmRadius()
        checkAlarmTimes()
        checkAlarmEnable()
        setPushAlarm()
    }
    
    private func setAlarmAndBookMark() {
        let alarm = self.createAlarm()
        
        switch alarm {
        case .success(let data):
            viewModel.save(alarm: data)
        case .failure(_):
            break
        }
    }
    
    private func setBookMark() {
        let alarm = self.createAlarm()
        
        switch alarm {
        case .success(let data):
            viewModel.save(alarm: data)
            checkAlarmEnable()
            setPushAlarm()
        case .failure(_):
            break
        }
    }
    
    private func setPushAlarm() {
        guard let latitude = viewModel.alarmInformation["latitude"],
              let longitude = viewModel.alarmInformation["longitude"],
              let times = viewModel.alarmInformation["times"],
              let radius = viewModel.alarmInformation["radius"] else {
            presentSettingFailedAlert()
            return
        }
        
        if pushArriveAlarm(latitude: latitude, longitude: longitude, times: times, radius: radius) {
            presentSettingSuccessAlert()
        } else {
            presentSettingFailedAlert()
        }
    }
    
    private func initLocation() {
        locationSearchBar.text = .init()
        mapView.removeAnnotations(self.mapView.annotations)
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
        
        if let latitude = viewModel.alarmInformation["latitude"],
           let longitude = viewModel.alarmInformation["longitude"],
           let location = viewModel.alarmInformation["location"],
           let times = viewModel.alarmInformation["times"],
           let radius = viewModel.alarmInformation["radius"],
           let type = viewModel.alarmInformation["type"] {
            
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
            viewModel.alarmInformation.updateValue("지하철", forKey: "type")
        case 1:
            viewModel.alarmInformation.updateValue("버스", forKey: "type")
        case 2:
            viewModel.alarmInformation.updateValue("주소", forKey: "type")
        default:
            break
        }
    }
    
    private func checkAlarmLocation(location: String, latitude: String, longitude: String) {
        viewModel.alarmInformation.updateValue(location, forKey: "location")
        viewModel.alarmInformation.updateValue(latitude, forKey: "latitude")
        viewModel.alarmInformation.updateValue(longitude, forKey: "longitude")
    }
    
    private func checkAlarmRadius() {
        switch radiusSegmentedControl.selectedSegmentIndex {
        case 0:
            viewModel.alarmInformation.updateValue("250", forKey: "radius")
        case 1:
            viewModel.alarmInformation.updateValue("500", forKey: "radius")
        case 2:
            viewModel.alarmInformation.updateValue("1000", forKey: "radius")
        case 3:
            viewModel.alarmInformation.updateValue("1500", forKey: "radius")
        case 4:
            viewModel.alarmInformation.updateValue("2000", forKey: "radius")
        default:
            break
        }
    }
    
    private func checkAlarmTimes() {
        switch timesSegmentedControl.selectedSegmentIndex {
        case 0:
            viewModel.alarmInformation.updateValue("1", forKey: "times")
        case 1:
            viewModel.alarmInformation.updateValue("2", forKey: "times")
        case 2:
            viewModel.alarmInformation.updateValue("3", forKey: "times")
        case 3:
            viewModel.alarmInformation.updateValue("4", forKey: "times")
        case 4:
            viewModel.alarmInformation.updateValue("5", forKey: "times")
        default:
            break
        }
    }
}

// MARK: - AlertPresentable

extension AddViewController: AlertPresentable {}

// MARK: - LocalAlarmPushable

extension AddViewController: LocalAlarmPushable {}

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
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            print("항상")
        case .notDetermined:
            presentLocationAuthAlert()
        case .restricted:
            presentLocationAuthAlert()
        case .denied:
            presentLocationAuthAlert()
        case .authorizedWhenInUse:
            presentLocationAuthAlert()
        default:
            presentLocationAuthAlert()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
}

// MARK: - Configure Button Action

extension AddViewController {
    private func configureButtonAction() {
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
}

// MARK: - Configure View & Layout

extension AddViewController {
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
