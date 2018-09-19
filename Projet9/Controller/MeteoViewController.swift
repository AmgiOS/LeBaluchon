//
//  MeteoViewController.swift
//  Projet 9
//
//  Created by Amg on 23/08/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class MeteoViewController: UIViewController {
    
    var meteoVar: [MeteoVar] = []
    @IBOutlet weak var countruTextField: UITextField!
    @IBOutlet weak var regionTextField: UITextField!
    @IBOutlet weak var meteoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meteoDidLoad()
        }
    
    @IBAction func searchCountryButton(_ sender: UIButton) {
        meteoData()
    }
    
}

extension MeteoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meteoCell") as! MeteoViewCell
        let meteo = meteoVar[indexPath.row]
        
        cell.countryLabel.text = meteo.countryMeteo
        cell.descriptionLabel.text = meteo.descriptionMeteo
        cell.dateLabel.text = meteo.dateMeteo
        cell.temperatureLabel.text = meteo.tempMeteo
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meteoVar.count
    }
}

extension MeteoViewController {
    private func meteoData () {
        guard let countrySearch = countruTextField.text else {return}
        guard let regionSearch = regionTextField.text else {return}
        MeteoService.shared.getMeteo(country: countrySearch, region: regionSearch) { (success, meteo) in
            if success, let meteoOK = meteo {
                let meteoVar = self.updateMeteo(meteoOK: meteoOK)
                self.meteoVar.append(meteoVar)
                self.meteoTableView.reloadData()
            }
        }
    }
    
    private func meteoDidLoad() {
        MeteoService.shared.getMeteo(country: "new York", region: "en") { (success, meteo) in
            if success, let meteoOK = meteo {
                let meteoVar = self.updateMeteo(meteoOK: meteoOK)
                self.meteoVar.append(meteoVar)
                self.meteoTableView.reloadData()
            }
        }
    }
    private func updateMeteo(meteoOK: Meteo) -> MeteoVar {
        let meteoVar = MeteoVar(
            countryMeteo: meteoOK.query.results.channel.description,
            descriptionMeteo: meteoOK.query.results.channel.item.condition.text,
            dateMeteo: meteoOK.query.results.channel.lastBuildDate,
            tempMeteo: meteoOK.query.results.channel.item.condition.temp)
        return meteoVar
    }

}
