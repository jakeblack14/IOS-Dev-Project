

import UIKit
import Foundation


extension UIColor {
    
    func rgb() -> (red:Int, green:Int, blue:Int, alpha:Int)? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)
            
            return (red:iRed, green:iGreen, blue:iBlue, alpha:iAlpha)
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
}

extension UIImage {
    
    func getPixelColor(pos: CGPoint) -> UIColor {
        
        if let pixelData = self.cgImage?.dataProvider?.data {
            let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
            
            let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
            
            let r = CGFloat(data[pixelInfo+0]) / CGFloat(255.0)
            let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
            let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
            let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
            
            return UIColor(red: b, green: g, blue: r, alpha: a)
        } else {
            //IF something is wrong I returned WHITE, but change as needed
            return UIColor.white
        }
    }
}


    class RGBViewController: UIViewController,
        UIImagePickerControllerDelegate,
    UINavigationControllerDelegate  {
        
        @IBOutlet weak var camera: UIButton!
        @IBOutlet weak var myImageView: UIImageView!
        @IBOutlet weak var photoFromLibrary: UIButton!
        @IBOutlet weak var RedLabel: UILabel!
        @IBOutlet weak var GreenLabel: UILabel!
        @IBOutlet weak var BlueLabel: UILabel!
        
        let picker = UIImagePickerController()
        
        @IBAction func shootPhoto(_ sender: UIButton) {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        }
        
        @IBAction func photoFromLibrary(_ sender: UIButton) {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            present(picker, animated: true, completion: nil)
        }
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let touch = touches.first {
                let position = touch.location(in: self.myImageView)
               let colorAtPixel : UIColor = (myImageView.image?.getPixelColor(pos: CGPoint(x: position.x, y: position.y)))!
               
                print(colorAtPixel.rgb()!)
                RedLabel.text = String(describing: colorAtPixel.rgb()!.red)
                GreenLabel.text = String(describing: colorAtPixel.rgb()!.green)
                BlueLabel.text = String(describing: colorAtPixel.rgb()!.blue)
                
            }
        }
        
        override func viewDidLoad()
        {
            super.viewDidLoad()
            picker.delegate = self
           
            
        }
      
       
        
        @nonobjc func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : AnyObject])
        {
            let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
            myImageView.contentMode = .scaleAspectFit //3
            myImageView.image = chosenImage //4
            dismiss(animated:true, completion: nil) //5
        }
        
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
            
        }
        
        
}
