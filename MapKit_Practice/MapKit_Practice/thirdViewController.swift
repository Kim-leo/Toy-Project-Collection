//
//  thirdViewController.swift
//  MapKit_Practice
//
//  Created by 김승현 on 2022/05/18.
//

import UIKit
import MapKit

class thirdViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - UIComponents
    let myMap: MKMapView = {
        let map = MKMapView()
        map.clipsToBounds = true
        map.layer.cornerRadius = 15
        return map
    }()
    
    let labelAddressInfo: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .blue
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        label.text = "주소 표시"
        return label
    }()

    // MARK: - 실행영역
    
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        view.addSubview(myMap)
        view.addSubview(labelAddressInfo)
        
        mapViewLayout()
        labelAddressInfoLayout()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        myMap.showsUserLocation = true
        
        self.initView()
    }
    
    private func initView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.didTappedMapView(_:)))
        self.myMap.addGestureRecognizer(tap)
    }
    
    // MARK: - Layout
    func mapViewLayout() {
        myMap.translatesAutoresizingMaskIntoConstraints = false
        myMap.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        myMap.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        myMap.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        myMap.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    }
    
    func labelAddressInfoLayout() {
        labelAddressInfo.translatesAutoresizingMaskIntoConstraints = false
        labelAddressInfo.topAnchor.constraint(equalTo: myMap.bottomAnchor, constant: 30).isActive = true
        labelAddressInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        labelAddressInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        labelAddressInfo.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
}

// 맵을 터치했을 때
extension thirdViewController {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.startUpdatingLocation()
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: coordinate, span: span)
             
            myMap.setRegion(region, animated: true)
        }
    }
    
    @objc private func didTappedMapView(_ sender: UITapGestureRecognizer) {
        //터치한 지점의 촤표 출력
        let location: CGPoint = sender.location(in: self.myMap)
        let mapPoint: CLLocationCoordinate2D = self.myMap.convert(location, toCoordinateFrom: self.myMap)
        
        if sender.state == .ended {
            self.searchLocation(mapPoint)
        }
    }
    
    // 하나만 출력하기 위해 모든 포인트를 삭제
    private func removeAllAnnotation() {
        let allAnnotations = self.myMap.annotations
        self.myMap.removeAnnotations(allAnnotations)
    }
    
    // 해당 포인트(좌표:경도, 위도)의 주소를 검색
    private func searchLocation(_ point: CLLocationCoordinate2D) {
        let geocoder: CLGeocoder = CLGeocoder()
        let location = CLLocation(latitude: point.latitude, longitude: point.longitude)
        
        //포인트 리셋
        self.removeAllAnnotation()
        
        // 해당 좌표의 주소 검색
        geocoder.reverseGeocodeLocation(location) { (placeMarks, error) in
            if error == nil, let marks = placeMarks {
                marks.forEach { (placeMarks) in
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(latitude: point.latitude, longitude: point.longitude)
                    
                    self.labelAddressInfo.text =
                    "행정구역: \(placeMarks.administrativeArea ?? "")"
                    + "\n"
                    + "시 또는 구: \(placeMarks.locality ?? "")"
                    + "\n"
                    + "도로명주소: \(placeMarks.thoroughfare ?? "")"
                    + "\n"
                    + "상세주소: \(placeMarks.subThoroughfare ?? "")"
                    
                    self.myMap.addAnnotation(annotation)
                }
            } else {
                self.labelAddressInfo.text = "검색 실패"
            }
        }
    }
}
