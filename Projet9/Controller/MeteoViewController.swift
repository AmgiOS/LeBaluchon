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
    var meteo: Meteo?
    var countries = ["NewYork", "Toulouse"]
    
    //MARK: OUTLETS
    @IBOutlet weak var countruTextField: UITextField!
    @IBOutlet weak var meteoTableView: UITableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        meteoData()
    }
    
    //MARK: IBACTION
    @IBAction func searchCountryButton(_ sender: UIButton) {
        guard let countrySearch = countruTextField.text, !countrySearch.isEmpty else {
            alertTextIsEmpty()
            return
        }
        countries.append(countrySearch)
        meteoService.getMeteo(country: countries) { (success, meteo) in
            if success {
                self.meteo = meteo
            } else {
                self.countries.removeLast()
                self.alertTextCountryIsNil()
            }
            self.meteoTableView.reloadData()
        }
    }
}

extension MeteoViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: TABLE VIEW
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meteoCell") as! MeteoViewCell
        let channel = meteo?.query.results.channel[indexPath.row]
        cell.channel = channel
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            countries.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            meteoTableView.reloadData()
        }
    }
}


extension MeteoViewController {
    //MARK: FUNCTIONS
    private func meteoData() {
        meteoService.getMeteo(country: countries) { (success, meteo) in
            if success {
                self.meteo = meteo
            } else {
                self.alertTextCountryIsNil()
            }
            self.meteoTableView.reloadData()
        }
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
    
    private func alertTextCountryIsNil() {
        let alert = UIAlertController(title: "Error", message: "This Country no exist", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
