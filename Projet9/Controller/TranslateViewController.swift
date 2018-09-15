//
//  TranslateViewController.swift
//  Projet 9
//
//  Created by Amg on 23/08/2018.
//  Copyright © 2018 Amg-Industries. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {
    
    private var language: [String] = []
    @IBOutlet weak var toTranslateTextView: UITextView!
    @IBOutlet weak var translatedFinish: UILabel!
    @IBOutlet weak var inLanguagePickerView: UIPickerView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var translateButtonTaped: UIButton!
     
    override func viewDidLoad() {
     super.viewDidLoad()
     updateLanguages()
    }
     
     private func updateLanguages() {
          TranslateService.shared.getLanguages { (data) in
               if let data = data {
                    self.language = data
                    self.inLanguagePickerView.dataSource = self
                    self.inLanguagePickerView.delegate = self
               }
          }
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
          let target = language[inLanguagePickerView.selectedRow(inComponent: 0)]
          toggleActivityIndicator(shown: true)
               TranslateService.shared.getTranslate(text: text, target: target) { (success, translates) in
                    self.toggleActivityIndicator(shown: false)
                    if success, let translate = translates {
                         self.activityIndicator.isHidden = true
                         self.update(translate: translate)
                    } else {
                    self.ErrorAlertAction()
               }
          }
     }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        inLanguagePickerView.resignFirstResponder()
    }
    
     private func update(translate: DataTranslate) {
     translatedFinish.text = translate.data.translations[0].translatedText
    }
    
     private func ErrorAlertAction() {
          let alert = UIAlertController(title: "Error", message: "The Translation download error", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
          self.present(alert, animated: true, completion: nil)
     }
     
     private func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        translateButtonTaped.isHidden = shown
    }
}
