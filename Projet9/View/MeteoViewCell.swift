//
//  MeteoViewCell.swift
//  Projet9
//
//  Created by Amg on 17/09/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class MeteoViewCell: UITableViewCell {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadow()
    }
    
    private func addShadow() {
        weatherView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7).cgColor
        weatherView.layer.shadowRadius = 2.0
        weatherView.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        weatherView.layer.shadowOpacity = 2.0
        weatherView.layer.cornerRadius = 10
    }
}
