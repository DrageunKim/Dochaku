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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 20
        return stackView
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
    let locationManager: CLLocationManager = {
        let location = CLLocationManager()
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.startUpdatingLocation()
        location.requestWhenInUseAuthorization()
        return location
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
        let presentViewController = SearchListViewController()
        
        present(presentViewController, animated: true)
    }
}

// MARK: - Configure View & Layout

extension MapViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureStackView() {
        stackView.addArrangedSubview(segmentedControl)
        stackView.addArrangedSubview(locationSearchBar)
        stackView.addArrangedSubview(mapView)
    }
    
    private func configureLayout() {
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            segmentedControl.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            locationSearchBar.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            mapView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.75),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: view.bounds.height * 0.12
            )
        ])
    }
}
