//
//  ExchangeViewController.swift
//  Projet 9
//
//  Created by Amg on 23/08/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {
    
    private var viewSymbols = [String]()
    @IBOutlet weak var amoutTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var exchangeButton: UIButton!
    @IBOutlet weak var inChangePickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var displayDeviceTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSymbols()
    }
}

extension ExchangeViewController:  UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewSymbols.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewSymbols[row]
    }
}

extension ExchangeViewController {
    
    @IBAction func exchangeButtonTapped(_ sender: UIButton) {
        guard let text = amoutTextField.text else {return}
        toggleActivityIndicator(shown: true)
        DeviceService.shared.getDevice(Amount: text) { (success, device) in
            self.toggleActivityIndicator(shown: false)
            if success, let device = device {
                self.activityIndicator.isHidden = true
                self.updateDevice(device: device)
            } else {
                self.ErrorAlertAction()
            }
        }
    }
    
    //MARK: FUNCTIONS
    private func updateDevice(device: Device) {
        guard let text = amoutTextField.text else {return}
        device.rates.forEach { (key, value) in
            displayDeviceTextView.text.append(contentsOf: "\(key):\(value)\n")
            if String(viewSymbols[inChangePickerView.selectedRow(inComponent: 0)]) == key && text != "" {
                resultLabel.isHidden = false
                guard let float = Double(text) else {return}
                let resultDouble = float * value
                let result = String(format: "%.2f", resultDouble)
                resultLabel.text = "\(result) \(String(viewSymbols[inChangePickerView.selectedRow(inComponent: 0)]))"
            } else {
                
            }
        }
    }
    
    private func updateSymbols() {
        DeviceService.shared.getSymbols { (data) in
            if let data = data {
                self.viewSymbols = data
                self.inChangePickerView.dataSource = self
                self.inChangePickerView.delegate = self
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        exchangeButton.isHidden = shown
    }
    
    private func ErrorAlertAction() {
        let alert = UIAlertController(title: "Error", message: "The Device download error", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
