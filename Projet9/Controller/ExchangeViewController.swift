//
//  ExchangeViewController.swift
//  Projet 9
//
//  Created by Amg on 23/08/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController {
    
    //MARK: VARIABLES
    private let deviceService = DeviceService()
    private var viewSymbols = [String]()
    
    //MARK: OUTLETS
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

extension ExchangeViewController:  UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK: PICKER VIEW
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

//MARK: IBACTION
extension ExchangeViewController {
    @IBAction func exchangeButtonTapped(_ sender: UIButton) {
        guard let text = amoutTextField.text else {return}
        toggleActivityIndicator(shown: true)
        deviceService.getDevice(Amount: text) { (success, device) in
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
        dismiss(animated: true)
        device.rates.forEach { (key, value) in
            displayDeviceTextView.text.append(contentsOf: "\(key):\(value)\n")
            if String(viewSymbols[inChangePickerView.selectedRow(inComponent: 0)]) == key && text != "" {
                resultLabel.isHidden = false
                guard let float = Double(text) else {return}
                let resultDouble = float * value
                let result = String(format: "%.2f", resultDouble)
                resultLabel.text = "\(result) \(String(viewSymbols[inChangePickerView.selectedRow(inComponent: 0)]))"
            }
        }
    }
    
    private func updateSymbols() {
        deviceService.getSymbols { (data) in
            if let data = data {
                let array = data.sorted(by: <)
                self.viewSymbols = array
                self.inChangePickerView.dataSource = self
                self.inChangePickerView.delegate = self
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        exchangeButton.isHidden = shown
    }
}

extension ExchangeViewController: UITextFieldDelegate {
    //MARK: TEXTFIELD
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        amoutTextField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        amoutTextField.text = ""
    }
    
    //MARK: ALERT
    private func ErrorAlertAction() {
        let alert = UIAlertController(title: "Error", message: "The Device download error", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

