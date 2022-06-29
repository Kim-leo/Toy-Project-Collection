//
//  LogInViewController.swift
//  logIn_and_register_screen
//
//  Created by 김승현 on 2022/06/29.
//

import UIKit

class LogInViewController: UIViewController {
    var email = String()
    var password = String()
    var userInfo: UserInfo?
    
    // MARK: - UIComponent
    let emailTextField: UITextField = {
        let emailTF: UITextField = UITextField()
        emailTF.placeholder = "이메일"
        emailTF.font = UIFont(name: "System", size: 14)
        emailTF.borderStyle = .roundedRect
        emailTF.addTarget(self, action: #selector(emailTextFieldEditingChanged(_:)), for: .editingChanged)
        return emailTF
    }()
    
    let passwordTextField: UITextField = {
        let passwordTF: UITextField = UITextField()
        passwordTF.placeholder = "비밀번호"
        passwordTF.font = UIFont(name: "System", size: 14)
        passwordTF.borderStyle = .roundedRect
        passwordTF.addTarget(self, action: #selector(passwordTextFieldEditingChanged(_:)), for: .editingChanged)
        return passwordTF
    }()
    
    let loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그인", for: .normal)
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 5
        btn.backgroundColor = .disabledButtonColor
        btn.addTarget(self, action: #selector(loginButtonDidTap(_:)), for: .touchUpInside)
        return btn
    }()

    let registerButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("계정이 없으신가요?  가입하기", for: .normal)
        btn.setTitleColor(.darkGray, for: .normal)
        btn.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 12)
        btn.addTarget(self, action: #selector(registerButtonDidTap(_:)), for: .touchUpInside)
        return btn
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        setupAttribute()
        addComponentsToScreen()
    }
    
    @objc func emailTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.loginButton.backgroundColor = text.isValidEmail() ? .facebookColor : .disabledButtonColor
        self.email = text
    }
    
    @objc func passwordTextFieldEditingChanged(_ sender: UITextField) {
        let text = sender.text ?? ""
        self.loginButton.backgroundColor = text.count > 2 ? .facebookColor : .disabledButtonColor
        self.password = text
    }
    
    @objc func loginButtonDidTap(_ sender: UIButton) {
        // 회원가입 정보 전달받아서, 그것과 textField 데이터가 일치하면 로그인하기
        guard let userInfo = userInfo else { return }
        
        if userInfo.email == self.email && userInfo.password == self.password {
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "MapVC") as! MapViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        } else {
            
        }
    }
    
    @objc func registerButtonDidTap(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        self.navigationController?.pushViewController(registerViewController, animated: true)
        
        // ARC -> 강한참조, weak self -> ARC 낮춰줌
        registerViewController.userInfo = { [weak self] (userInfo) in
            self?.userInfo = userInfo
        }
    }
    
    private func setupAttribute() {
        // registerButton
        
        let text1 = "계정이 없으신가요?"
        let text2 = "가입하기"
        
        let font1 = UIFont.systemFont(ofSize: 13)
        let font2 = UIFont.boldSystemFont(ofSize: 13)
        
        let color1 = UIColor.darkGray
        let color2 = UIColor.facebookColor
        
        let attributes = generateButtonAttribute(self.registerButton, texts: text1, text2, fonts: font1, font2, colors: color1, color2)
        
        self.registerButton.setAttributedTitle(attributes, for: .normal)
    }
    
    
    // MARK: - UIComponents AutoLayout
    
    func addComponentsToScreen() {
        view.addSubview(passwordTextField)
        passwordTextFieldAuto()
        view.addSubview(emailTextField)
        emailTextFieldAuto()
        view.addSubview(loginButton)
        loginButtonAuto()
        view.addSubview(registerButton)
        registerButtonAuto()
    }
    
    func emailTextFieldAuto() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.widthAnchor.constraint(equalToConstant: 394).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -10).isActive = true
        emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20).isActive = true
        
    }
    
    func passwordTextFieldAuto() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    
    func loginButtonAuto() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    func registerButtonAuto() {
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25).isActive = true
    }
}
