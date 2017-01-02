//
//  ViewController.swift
//  insta
//
//  Created by omid on 12/22/16.
//  Copyright © 2016 omid pourpanah. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ViewController: UIViewController,UIWebViewDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var blur: UIVisualEffectView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var web: UIWebView!
    @IBOutlet weak var textfield: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let btn = view.viewWithTag(22) as! UIButton
        btn.layer.cornerRadius = 5
        btn.layer.shadowOpacity = 1
        btn.layer.shadowOffset = CGSize.zero
        
        subView.layer.cornerRadius = 10
        subView.layer.shadowOpacity = 0.7
        subView.layer.shadowOffset = CGSize.zero
        subView.layer.shadowRadius = 5
        toolbar.layer.shadowOpacity = 0.7
        toolbar.layer.shadowOffset = CGSize(width: 0, height: 1)
        toolbar.layer.shadowRadius = 5
        navbar.layer.shadowOpacity = 0.7
        navbar.layer.shadowOffset = CGSize(width: 0, height: -1)
        navbar.layer.shadowRadius = 5
        
        web.layer.cornerRadius = 10
        web.scalesPageToFit = true
        web.delegate = self
        
        
        loading.isHidden = true
        blur.alpha = 0
        blur.layer.cornerRadius = 10
        
        
        let url = URL(string: "http://ilkfun.ir/api" )
        let task = URLSession.shared.dataTask(with: url!) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil{
                print("error")
                
                
            }else{
               if let content = data {
                    
                do
                {
                    let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? AnyObject
                    if let status = json?["status"]{
                        
                        print(status!)
                 
                     //  self.lbl.text = "\(status!)"
                    }
                    
                }catch
                {
                 print("error")
                }
                }
                
            }
        }
        task.resume()
     
    }

    

    @IBAction func submit(_ sender: Any) {
        
        let url = NSURL(string: "http://mehdia.ir/insta/scrap.php?username=" + textfield.text!.replacingOccurrences(of: " ", with: "0") )
        let request = URLRequest(url: url as! URL)
        
        web.loadRequest(request)
        if (textfield.text?.isEmpty)! {
            
            let myAlert = UIAlertController(title: "خطا!", message: "نام کاربری را وارد نمایید!", preferredStyle: UIAlertControllerStyle.alert)
            myAlert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.cancel, handler: nil))
            
            self.present(myAlert, animated: true, completion: nil)
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
       
        
        
    }
   

    @IBAction func share(_ sender: Any) {
        let bounds = UIScreen.main.bounds
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let activityViewController = UIActivityViewController(activityItems: [img!], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.saveToCameraRoll]
        
        self.present(activityViewController, animated: true, completion: nil)
        
        
    }
    
    func goAwayKeyboard() {
        
        self.textfield.resignFirstResponder()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        goAwayKeyboard()
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        loading.isHidden = false
        loading.startAnimating()
        blur.alpha = 1
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        loading.isHidden = true
        UIView.animate(withDuration: 2, animations: {
        self.blur.alpha = 0
           })
            
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textfield.resignFirstResponder()
        
        return false
    }
    @IBAction func like(_ sender: UIButton) {
        let img:UIImage = UIImage(named: "heart")!
        if  sender.isTouchInside{
            
            
            sender.setImage(img, for: UIControlState.normal)
            
            sender.isUserInteractionEnabled = true
            
          
            let pasteboard = UIPasteboard.general
            pasteboard.string = "\(textfield.text!)"
             let textField = textfield.text
            let string = "heart"
            let defaults = UserDefaults.standard
            defaults.set(string, forKey: "string")
            defaults.set(textField, forKey: "text")
            defaults.synchronize()
            
            
        }
    }
    

    
    @IBAction func unwwind(storyboard: UIStoryboardSegue){
        
    }
    
}

