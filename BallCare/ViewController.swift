//
//  ViewController.swift
//  BallCare
//
//  Created by 剱物蒼太 on 2018/10/01.
//  Copyright © 2018年 剱物蒼太. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var existballsLabel: UILabel!
    @IBOutlet var unopenballsLabel: UILabel!
    @IBOutlet var lostballsLabel: UILabel!
    let defaults = UserDefaults.standard
    var existballs: Int!
    var unopenballs: Int!
    var lostballs: Int!
    var addCount: Int!
    var throwCount: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        existballs = defaults.integer(forKey: "existballs")
        lostballs = defaults.integer(forKey: "lostballs")
        unopenballs = defaults.integer(forKey: "unopenballs")
        
        existballsLabel.text = String(existballs)
        unopenballsLabel.text = String(unopenballs)
        lostballsLabel.text = String(lostballs)
        self.reload()
    }
    
    @IBAction func toUsingBalls() {
        let storyboard: UIStoryboard = self.storyboard!
        let usingBalls = storyboard.instantiateViewController(withIdentifier: "usingBalls")
        self.present(usingBalls, animated: true, completion: nil)
    }
    
    @IBAction func reloadButton() {
        self.reload()
    }
    
    func reload() {
        existballs = defaults.integer(forKey: "existballs")
        lostballs = defaults.integer(forKey: "lostballs")
        unopenballs = defaults.integer(forKey: "unopenballs")
        existballsLabel.text = String(existballs)
        unopenballsLabel.text = String(unopenballs)
        lostballsLabel.text = String(lostballs)
    }
    
    @IBAction func addBalls() {
        let addAlert = UIAlertController(title: "未開封ボール追加", message: "何個追加しますか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            if let textFields = addAlert.textFields {
                for textField in textFields {
                    print(textField.text!)
                    self.addCount = Int(textField.text!)!
                    self.unopenballs = self.unopenballs + self.addCount
                    self.defaults.set(self.existballs, forKey: "existballs")
                    self.defaults.set(self.lostballs, forKey: "lostballs")
                    self.defaults.set(self.unopenballs, forKey: "unopenballs")
                    self.reload()
                }
            }
        }
        addAlert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        addAlert.addAction(cancelAction)
        addAlert.addTextField { (textField: UITextField!) in
            textField.keyboardType = UIKeyboardType.numberPad
        }
        self.present(addAlert, animated: true, completion: nil)
    }
    
    @IBAction func throwawayBalls() {
        let throwawayAlert = UIAlertController(title: "ボール破棄", message: "何個捨てますか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            if let textFields = throwawayAlert.textFields {
                for textField in textFields {
                    print(textField.text!)
                    self.throwCount = Int(textField.text!)!
                    self.existballs = self.existballs - self.throwCount
                    self.defaults.set(self.existballs, forKey: "existballs")
                    self.defaults.set(self.lostballs, forKey: "lostballs")
                    self.defaults.set(self.unopenballs, forKey: "unopenballs")
                    self.reload()
                }
            }
        }
        throwawayAlert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        throwawayAlert.addAction(cancelAction)
        throwawayAlert.addTextField { (textField: UITextField!) in
            textField.keyboardType = UIKeyboardType.numberPad
        }
        self.present(throwawayAlert, animated: true, completion: nil)
    }
    
    @IBAction func reset() {
        
    }
    
    func adjustexistballs() {
        let adjustAlert = UIAlertController(title: "変更", message: "使用中ボール数を変更しますか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "はい", style: .default) { (action: UIAlertAction) in
            
        }
        adjustAlert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        adjustAlert.addAction(cancelAction)
        self.present(adjustAlert, animated: true, completion: nil)
    }
    
    func adjustlostballs() {
        let adjustAlert = UIAlertController(title: "変更", message: "ロストボール数を変更しますか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "はい", style: .default) { (action: UIAlertAction) in
            
        }
        adjustAlert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        adjustAlert.addAction(cancelAction)
        self.present(adjustAlert, animated: true, completion: nil)
    }
    
    func adjustunopenballs() {
        let adjustAlert = UIAlertController(title: "変更", message: "未開封ボール数を変更しますか？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "はい", style: .default) { (action: UIAlertAction) in
            
        }
        adjustAlert.addAction(okAction)
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)
        adjustAlert.addAction(cancelAction)
        self.present(adjustAlert, animated: true, completion: nil)
    }


}

