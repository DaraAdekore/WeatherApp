//
//  ResultViewCell.swift
//  WeatherApp
//
//  Created by Dara Adekore on 2023-02-20.
//

import UIKit

class ResultViewCell: UITableViewCell {
    var cityName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public func configure(){
        // Add subviews to the cell's contentView
        contentView.addSubview(cityName)
        // Configure subview properties
        
        cityName.translatesAutoresizingMaskIntoConstraints = false
        cityName.textColor = .black
        cityName.font = UIFont.boldSystemFont(ofSize: 24)
        cityName.textAlignment = .center
        self.backgroundView?.backgroundColor = .clear
        self.backgroundColor = .clear
        // Add autolayout constraints to position and size subviews
        NSLayoutConstraint.activate([
            cityName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cityName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cityName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cityName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

}
