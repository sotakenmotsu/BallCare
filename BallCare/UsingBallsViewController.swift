//
//  UsingBallsViewController.swift
//  BallCare
//
//  Created by 剱物蒼太 on 2018/10/01.
//  Copyright © 2018年 剱物蒼太. All rights reserved.
//

import UIKit

class UsingBallsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet var openingBallsTextField: UITextField!
    @IBOutlet var existBallsTextField: UITextField!
    @IBOutlet var lostBallsTextField: UITextField!
    var openingPickerView: UIPickerView = UIPickerView()
    var usedPickerView: UIPickerView = UIPickerView()
    var lostPickerView: UIPickerView = UIPickerView()
    let balls = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]
    @IBOutlet var nameTextField: UITextField!
    var openingCount: Int!
    var usedCount: Int!
    var lostCount: Int!
    var unopenballs: Int!
    var existballs: Int!
    var lostballs: Int!
    let defaults = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        openingPickerView.dataSource = self
        openingPickerView.delegate = self
        usedPickerView.dataSource = self
        usedPickerView.delegate = self
        lostPickerView.dataSource = self
        lostPickerView.delegate = self
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(UsingBallsViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(UsingBallsViewController.cancel))
        toolbar.setItems([doneItem,cancelItem], animated: true)
        self.openingBallsTextField.inputView = openingPickerView
        self.openingBallsTextField.inputAccessoryView = toolbar
        self.existBallsTextField.inputView = usedPickerView
        self.existBallsTextField.inputAccessoryView = toolbar
        self.lostBallsTextField.inputView = lostPickerView
        self.lostBallsTextField.inputAccessoryView = toolbar
        unopenballs = defaults.integer(forKey: "unopenballs")
        existballs = defaults.integer(forKey: "existballs")
        lostballs = defaults.integer(forKey: "lostballs")

        // Do any additional setup after loading the view.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return balls.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(balls[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == usedPickerView {
            self.existBallsTextField.text = String(balls[row])
            self.usedCount = balls[row]
        } else if pickerView == lostPickerView {
            self.lostBallsTextField.text = String(balls[row])
            self.lostCount = balls[row]
        } else {
            self.openingBallsTextField.text = String(balls[row])
            self.openingCount = balls[row]
        }
    }
    
    @objc func done() {
        self.openingBallsTextField.endEditing(true)
        self.existBallsTextField.endEditing(true)
        self.lostBallsTextField.endEditing(true)
    }
    
    @objc func cancel() {
        self.openingBallsTextField.text = ""
        self.existBallsTextField.text = ""
        self.lostBallsTextField.text = ""
        self.openingBallsTextField.endEditing(true)
        self.existBallsTextField.endEditing(true)
        self.lostBallsTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func ballComplete() {
        if existBallsTextField.text == nil || existBallsTextField.text == "" {
            self.showErrorAlert()
        } else if lostBallsTextField.text == nil || lostBallsTextField.text == "" {
            self.showErrorAlert()
        } else if openingBallsTextField.text == nil || openingBallsTextField.text == "" {
            self.showErrorAlert()
        } else {
            self.showCompleteAlert()
        }
    }
    
    func showErrorAlert() {
        let errorAlert = UIAlertController(title: "未完了", message: "入力していない項目があります", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            
        }
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    func showCompleteAlert() {
        let completeAlert = UIAlertController(title: "内容確認", message: "開けたボール：\(openingBallsTextField.text!)個　使ったボール：\(existBallsTextField.text!)個 なくしたボール：\(lostBallsTextField.text!)個", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            self.unopenballs = self.unopenballs - self.openingCount
            self.existballs = self.existballs + self.openingCount
            self.existballs = self.existballs - self.lostCount
            self.lostballs = self.lostballs + self.lostCount
            self.defaults.set(self.unopenballs, forKey: "unopenballs")
            self.defaults.set(self.existballs, forKey: "existballs")
            self.defaults.set(self.lostballs, forKey: "lostballs")
            self.dismiss(animated: true, completion: nil)
        }
        completeAlert.addAction(ok)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        completeAlert.addAction(cancelAction)
        self.present(completeAlert, animated: true, completion: nil)
    }

}
