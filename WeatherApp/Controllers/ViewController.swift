//
//  ViewController.swift
//  WeatherApp
//
//  Created by Dara Adekore on 2023-02-20.
//

import UIKit
import CoreLocation
import Alamofire
class ViewController: UIViewController {
    private var locationCoordinates = [(String,String)]()
    var cityName = ""
    var temperature = ""
    var humidity = ""
    var windSpeed = ""
    var _Description = ""
    var iconImage = UIImageView()
    var layoutIsNeeded = true
    let locationManager = CLLocationManager()
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
        let content = UNMutableNotificationContent()
        
        
        content.title = "Good morning!"
        content.body = "Take a look at your local weather!"
        content.sound = UNNotificationSound.default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 8
        dateComponents.minute = 0
        dateComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "WeatherNotification", content: content, trigger: trigger)
        // Request authorization to send notifications
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            if granted {
                print("Authorization granted")
            } else {
                print("Authorization not granted")
            }
        }
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error scheduling morning notification: \(error)")
            } else {
                print("Morning notification scheduled")
            }
        }
        // Do any additional setup after loading the view.
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor(displayP3Red: 135, green: 206, blue: 255, alpha: 1.0).cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.frame.size.width, height: 44))
        let navItem = UINavigationItem(title: "WeatherApp")
        navBar.barStyle = .black
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let leftNavItem = UIBarButtonItem(title:"Log out",image: nil, target: self, action: #selector(signOut))
        navItem.leftBarButtonItem = leftNavItem
        navBar.setItems([navItem], animated: false)
        iconImage.addSubview(iconDescription)
        view.addSubview(navBar)
        view.addSubview(iconImage)
        view.addSubview(firstLabel)
        view.addSubview(secondLabel)
        view.addSubview(thirdLabel)
        view.addSubview(fourthLabel)
        view.addSubview(fifthLabel)
        // Add a right bar button item
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(loadSearchView))
        navItem.rightBarButtonItem = searchButton
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Save the state of the app when it enters the background
        if isMovingFromParent {
            setLoginState(true)
        }
    }
    deinit{
        print("Deallocated!")
    }
    @objc func signOut(){
        setLoginState(false)
        dismiss(animated: true,completion: nil)
        let loginVC = LoginViewController()
        let navVC = UINavigationController(rootViewController: loginVC)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }
    func setLoginState(_ value:Bool){
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "loggedIn")
        
    }
    @objc func loadSearchView(){
        let searchVC = SearchViewController()
        let navVC = UINavigationController(rootViewController: searchVC)
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        
        iconImage.layer.cornerRadius = 5
        iconImage.translatesAutoresizingMaskIntoConstraints = false
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
    
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        locationCoordinates.append(("\(location.coordinate.latitude)","\(location.coordinate.longitude)"))
        NetworkManager.shared.request(with: NetworkManager.shared.getWeatherEndpoint(with: locationCoordinates[0]), and: NetworkManager.shared.getInputType(with: NetworkManager.shared.getWeatherEndpoint(with: locationCoordinates[0]))){ result in
            switch result {
            case .success(let data):
                guard let data = data as? WeatherDataResponse else { return }
                self.cityName = data.name
                self.temperature = "\(Int(data.main.temp - 273))\u{00B0}"
                self.humidity = "\(data.main.humidity) %"
                if let speed = data.wind.speed {
                    self.windSpeed = "\(speed) meters/second"
                }
                if let weatherCollection = data.weather{
                    if let newDescription = weatherCollection[0].description{
                        self._Description = "\(newDescription)"
                    }
                    if let icon = weatherCollection[0].icon{
                        self.iconDescription.text = icon.contains("d") ? "Day time" : "Night time"
                        NetworkManager.shared.request(with: icon, completion: { result in
                            switch result {
                            case .success(let data):
                                if let image = UIImage(data: data){
                                    
                                    self.iconImage.image = image
                                    if self.layoutIsNeeded {
                                        self.layoutIsNeeded = false
                                        self.view.setNeedsLayout()
                                    }
                                }
                                
                            case .failure(let error):
                                print(error)
                            }
                        })
                    }
                }
                
                
                self.locationManager.stopUpdatingLocation()
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get user's location: \(error)")
    }
}
