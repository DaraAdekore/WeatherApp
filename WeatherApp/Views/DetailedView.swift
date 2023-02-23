//
//  DetailedView.swift
//  WeatherApp
//
//  Created by Dara Adekore on 2023-02-20.
//

import UIKit

class DetailedView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    var cityName:UILabel!
    var temperature:UILabel!
    var humidity:UILabel!
    var windSpeed:UILabel!
    var _Description:UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        addSubview(cityName)
//        addSubview(temperature)
//        addSubview(humidity)
//        addSubview(windSpeed)
//        addSubview(_Description)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
