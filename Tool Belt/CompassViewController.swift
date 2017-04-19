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
    
    // transform compass arrow to point north at all times
    private func resetCompassHeading(to direction: Double?) {
        // must convert degrees to radians
        CompassImageView.transform = CGAffineTransform(rotationAngle: CGFloat(direction! * .pi / 180))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set up location manager
        locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        
        // location
        locationManager.distanceFilter = 1000;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        // heading
        locationManager.headingOrientation = .portrait
        locationManager.headingFilter = 5
    }
    
    // start updating the user's location/heading
    override func viewWillAppear(_ animated: Bool) {
        DirectionLabel.adjustsFontSizeToFitWidth = true
        DirectionLabel.textColor = .blue
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    // stop updating users location/heading when view disappears
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingHeading()
        locationManager.startUpdatingLocation()
    }
    
    // Heading readings tend to be widely inaccurate until the system has calibrated itself
    // Return true here allows iOS to show a calibration view when iOS wants to improve itself
    func locationManagerShouldDisplayHeadingCalibration(_ manager: CLLocationManager) -> Bool {
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("My current heading is: " + newHeading.magneticHeading.description)
        
        // A value of 0 means north, 90 means east,
        // 180 means south, 270 means west
        // and everything else in between.
        switch newHeading.magneticHeading
        {
        case 0:
            DirectionLabel.text = "N"
        case 0..<90:
            DirectionLabel.text = "NE"
        case 90:
            DirectionLabel.text = "E"
        case 90..<180:
            DirectionLabel.text = "SE"
        case 180:
            DirectionLabel.text = "S"
        case 180..<270:
            DirectionLabel.text = "SW"
        case 270:
            DirectionLabel.text = "W"
        case 270..<360:
            DirectionLabel.text = "NW"
        default:
            DirectionLabel.text = "Unavailable"
        }
        
        if DirectionLabel.text != "Unavailable" {
            resetCompassHeading(to: newHeading.magneticHeading)
        }
        else {
            resetCompassHeading(to: 0)
        }
        
        
    }
    
    
    @objc func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DirectionLabel.textColor = .red
        DirectionLabel.text = "This feature is unavailable on this device."
        print("Failed to find user's heading: \(error.localizedDescription)")
        locationManager.stopUpdatingHeading()
        locationManager.startUpdatingLocation()
    }
    
}
