//
//  firstViewController.swift
//  MapKit_Practice
//
//  Created by 김승현 on 2022/05/18.
//

import UIKit
import MapKit
//import CoreLocation

class firstViewController: UIViewController, CLLocationManagerDelegate {
    
    let myMap: MKMapView = {
        let map = MKMapView()
        map.clipsToBounds = true
        map.layer.cornerRadius = 15
        return map
    }()
    
    let labelForLongitude: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .blue
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()
    
    let labelForLatitude: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .blue
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()

    // 사용자의 위치정보를 다루기 위해 필요함.
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        view.addSubview(myMap)
        view.addSubview(labelForLatitude)
        view.addSubview(labelForLongitude)
        mapViewLayout()
        labelForLongitudeLayout()
        labelForLatitudeLayout()
        
        
        manager.delegate = self
        
        // 정확도 설정 - 최고로 높은 정확도 설정
        manager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 데이터 승인 요구
        manager.requestWhenInUseAuthorization()
        // 위치 업데이트 시작
        manager.startUpdatingLocation()
        // 사용자 위치 보기 설정 (파란점)
        myMap.showsUserLocation = true
        
        // 줌 가능 여부
        myMap.isZoomEnabled = true
        // 스크롤 가능 여부
        myMap.isScrollEnabled = true
        // 회전 가능 여부
        myMap.isRotateEnabled = false
        // 각도 가능 여부
        myMap.isPitchEnabled = false
        
        
    }
    
    // 사용자위치 근처 자세히 확대
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.startUpdatingLocation()
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
             
            myMap.setRegion(region, animated: true)
            
            labelForLongitude.text = "경도: " + String(location.coordinate.longitude)
            labelForLatitude.text = "위도: " + String(location.coordinate.latitude)
            
            print("longitude: \(location.coordinate.longitude)") // 경도: 동경 127도
            print("latitude: \(location.coordinate.latitude)") // 위도: 북위 37도
        }
    }
    

    
    
    // MARK: - mapView AutoLayout
    func mapViewLayout() {
        myMap.translatesAutoresizingMaskIntoConstraints = false
        myMap.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        myMap.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        myMap.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        myMap.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    }
    
    func labelForLongitudeLayout() {
        labelForLongitude.translatesAutoresizingMaskIntoConstraints = false
        labelForLongitude.topAnchor.constraint(equalTo: myMap.bottomAnchor, constant: 30).isActive = true
        labelForLongitude.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        labelForLongitude.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        labelForLongitude.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func labelForLatitudeLayout() {
        labelForLatitude.translatesAutoresizingMaskIntoConstraints = false
        labelForLatitude.topAnchor.constraint(equalTo: labelForLongitude.bottomAnchor, constant: 10).isActive = true
        labelForLatitude.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        labelForLatitude.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        labelForLatitude.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
