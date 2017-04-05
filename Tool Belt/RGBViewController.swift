//
//  RGBViewController.swift
//  Tool Belt
//
//  Created by Nathan Daughety on 4/4/17.
//  Copyright © 2017 Harding University. All rights reserved.
//

import UIKit

class RGBViewController: UIViewController {
    @IBOutlet weak var ErrorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        ErrorLabel.text = "This feature is unavailable on this device."
    }


}
