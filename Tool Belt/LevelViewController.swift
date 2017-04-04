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
        if manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 0.01
            manager.startDeviceMotionUpdates(to: .main, withHandler: {
                [weak self] (data: CMDeviceMotion?, error: Error?) in
                if let motion = data?.rotationRate {
                    self?.XLabel.text = motion.x.description
                    self?.YLabel.text = motion.y.description
                    self?.ZLabel.text = motion.z.description
                    
                    self?.XSlider.setValue(Float(motion.x), animated: true)
                    self?.YSlider.setValue(Float(motion.y), animated: true)
                    self?.ZSlider.setValue(Float(motion.z), animated: true)
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
        manager.stopDeviceMotionUpdates()
    }
    
}
