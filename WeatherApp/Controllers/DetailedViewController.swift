//
//  DetailedViewController.swift
//  WeatherApp
//
//  Created by Dara Adekore on 2023-02-20.
//

import UIKit

class DetailedViewController: UIViewController {
    var cityName = ""
    var temperature = ""
    var humidity = ""
    var windSpeed = ""
    var _Description = ""
    var iconImage = UIImageView()
    var layoutIsNeeded = true
    let labelHeight: CGFloat = 30
    let labelSpacing: CGFloat = 100
    let topInset: CGFloat = 150
    let leftInset: CGFloat = 30
    var firstLabel = UILabel()
    var secondLabel = UILabel()
    var thirdLabel = UILabel()
    var fourthLabel = UILabel()
    var fifthLabel = UILabel()
    var iconDescription = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor(displayP3Red: 135, green: 206, blue: 255, alpha: 1.0).cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.frame.size.width, height: 44))
        let navItem = UINavigationItem(title: "WeatherApp")
        navBar.barStyle = .black
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navBar.setItems([navItem], animated: false)
        view.addSubview(navBar)
        // Set the toolbar as the title view of the navigation bar
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"search",image: nil, target: self, action: #selector(cancelTapped))
        //view = DetailedView(frame: view.bounds)
        // Do any additional setup after loading the view.
        let labelHeight: CGFloat = 30
        let labelSpacing: CGFloat = 100
        let topInset: CGFloat = 150
        let leftInset: CGFloat = 30
        
        iconImage = UIImageView(frame: CGRect(x: leftInset, y: topInset, width: 100, height: 100))
        iconImage.layer.cornerRadius = 5
        iconImage.layer.borderWidth = 2
        iconImage.layer.borderColor = UIColor.white.cgColor
        iconImage.addSubview(iconDescription)
        view.addSubview(iconImage)
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        view.addSubview(thirdLabel)
        view.addSubview(fourthLabel)
        view.addSubview(fifthLabel)
        
        
    }
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        iconImage.layer.cornerRadius = 5
        //iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.layer.borderWidth = 2
        iconImage.layer.borderColor = UIColor.white.cgColor
        
        iconDescription.frame = CGRect(x: 15, y: iconImage.frame.height - 40, width: iconImage.frame.width, height: 50)
        iconImage.frame = CGRect(x: leftInset, y: topInset, width: 100, height: 100)
        firstLabel.frame = CGRect(x: leftInset, y: iconImage.frame.maxY + 20, width: view.bounds.width, height: labelHeight * 2)
        secondLabel.frame = CGRect(x: leftInset, y: firstLabel.frame.maxY, width: view.bounds.width, height: labelHeight)
        thirdLabel.frame = CGRect(x: leftInset, y: secondLabel.frame.maxY + labelSpacing, width: view.bounds.width, height: labelHeight)
        fourthLabel.frame = CGRect(x: leftInset, y: thirdLabel.frame.maxY + labelSpacing, width: view.bounds.width, height: labelHeight)
        fifthLabel.frame = CGRect(x: leftInset, y: fourthLabel.frame.maxY + labelSpacing, width: view.bounds.width, height: labelHeight)
        
        firstLabel.font = UIFont(name: "Avenir", size: 20.0)
        firstLabel.text = "local area : \(cityName)"
        firstLabel.textColor = .white
        firstLabel.textAlignment = .left
        firstLabel.shadowColor = UIColor.black
        firstLabel.shadowOffset = CGSize(width: 2, height: 2)
        firstLabel.layer.shadowRadius = 2
        
        secondLabel.font = UIFont(name: "Avenir", size: 24.0)
        secondLabel.text = "temperature : \(temperature)"
        secondLabel.textAlignment = .left
        secondLabel.textColor = .white
        secondLabel.shadowColor = UIColor.black
        secondLabel.shadowOffset = CGSize(width: 2, height: 2)
        secondLabel.layer.shadowRadius = 2
        
        
        
        thirdLabel.font = UIFont(name: "Avenir", size: 24.0)
        thirdLabel.text = "humidity : \(humidity)"
        thirdLabel.textAlignment = .left
        thirdLabel.textColor = .white
        thirdLabel.shadowColor = UIColor.black
        thirdLabel.shadowOffset = CGSize(width: 2, height: 2)
        thirdLabel.layer.shadowRadius = 2
        
        
        
        fourthLabel.font = UIFont(name: "Avenir", size: 24.0)
        fourthLabel.text = "windspeed : \(windSpeed)"
        fourthLabel.textAlignment = .left
        fourthLabel.textColor = .white
        fourthLabel.shadowColor = UIColor.black
        fourthLabel.shadowOffset = CGSize(width: 2, height: 2)
        fourthLabel.layer.shadowRadius = 2
        
        
        
        fifthLabel.font = UIFont(name: "Avenir", size: 24.0)
        fifthLabel.text = "description : \(_Description)"
        fifthLabel.textAlignment = .left
        fifthLabel.textColor = .white
        fifthLabel.shadowColor = UIColor.black
        fifthLabel.shadowOffset = CGSize(width: 2, height: 2)
        fifthLabel.layer.shadowRadius = 2
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Save the state of the app when it enters the background
        if isMovingFromParent {
            setLoginState(true)
        }
    }
    func setLoginState(_ value:Bool){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "loggedIn")
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
