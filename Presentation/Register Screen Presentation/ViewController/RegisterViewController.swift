//
//  RegisterViewController.swift
//  seqayaPoc
//
//  Created by NTG-Apple12 on 2018-03-26.
//  Copyright © 2018 Mariam Elsayed Ismail. All rights reserved.
//

import UIKit




class RegisterViewController: UIViewController , UITextFieldDelegate {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rewritePassTextField: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var registerBtn: UIButton!
    
    var activeTextField: UITextField?
    var registrationPresenter: RegisterationPresenterProtocol?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registrationPresenter = RegisterationPresenter(registrationViewControler: self)
        addImagePlaceholderToText()
        changeTextPlaceHolderColor()
        setUpBtnImages()
        addTextBottomLines()
        // handling keyboard
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+200)
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        tapGR.cancelsTouchesInView = false
        scrollView.addGestureRecognizer(tapGR)
        registerBtn.isEnabled = false
        handleTextFields()
        
    }
    
    //
    
    @objc func hideKeyBoard(){
        nameTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        phoneTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        rewritePassTextField.resignFirstResponder()
    }
    // handele empty text
    func handleTextFields(){
        nameTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        rewritePassTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        phoneTextField.addTarget(self, action: #selector(textFieldsChanged), for: .editingChanged)
        
    }
    
    @objc func textFieldsChanged(){
        guard let userName = nameTextField.text , !userName.isEmpty , let email = emailTextField.text , !email.isEmpty , let password = passwordTextField.text , !password.isEmpty , let repassword = rewritePassTextField.text , !repassword.isEmpty , let phonenumber = phoneTextField.text , !phonenumber.isEmpty else {
            registerBtn.setTitleColor(UIColor.black, for: .normal)
            registerBtn.isEnabled = false
            return
        }
        registerBtn.setTitleColor(UIColor.white, for: .normal)
        registerBtn.isEnabled = true
    }
    
    
    
    @IBAction func loginBtnTapped(_ sender: UIButton) {
        registrationPresenter?.CanceBtnTapped()
    }
    
    
    
    @IBAction func registerBtnTapped(_ sender: UIButton) {
        
        if passwordTextField.text != rewritePassTextField.text {
            let alert  = UIAlertController(title: "كلمة سر خاطئة", message: " من فضلك ادخل كلمة سر متطابقة ", preferredStyle:.alert)
            let action = UIAlertAction(title: "تم", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }else if(emailTextField.text != nil && emailTextField.text != ""){
            if (!ValidationHelpers().isValidEmail(testStr: emailTextField.text!)){
                let alert  = UIAlertController(title: "خطأ في البريد الكتروني ", message: "برجاء ادخال عنوان بريد الكتروني صحيح", preferredStyle:.alert)
                let action = UIAlertAction(title: "تم", style: .default, handler: nil)
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            } else{
                
                self.registrationPresenter?.registeruser(name: nameTextField.text!, email: emailTextField.text!, password: passwordTextField.text!, phoneNumber: phoneTextField.text!)
                
            }
        }
    }
    
    
    func setUpBtnImages() {
        // register
        registerBtn.layer.cornerRadius = registerBtn.frame.width / 10
        loginBtn.layer.cornerRadius = registerBtn.frame.width / 10
        logoImageView.layer.cornerRadius = logoImageView.frame.size.height / 2
        // text color
        emailTextField.textColor = UIColor(red: 79, green: 155, blue: 234, alpha: 1)
        nameTextField.textColor = UIColor(red: 79, green: 155, blue: 234, alpha: 1)
        phoneTextField.textColor = UIColor(red: 79, green: 155, blue: 234, alpha: 1)
        passwordTextField.textColor = UIColor(red: 79, green: 155, blue: 234, alpha: 1)
        rewritePassTextField.textColor = UIColor(red: 79, green: 155, blue: 234, alpha: 1)
        
    }
    
    func changeTextPlaceHolderColor(){
        emailTextField.attributedPlaceholder = NSAttributedString(string: "البريد الالكتروني:",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        nameTextField.attributedPlaceholder = NSAttributedString(string: "اسم المستخدم:",
                                                                 attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        phoneTextField.attributedPlaceholder = NSAttributedString(string: "رقم الهاتف:",
                                                                  attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "كلمه السر:",
                                                                     attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        rewritePassTextField.attributedPlaceholder = NSAttributedString(string: "اعد كتابه كلمه السر: ",
                                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }
    
    func addImagePlaceholderToText(){
        // add image placeholder to email text field
        let emailimageview = UIImageView()
        let image = UIImage(named: "mail")
        emailimageview.image = image
        
        let rightview = UIView()
        rightview.addSubview(emailimageview)
        
        emailTextField.rightViewMode = UITextFieldViewMode.always
        rightview.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        emailimageview.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        emailTextField.rightView = rightview
        
        // add image placeholder to email text field
        let nameimageview = UIImageView()
        let nameimage = UIImage(named: "user2")
        nameimageview.image = nameimage
        
        let namerightview = UIView()
        namerightview.addSubview(nameimageview)
        
        nameTextField.rightViewMode = UITextFieldViewMode.always
        namerightview.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        nameimageview.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        nameTextField.rightView = namerightview
        
        // add image placeholder to email text field
        let phoneimageview = UIImageView()
        let phoneimage = UIImage(named: "phone1")
        phoneimageview.image = phoneimage
        
        let phonerightview = UIView()
        phonerightview.addSubview(phoneimageview)
        
        phoneTextField.rightViewMode = UITextFieldViewMode.always
        phonerightview.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        phoneimageview.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        phoneTextField.rightView = phonerightview
        
        // add image to pass text field
        let passimageview = UIImageView()
        let passimage = UIImage(named: "password")
        passimageview.image = passimage
        
        let passrightview = UIView()
        passrightview.addSubview(passimageview)
        
        passwordTextField.rightViewMode = UITextFieldViewMode.always
        passrightview.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        passimageview.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        passwordTextField.rightView = passrightview
        
        
        // add image to rewrite pass text field
        let repassimageview = UIImageView()
        let repassimage = UIImage(named: "password")
        repassimageview.image = repassimage
        
        let repassrightview = UIView()
        repassrightview.addSubview(repassimageview)
        
        rewritePassTextField.rightViewMode = UITextFieldViewMode.always
        repassrightview.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        repassimageview.frame = CGRect(x: 10, y: 10, width: 20, height: 20)
        rewritePassTextField.rightView = repassrightview
    }
    
    func addTextBottomLines(){
        
        // add bottom line to all textfield
        let emailbottomLayer = CALayer()
        emailbottomLayer.frame = CGRect(x: 0, y: 29, width: emailTextField.frame.width, height: 2)
        emailbottomLayer.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        emailTextField.layer.addSublayer(emailbottomLayer)
        
        
        let passbottomLayer = CALayer()
        passbottomLayer.frame = CGRect(x: 0, y: 29, width: emailTextField.frame.width, height: 2)
        passbottomLayer.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        passwordTextField.layer.addSublayer(passbottomLayer)
        
        let repassbottomLayer = CALayer()
        repassbottomLayer.frame = CGRect(x: 0, y: 29, width: emailTextField.frame.width, height: 2)
        repassbottomLayer.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        rewritePassTextField.layer.addSublayer(repassbottomLayer)
        
        let phonebottomLayer = CALayer()
        phonebottomLayer.frame = CGRect(x: 0, y: 29, width: emailTextField.frame.width, height: 2)
        phonebottomLayer.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        phoneTextField.layer.addSublayer(phonebottomLayer)
        
        let namebottomLayer = CALayer()
        namebottomLayer.frame = CGRect(x: 0, y: 29, width: emailTextField.frame.width, height: 2)
        namebottomLayer.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1).cgColor
        nameTextField.layer.addSublayer(namebottomLayer)
        
    }


}

extension RegisterViewController: RegisteViewControllerProtocol{
    
    func canceltapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func registractionComplete(code: Int) {
        if code == 201 {
            self.performSegue(withIdentifier:"showCatlog", sender: self)
        }
        
        else {
            let alert  = UIAlertController(title: "خطآ", message: "فشل عمليه التسجيل ", preferredStyle:.alert)
            let action = UIAlertAction(title: "الغاء", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            
        }
    }
    
    
}
