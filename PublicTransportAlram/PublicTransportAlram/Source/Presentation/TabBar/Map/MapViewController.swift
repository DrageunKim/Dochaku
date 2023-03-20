//
//  MapViewController.swift
//  PublicTransportAlram
//
//  Created by yonggeun Kim on 2023/03/19.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    enum SearchType: Int {
        case subway = 0
        case bus
        case address
    }
    
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "⏰ 알림 설정"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline).withSize(20)
        return label
    }()
    private let segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["지하철", "버스", "주소"])
        control.selectedSegmentIndex = 0
        control.backgroundColor = .lightGray
        control.selectedSegmentTintColor = .systemBackground
        control.layer.borderColor = UIColor.label.cgColor
        control.layer.borderWidth = 0.5
        return control
    }()
    private let locationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .systemBackground
        searchBar.placeholder = "목적지"
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
        return map
    }()
    private let locationManager: CLLocationManager = {
        let location = CLLocationManager()
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.startUpdatingLocation()
        location.requestWhenInUseAuthorization()
        return location
    }()
    private let dateTimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        return stackView
    }()
    private let dateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 20
        return stackView
    }()
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "요일 설정"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    private let dataSettingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "[월, 화, 수, 목]"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    private let dateSettingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setImage(.add, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        return button
    }()
    private let timeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        stackView.spacing = 20
        return stackView
    }()
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "시간 설정"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    private let timeSettingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemBackground
        label.text = "00:00 ~ 24:00"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    private let timeSettingButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setImage(.add, for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        return button
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
    private let borderLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .label
        return view
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        locationManager.stopUpdatingLocation()
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
    }
    
    private func configureAnnotation(
        latitude: CLLocationDegrees,
        longitude: CLLocationDegrees,
        title: String? = nil,
        subTitle: String? = nil
    ) {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
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
}

// MARK: - Sendable

extension MapViewController: Sendable {
    func dataSend(longitude: Double, latitude: Double, location: String, lane: String) {
        locationSearchBar.text = location + " " + "(\(lane))"
        
        configureAnnotation(
            latitude: latitude,
            longitude: longitude,
            title: location,
            subTitle: lane
        )
    }
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
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

extension MapViewController {
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
            let presentViewController = SubwaySearchListViewController()
            presentViewController.delegate = self
            present(presentViewController, animated: true)
        case SearchType.address.rawValue:
            let presentViewController = AddressSearchListViewController()
//            presentViewController.delegate = self
            present(presentViewController, animated: true)
        default:
            break
        }
    }
}

// MARK: - Configure View & Layout

extension MapViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }

    private func configureStackView() {
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(segmentedControl)
        topStackView.addArrangedSubview(locationSearchBar)
        topStackView.addArrangedSubview(mapView)
        
        dateStackView.addArrangedSubview(dateLabel)
        dateStackView.addArrangedSubview(dataSettingLabel)
        dateStackView.addArrangedSubview(dateSettingButton)
        
        timeStackView.addArrangedSubview(timeLabel)
        timeStackView.addArrangedSubview(timeSettingLabel)
        timeStackView.addArrangedSubview(timeSettingButton)
        
        dateTimeStackView.addArrangedSubview(dateStackView)
        dateTimeStackView.addArrangedSubview(timeStackView)
        
        buttonStackView.addArrangedSubview(okButton)
        buttonStackView.addArrangedSubview(initButton)
    }
    
    private func configureLayout() {
        view.addSubview(topStackView)
        view.addSubview(dateTimeStackView)
        view.addSubview(borderLine)
        view.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            topStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            topStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            topStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            topStackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: view.bounds.height * 0.1
            ),
            
            segmentedControl.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.8),
            locationSearchBar.widthAnchor.constraint(equalTo: topStackView.widthAnchor),
            mapView.widthAnchor.constraint(equalTo: topStackView.widthAnchor),
            
            dateTimeStackView.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.9),
            dateTimeStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            dateTimeStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateTimeStackView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            
            borderLine.widthAnchor.constraint(equalTo: topStackView.widthAnchor),
            borderLine.heightAnchor.constraint(equalToConstant: 1),
            borderLine.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            borderLine.topAnchor.constraint(equalTo: dateTimeStackView.bottomAnchor, constant: 10),
            
            buttonStackView.widthAnchor.constraint(equalTo: topStackView.widthAnchor, multiplier: 0.9),
            buttonStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: borderLine.bottomAnchor, constant: 10)
        ])
    }
}
