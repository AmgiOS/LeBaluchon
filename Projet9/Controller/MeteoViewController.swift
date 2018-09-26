//
//  MeteoViewController.swift
//  Projet 9
//
//  Created by Amg on 23/08/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class MeteoViewController: UIViewController {
    //MARK: VARIABLES
    private var meteoService = MeteoService()
    var meteoVar = [MeteoComponents]()
    
    //MARK: OUTLETS
    @IBOutlet weak var countruTextField: UITextField!
    @IBOutlet weak var meteoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        meteoDidLoad()
    }
    
    //MARK: IBACTION
    @IBAction func searchCountryButton(_ sender: UIButton) {
        meteoData()
    }
}

extension MeteoViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK: PICKER VIEW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meteoCell") as! MeteoViewCell
        let meteo = meteoVar[indexPath.row]
       cell.meteo = meteo
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meteoVar.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            meteoVar.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            meteoTableView.reloadData()
        }
    }
}


extension MeteoViewController {
    //MARK: FUNCTIONS
    private func meteoData () {
        guard let countrySearch = countruTextField.text else {return}
        if countrySearch.isEmpty {
            alertTextIsEmpty()
        }
        meteoService.getMeteo(country: countrySearch) { (success, meteo) in
            if success, let meteoOK = meteo {
                let meteoVar = self.updateMeteo(meteoOK: meteoOK)
                self.meteoVar.append(meteoVar)
                self.meteoTableView.reloadData()
                self.dismiss(animated: true)
            }
        }
    }
    
    private func meteoDidLoad() {
        meteoService.getMeteo(country: "NewYork") { (success, meteo) in
            if success, let meteoOK = meteo {
                let meteoVar = self.updateMeteo(meteoOK: meteoOK)
                self.meteoVar.append(meteoVar)
                self.meteoTableView.reloadData()
            }
        }
    }
    
    private func updateMeteo(meteoOK: Meteo) -> MeteoComponents {
        let meteoVar = MeteoComponents(
            countryMeteo: meteoOK.query.results.channel.description,
            descriptionMeteo: meteoOK.query.results.channel.item.condition.text,
            dateMeteo: meteoOK.query.results.channel.lastBuildDate,
            tempMeteo: meteoOK.query.results.channel.item.condition.temp)
        return meteoVar
    }
}


extension MeteoViewController: UITextFieldDelegate {
    //MARK: TEXTFIELD
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        countruTextField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        countruTextField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: ALERT
    private func alertTextIsEmpty() {
        let alert = UIAlertController(title: "Error", message: "Text Field Is Empty", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
