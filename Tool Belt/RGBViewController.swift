//
//  RGBViewController.swift
//  Tool Belt
//
//  Created by Nathan Daughety on 4/4/17.
//  Copyright © 2017 Harding University. All rights reserved.
//

import UIKit

<<<<<<< HEAD

class RGBViewController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {
    
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBAction func LongPressGesture(_ sender: UILongPressGestureRecognizer) {
    
        
    }
    
    
    let picker = UIImagePickerController()
=======
class RGBViewController: UIViewController {
    @IBOutlet weak var ErrorLabel: UILabel!
>>>>>>> parent of 21d5b24... Updated RGB

    override func viewDidLoad() {
        super.viewDidLoad()

<<<<<<< HEAD
    private func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        myImageView.contentMode = .scaleAspectFit //3
        myImageView.image = chosenImage //4
        dismiss(animated:true, completion: nil) //5
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
=======
        ErrorLabel.text = "This feature is unavailable on this device."
>>>>>>> parent of 21d5b24... Updated RGB
    }


}
