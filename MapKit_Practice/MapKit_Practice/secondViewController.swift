//
//  secondViewController.swift
//  MapKit_Practice
//
//  Created by 김승현 on 2022/05/18.
//

import UIKit
import MapKit

class secondViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - UIComponents
    let segmentControl: UISegmentedControl = {
        let names = ["현재 위치", "수유역", "해운대"]
        let seg = UISegmentedControl(items: names)
        seg.selectedSegmentIndex = 0
        seg.clipsToBounds = true
        seg.layer.cornerRadius = 5
        seg.backgroundColor = .white
        seg.addTarget(self, action: #selector(segmentAction(_:)), for: .valueChanged)
        return seg
    }()
    
    let myMap: MKMapView = {
        let map = MKMapView()
        map.clipsToBounds = true
        map.layer.cornerRadius = 15
        return map
    }()
    
    let labelLocationInfo1: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .blue
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()
    
    let labelLocationInfo2: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .blue
        label.textAlignment = .center
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()
    
    
    // MARK: - 실행영역
    let manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
        view.addSubview(segmentControl)
        view.addSubview(myMap)
        view.addSubview(labelLocationInfo1)
        view.addSubview(labelLocationInfo2)
        segmentLayout()
        mapViewLayout()
        labelLocationInfo1Layout()
        labelLocationInfo2Layout()
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        myMap.showsUserLocation = true
        
    }
    
    // MARK: - 지도 기능
    
    func goLocation(latitudeValue: CLLocationDegrees,
                    longitudeValue : CLLocationDegrees, delta span : Double) -> CLLocationCoordinate2D {
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func setAnnotation(latitudeValue : CLLocationDegrees, longitudeValue : CLLocationDegrees, delta span : Double, title strTitle: String, subtitle strSubtitle : String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let pLocation = locations.last
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address:String = country!
            if pm!.locality != nil {
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil {
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.labelLocationInfo1.text = "현재 위치"
            self.labelLocationInfo2.text = address
        })
        manager.stopUpdatingLocation()
    }
    
    @objc func segmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            labelLocationInfo1.text = ""
            labelLocationInfo1.text = ""
            manager.startUpdatingLocation()
        case 1:
            setAnnotation(latitudeValue: 37.63722, longitudeValue: 127.02474, delta : 0.01,
                          title: "수유역", subtitle: "서울특별시 강북구 수유동 140")
            self.labelLocationInfo1.text = "보고 계신 위치"
            self.labelLocationInfo2.text = "수유역"
        case 2:
            setAnnotation(latitudeValue: 35.15869, longitudeValue: 129.16040, delta : 0.015,
                          title: "해운대", subtitle: "해운대구 우1동")
            self.labelLocationInfo1.text = "보고 계신 위치"
            self.labelLocationInfo2.text = "해운대 해수욕장"
        default:
            break
        }
    }
    
    // MARK: - mapView AutoLayout
    func segmentLayout() {
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        segmentControl.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    func mapViewLayout() {
        myMap.translatesAutoresizingMaskIntoConstraints = false
        myMap.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 20).isActive = true
        myMap.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200).isActive = true
        myMap.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        myMap.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
    }
    
    func labelLocationInfo1Layout() {
        labelLocationInfo1.translatesAutoresizingMaskIntoConstraints = false
        labelLocationInfo1.topAnchor.constraint(equalTo: myMap.bottomAnchor, constant: 30).isActive = true
        labelLocationInfo1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        labelLocationInfo1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        labelLocationInfo1.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func labelLocationInfo2Layout() {
        labelLocationInfo2.translatesAutoresizingMaskIntoConstraints = false
        labelLocationInfo2.topAnchor.constraint(equalTo: labelLocationInfo1.bottomAnchor, constant: 10).isActive = true
        labelLocationInfo2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        labelLocationInfo2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        labelLocationInfo2.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
