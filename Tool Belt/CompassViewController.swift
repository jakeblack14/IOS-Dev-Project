//
//  CompassViewController.swift
//  Tool Belt
//
//  Created by Nathan Daughety on 4/4/17.
//  Copyright © 2017 Harding University. All rights reserved.
//

import UIKit
import CoreLocation

class CompassViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var DirectionLabel: UILabel!
    @IBOutlet weak var CompassImageView: UIImageView!

    var locationManager:CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager  = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
    }
    
    // stop updating users location when not in view
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }
    
    // transform compass arrow to point north at all times
    private func resetCompassHeading(to direction: Double?) {
        CompassImageView.transform = CGAffineTransform(rotationAngle: CGFloat(direction! * .pi / 180))
    }
    
    private func locationManager(manager: CLLocationManager!, didUpdateHeading heading: CLHeading!) {
        DirectionLabel.text = heading.magneticHeading.description
//        // A value of 0 means north, 90 means east,
//        // 180 means south, 270 means west 
//        // and everything else in between.
//        switch heading.magneticHeading
//        {
//        case 0:
//            DirectionLabel.text = "North"
//        case 0..<90:
//            DirectionLabel.text = "Northeast"
//        case 90:
//            DirectionLabel.text = "East"
//        case 90..<180:
//            DirectionLabel.text = "Southeast"
//        case 180:
//            DirectionLabel.text = "South"
//        case 180..<270:
//            DirectionLabel.text = "Southwest"
//        case 270:
//            DirectionLabel.text = "West"
//        case 270..<360:
//            DirectionLabel.text = "Northwest"
//        default:
//            DirectionLabel.text = "Unavailable"
//        }
//        
//        resetCompassHeading(to: heading.magneticHeading)
        
    }
    
    @objc func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
        locationManager.stopUpdatingLocation()
    }

}
