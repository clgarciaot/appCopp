//
//  ViewController.swift
//  CopPrueba
//
//  Created by selftisingmacmini on 26/2/24.
//

import UIKit
import SafariServices

class ViewController: UIViewController {

    @IBOutlet weak var textFname: UITextField!
    @IBOutlet weak var textFpass: UITextField!
    
    var nameData = ""
    var passData = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }

    @IBAction func passForgotten(_ sender: Any) {
        
        let url = URL(string: "https://www.google.com")
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func logIn(_ sender: Any) {
        
        nameData = textFname.text!
        passData = textFpass.text!
        
        if nameData.elementsEqual("admin") && passData.elementsEqual("1234"){
            
            let story = UIStoryboard(name: "Main", bundle: nil)
            let viewCB = ViewController1()
            viewCB.modalPresentationStyle = .fullScreen
            self.present(viewCB, animated: true)
        }
        
    }
}

