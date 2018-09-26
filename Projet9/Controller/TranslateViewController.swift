//
//  TranslateViewController.swift
//  Projet 9
//
//  Created by Amg on 23/08/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController, UITextFieldDelegate {
    
    private let translateService = TranslateService()
    private var language = [String]()
    @IBOutlet weak var toTranslateTextView: UITextView!
    @IBOutlet weak var translatedFinish: UITextView!
    @IBOutlet weak var inLanguagePickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var translateButtonTaped: UIButton!
     
    override func viewDidLoad() {
     super.viewDidLoad()
          updateLanguages()
    }
}

extension TranslateViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
     return language.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return language[row]
    }
}

extension TranslateViewController {
     @IBAction func translateButtonTapped(_ sender: UIButton) {
          guard let text = toTranslateTextView.text else {return}
          if text.isEmpty {
               errorTextIsEmpty()
          }
          let target = language[inLanguagePickerView.selectedRow(inComponent: 0)]
          toggleActivityIndicator(shown: true)
               translateService.getTranslate(text: text, target: target) { (success, translates) in
                    self.toggleActivityIndicator(shown: false)
                    if success, let translate = translates {
                         self.activityIndicator.isHidden = true
                         self.update(translate: translate)
                    } else {
                    self.ErrorAlertAction()
               }
          }
     }
     
     private func update(translate: DataTranslate) {
     translatedFinish.text = translate.data.translations[0].translatedText
    }
    
     private func updateLanguages() {
          toTranslateTextView.layer.cornerRadius = 10
          translatedFinish.layer.cornerRadius = 10
          translateService.getLanguages { (data) in
               if let data = data {
                    self.language = data
                    self.inLanguagePickerView.dataSource = self
                    self.inLanguagePickerView.delegate = self
               }
          }
     }
}

extension TranslateViewController {
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          toTranslateTextView.resignFirstResponder()
          return true
     }
     
     private func toggleActivityIndicator(shown: Bool) {
          activityIndicator.isHidden = !shown
          translateButtonTaped.isHidden = shown
     }
     
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          self.view.endEditing(true)
     }
     
     private func ErrorAlertAction() {
          let alert = UIAlertController(title: "Error", message: "The Translation download error", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
          self.present(alert, animated: true, completion: nil)
     }
     
     private func errorTextIsEmpty() {
          let alert = UIAlertController(title: "Error", message: "Translate Text is Empty", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
          self.present(alert, animated: true, completion: nil)
     }

}
