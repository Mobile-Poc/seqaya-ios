//
//  LoginController.swift
//  seqayaPoc
//
//  Created by NTG Clarity on 3/26/18.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    @IBOutlet var myView: UIView!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // CheckUserDefault()
        usernameTxt.underlined()
        passwordTxt.underlined()
//        if CheckUserDefault(){
//            self.performSegue(withIdentifier: "loginSegue", sender: nil)
//        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true

        loginButton.layer.cornerRadius = loginButton.frame.width/20
        registerButton.layer.cornerRadius = registerButton.frame.width/20
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "myemail")
        //        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
        let gestRec = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gestRec.cancelsTouchesInView = false
        myView.addGestureRecognizer(gestRec)
        let rightView = UIView()
        rightView.addSubview(rightImageView)
        
        rightView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        rightImageView.frame = CGRect(x: 10, y: 0, width: 10, height: 10)
        usernameTxt.rightViewMode = .always
        usernameTxt.rightView = rightView
        
        let passImageView = UIImageView()
        passImageView.image = UIImage(named: "password")
        
        let passView = UIView()
        passView.addSubview(passImageView)
        
        passView.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        passImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        passwordTxt.rightViewMode = .always
        passwordTxt.rightView = passView
        
        
    }
    
    
    
    
    @objc func hideKeyboard () {
        usernameTxt.resignFirstResponder()
        passwordTxt.resignFirstResponder()
        
    }
    
     func CheckUserDefault()-> Bool
    {
        let def = UserDefaults.standard
        let username = def.object(forKey: "email")
        let pass = def.object(forKey: "password")
        
        if (username != nil && pass != nil)
        {
            usernameTxt.text = username as! String
            passwordTxt.text = pass as! String
            return true
            
        }
        return false
        //        performSegue(withIdentifier: "home", sender: nil)
    }
    @IBAction func registerAvctionButton(_ sender: UIButton) {
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func backToLoginUnWind(segue:UIStoryboardSegue){
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        if usernameTxt.text != "" && passwordTxt.text != "" {
            let urlString = "http://mesawer.getsandbox.com/login"
            let param: [String:Any] = ["password":passwordTxt.text! , "email":usernameTxt.text!]
            let service = AlamaofireClient()
            service.requestPOSTURL2(url: urlString, param: param, success: { (success) in
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(UserModel.self, from: success!)
                    let email = result.email
                    print(email)
                    //Add User Credentials to userDefaults
                    let def = UserDefaults.standard
                    def.set(self.usernameTxt.text, forKey: "email")
                    def.set(self.passwordTxt.text, forKey: "password")
                    self.performSegue(withIdentifier: "loginSegue", sender: nil)
                    
                } catch let Error as NSError{
                    print("error catching \(Error.localizedDescription)")
                }
            }) { (error) in
                print("error response")
                let alert = UIAlertController(title: "فشل في تسجيل الدخول" , message: "اسم المستخدم او الرقم السرى غير صحيح", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "تم", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
        }
        else {
            
            let alert = UIAlertController(title: "يوجد حقول فارغة", message: "من فضلك املا الحقول الفارغة", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "تم", style: .default, handler: nil))
            self.present(alert, animated: true)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier{
            if identifier == "loginSegue" {
                
                let targetStoryboardName = "Catalog"
                let targetStoryboard = UIStoryboard(name: targetStoryboardName, bundle: nil)
                
                //                 as? UINavigationController
                if let targetViewController = targetStoryboard.instantiateViewController(withIdentifier: "TabBar")  as? UITabBarController {
                    //                    let dest = targetViewController.topViewController as? CatalogViewController
                    self.present(targetViewController, animated: true, completion: nil)
                }
                
                
                
                //                if let navController = segue.destination as? UINavigationController{
                //                    let targetC = navController.topViewController as? CatalogViewController
                //                    }
            }
        }
    }
}
extension UITextField {
    func underlined(){
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}

