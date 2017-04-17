

import UIKit
import Foundation
    
    class RGBViewController: UIViewController,
        UIImagePickerControllerDelegate,
    UINavigationControllerDelegate  {
        
        @IBOutlet weak var myImageView: UIImageView!
        @IBOutlet weak var photoFromLibrary: UIButton!
        
        let picker = UIImagePickerController()
        
        @IBAction func photoFromLibrary(_ sender: UIButton) {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(picker, animated: true, completion: nil)
        }
        
        override func viewDidLoad()
        {
            super.viewDidLoad()
            picker.delegate = self
            
        }
        
      
        func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject])
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
        }
        
        
}
