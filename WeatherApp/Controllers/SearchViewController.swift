//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by Dara Adekore on 2023-02-20.
//

import UIKit

class SearchViewController: UIViewController {
    var searchBar = UISearchBar()
    var tableView = UITableView()
    var cityResults = CityNameResponses()
    var zipResults = [ZipCodeResponse]()
    var justLoaded = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ResultViewCell.self, forCellReuseIdentifier: "result")
        tableView.backgroundColor = .clear
        // Do any additional setup after loading the view.
        // Set up the search bar
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [UIColor.systemTeal.cgColor, UIColor(displayP3Red: 135, green: 206, blue: 255, alpha: 1.0).cgColor]
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        view.addSubview(blurView)
        searchBar.placeholder = "Search"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.searchBarStyle = .minimal
        
        // Add the search bar to a toolbar
        let searchBarToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        searchBarToolbar.items = [UIBarButtonItem(customView: searchBar)]
        
        // Set the toolbar as the title view of the navigation bar
        navigationItem.titleView = searchBarToolbar
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTapped))
        // Add a tap gesture recognizer to the view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        view.addSubview(tableView)
    }
    @objc func dismissKeyboard(){
        searchBar.resignFirstResponder()
    }
    @objc func cancelTapped() {
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    func userSearch(_ userInput:String){
        NetworkManager.shared.request(with: NetworkManager.shared.getGeoEndpoint(with: userInput), and: NetworkManager.shared.getInputType(with: NetworkManager.shared.getGeoEndpoint(with: userInput))){ [self] result in
            switch result {
            case .success(let data):
                if let cityNameResponse = data as? CityNameResponses{
                    cityResults = []
                    cityResults = cityNameResponse
                    justLoaded = "CityName"
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                else if let zipCodeResponses = data as? ZipCodeResponse{
                    zipResults = []
                    zipResults.append(zipCodeResponses)
                    justLoaded = "Zip"
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
extension SearchViewController: UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if justLoaded == "CityName" {
            return cityResults.count
        }
        else if justLoaded == "Zip"{
            return zipResults.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "result", for: indexPath) as? ResultViewCell
        if justLoaded == "CityName"{
            cell?.cityName.text = "\(cityResults[indexPath.item].name!), \(cityResults[indexPath.item].country!)"
        }
        else if justLoaded == "Zip"{
            cell?.cityName.text = "\(zipResults[indexPath.item].name), \(zipResults[indexPath.item].country)"
        }
        cell?.cityName.textAlignment = .center
        cell?.cityName.textColor = .white
        return cell!
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if justLoaded == "CityName" {
            guard let lat = cityResults[indexPath.item].lat, let lon = cityResults[indexPath.item].lon else { return }
            let pair = ("\(lat)","\(lon)")
            NetworkManager.shared.request(with: NetworkManager.shared.getWeatherEndpoint(with: pair), and: NetworkManager.shared.getInputType(with: NetworkManager.shared.getWeatherEndpoint(with: pair)), completion: { result in
                switch result {
                case .success(let data):
                    let detailVC = DetailedViewController()
                    let navVC = UINavigationController(rootViewController: detailVC)
                    navVC.modalPresentationStyle = .fullScreen
                    
                    guard let data = data as? WeatherDataResponse else { return }
                    detailVC.cityName = data.name
                    detailVC.temperature = "\(Int(data.main.temp - 273))\u{00B0}"
                    detailVC.humidity = "\(data.main.humidity) %"
                    if let speed = data.wind.speed {
                        detailVC.windSpeed = "\(speed) meters/second"
                    }
                    if let weatherCollection = data.weather{
                        if let newDescription = weatherCollection[0].description{
                            detailVC._Description = "\(newDescription)"
                        }
                        if let icon = weatherCollection[0].icon{
                            detailVC.iconDescription.text = icon.contains("d") ? "Day time" : "Night time"
                            NetworkManager.shared.request(with: icon, completion: { result in
                                switch result {
                                case .success(let data):
                                    if let image = UIImage(data: data){
                                        detailVC.iconImage.image = image
                                    }
                                    
                                case .failure(let error):
                                    print(error)
                                }
                            })
                        }
                    }
                    self.present(navVC, animated: true, completion: nil)
                case .failure(let error):
                    print(error)
                }
            })
        }
        else if justLoaded == "Zip" {
            let pair = ("\(zipResults[indexPath.item].lat)","\(zipResults[indexPath.item].lon)")
            NetworkManager.shared.request(with: NetworkManager.shared.getWeatherEndpoint(with: pair), and: NetworkManager.shared.getInputType(with: NetworkManager.shared.getWeatherEndpoint(with: pair)), completion: { result in
                switch result {
                case .success(let data):
                    
                    let detailVC = DetailedViewController()
                    let navVC = UINavigationController(rootViewController: detailVC)
                    navVC.modalPresentationStyle = .fullScreen
                    navVC.navigationBar.barStyle = .black
                    guard let data = data as? WeatherDataResponse else { return }
                    detailVC.cityName = data.name
                    detailVC.temperature = "\(Int(data.main.temp - 273))\u{00B0}"
                    detailVC.humidity = "\(data.main.humidity) %"
                    if let speed = data.wind.speed {
                        detailVC.windSpeed = "\(speed) meters/sec"
                    }
                    if let weatherCollection = data.weather{
                        if let newDescription = weatherCollection[0].description{
                            detailVC._Description = "\(newDescription)"
                        }
                        if let icon = weatherCollection[0].icon{
                            detailVC.iconDescription.text = icon.contains("d") ? "Day time" : "Night time"
                            NetworkManager.shared.request(with: icon, completion: { result in
                                switch result {
                                case .success(let data):
                                    if let image = UIImage(data: data){
                                        detailVC.iconImage.image = image
                                    }
                                    
                                case .failure(let error):
                                    print(error)
                                }
                            })
                        }
                    }
                    self.present(navVC, animated: true, completion: nil)
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text, text != ""{
            searchBar.resignFirstResponder()
            userSearch(text)
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == ""{
            zipResults = []
            cityResults = []
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
