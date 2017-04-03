//
//  LevelViewController.swift
//  Tool Belt
//
//  Created by Nathan Daughety on 4/3/17.
//  Copyright © 2017 Harding University. All rights reserved.
//

import UIKit
import CoreMotion // For Core Motion Manager

class LevelViewController: UIViewController {

    let manager = CMMotionManager()
    
    @IBOutlet weak var XLabel: UILabel!
    @IBOutlet weak var YLabel: UILabel!
    @IBOutlet weak var ZLabel: UILabel!
    @IBOutlet weak var ErrorLabel: UILabel!

    
    @IBOutlet weak var XSlider: UISlider!
    @IBOutlet weak var YSlider: UISlider!
    @IBOutlet weak var ZSlider: UISlider!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // prep accelerometer manager to recieve updates
        // and place updates in the corresponding text labels
        if manager.isAccelerometerAvailable {
            manager.accelerometerUpdateInterval = 0.01
            manager.startAccelerometerUpdates(to: .main, withHandler: {
                [weak self] (data: CMAccelerometerData?, error: Error?) in
                if let acceleration = data?.acceleration {
                    self?.XLabel.text = acceleration.x.description
                    self?.YLabel.text = acceleration.y.description
                    self?.ZLabel.text = acceleration.z.description
                    
                    self?.XSlider.setValue(Float(acceleration.x), animated: true)
                    self?.YSlider.setValue(Float(acceleration.y), animated: true)
                    self?.ZSlider.setValue(Float(acceleration.z), animated: true)
                }
            })
        }
        else {
            XLabel.text = "Could not be calculated."
            YLabel.text = "Could not be calculated."
            ZLabel.text = "Could not be calculated."
            ErrorLabel.text = "This feature is unavailable on this device."
            XSlider.setValue(0, animated: false)
            YSlider.setValue(0, animated: false)
            ZSlider.setValue(0, animated: false)
        }
    }
    
    // must stop updates when view disappears
    override func viewWillDisappear(_ animated: Bool) {
        manager.stopAccelerometerUpdates()
    }
    
}
