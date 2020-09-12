//
//  MapViewController.swift
//  NIBM Covid 19
//
//  Created by TM on 9/11/20.
//  Copyright © 2020 nibm. All rights reserved.
//

import UIKit
import Firebase
import MapKit

class MapViewController: UIViewController {

    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let inputActivationUIView = LocationInputActivationUIView ()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Map"

        configureUI()
        enableLocationServices()

        // Do any additional setup after loading the view.
    }
    
    
    func configureUI() {
        confugireMapView()
        
        view.addSubview(inputActivationUIView)
        inputActivationUIView.centerX(inView: view)
        inputActivationUIView.setDimensions(height: 50, width: view.frame.width - 64)
        inputActivationUIView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        inputActivationUIView.alpha = 0
        
        UIView.animate(withDuration: 2) {
            self.inputActivationUIView.alpha = 1
        }
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleShowLocationInputView))
//        addGestureRecognizer(tap)
    }
    
    func confugireMapView() {
           view.addSubview(mapView)
           mapView.frame = view.frame
           
           mapView.showsUserLocation = true
           mapView.userTrackingMode = .follow
       }

    
    // MARK: - Selectors
    
    @objc func handleShowLocationInputView() {
        
    }
    


}

extension MapViewController: CLLocationManagerDelegate {
    
    
    func enableLocationServices() {
        
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
}


class LocationInputActivationUIViewNotUse: UIView {

   // MARK: - Properties
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    private let placeholderLable: UILabel = {
        let label = UILabel()
        label.text = "Where to?"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        
        return label
    }()
    
   // MARK: - LifeCycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.45
        layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        layer.masksToBounds = false
        
        addSubview(indicatorView)
        indicatorView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 16)
        indicatorView.setDimensions(height: 6, width: 6)
        
        addSubview(placeholderLable)
        placeholderLable.centerY(inView: self, leftAnchor: indicatorView.rightAnchor, paddingLeft: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
