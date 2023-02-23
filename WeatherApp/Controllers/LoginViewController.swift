//
//  LoginViewController.swift
//  WeatherApp
//
//  Created by Dara Adekore on 2023-02-21.
//

import UIKit
import FLAnimatedImage
class LoginViewController: UIViewController {
    var username = UITextField()
    var password = UITextField()
    var loginButton = UIButton()
    var logo = UIImageView()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        username.attributedPlaceholder = NSAttributedString(
            string: "Username",attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        password.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        username.font = UIFont.systemFont(ofSize: 20)
        username.textColor = .black
        username.textAlignment = .center
        username.layer.cornerRadius = 5
        username.backgroundColor = .white
        username.translatesAutoresizingMaskIntoConstraints = false
        password.font = UIFont.systemFont(ofSize: 20)
        password.textColor = .black
        password.textAlignment = .center
        password.layer.cornerRadius = 5
        password.backgroundColor = .white
        password.isSecureTextEntry = true
        password.translatesAutoresizingMaskIntoConstraints = false
        logo.image = UIImage(named: "logo")
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.backgroundColor = .gray
        logo.layer.cornerRadius = 5
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.backgroundColor = .clear
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.gray.cgColor
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        loginButton.layer.cornerRadius = 5
        loginButton.layer.shadowRadius = 20
        guard let gifUrl = Bundle.main.url(forResource: "sky-clouds", withExtension: "gif") else { return }
        guard let gifData = try? Data(contentsOf: gifUrl) else { return }
        let gifImage = UIImage.gifImageWithData(gifData)
        let gifView = UIImageView(image: gifImage)
        gifView.frame = view.bounds
        gifView.contentMode = .scaleAspectFill
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = gifView.bounds
        gifView.addSubview(blurView)
        gifView.sendSubviewToBack(blurView)
        view.addSubview(gifView)
        view.sendSubviewToBack(gifView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
        //view.backgroundColor = UIColor(patternImage: UIImage(named: "FreeVector-Cloud-Pattern")!)
        view.addSubview(username)
        view.addSubview(password)
        view.addSubview(loginButton)
        view.addSubview(logo)
        
        
        getLoginState()
    }
    func getLoginState(){
        //Already logged in
        if defaults.bool(forKey: "loggedIn") == true{
            goToMainAppScreen()
        }
    }
    func setLoginState(_ value:Bool){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "loggedIn")
    }
    func logIn(username:String, password:String){
        if let database = defaults.object(forKey: "database") as? [String:String]{
            if let usersPassword = database[username]{
                if password == usersPassword{
                    setLoginState(true)
                    goToMainAppScreen()
                }
                else {
                    let ac = UIAlertController(title: "Wrong password", message: "", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
                    present(ac,animated: true)
                }
            }
            else {
                let ac = UIAlertController(title: "User not found", message: "Would you like to register?", preferredStyle: .actionSheet)
                ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                    self.register(username: username, password: password)
                    self.setLoginState(true)
                    self.goToMainAppScreen()
                }))
                ac.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
                present(ac, animated: true, completion: nil)
                
            }
        }
        else {
            let ac = UIAlertController(title: "User not found", message: "Would you like to register?", preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                self.register(username: username, password: password)
                self.setLoginState(true)
                self.goToMainAppScreen()
            }))
            ac.addAction(UIAlertAction(title: "No", style: .destructive, handler: nil))
            present(ac, animated: true, completion: nil)
        }
        
    }
    
    func register(username:String,password:String){
        if var database = defaults.object(forKey: "database") as? [String:String]{
            database[username] = password
            defaults.set(database, forKey: "database")
        }
        else{
            defaults.set([username:password], forKey: "database")
        }
    }
    func goToMainAppScreen() {
        let mainAppVC = ViewController()
        mainAppVC.modalPresentationStyle = .fullScreen
        present(mainAppVC, animated: true, completion: nil)
    }
    
    @objc func dismissKeyboard(){
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    @objc func loginTapped(){
        if let username = username.text, let password = password.text{
            logIn(username: username, password: password)
        }
        username.text = ""
        password.text = ""
    }
    override func viewWillLayoutSubviews() {
        
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            logo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150),
            username.topAnchor.constraint(equalTo: logo.topAnchor, constant: 100),
            username.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            username.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            password.topAnchor.constraint(equalTo: username.bottomAnchor,constant: 50),
            password.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            password.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            loginButton.topAnchor.constraint(equalTo: password.bottomAnchor,constant: 50),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 150),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -150)
        ])
    }
}
