//
//  KUIViewController.swift
//  Flash Chat iOS13
//
//  Created by Tehillah Kangamba on 2025-02-20.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import UIKit


class KUIViewController: UIViewController {

    @IBOutlet var bottomConstraintForKeyboard: NSLayoutConstraint!

    @IBOutlet weak var tableView: UITableView!
    
     var lengthMessageArr = 0
    
    @objc func keyboardWillShow(sender: NSNotification) {
        let i = sender.userInfo!
        let s: TimeInterval = (i[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        let k = (i[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        bottomConstraintForKeyboard.constant = k

        UIView.animate(withDuration: s) {
            self.view.layoutIfNeeded()
           // let indexPath = IndexPath(row: self.lengthMessageArr , section: 0)

          //  self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
           
        }
    }

    @objc func keyboardWillHide(sender: NSNotification) {
        let info = sender.userInfo!
        let s: TimeInterval = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        bottomConstraintForKeyboard.constant = 0
        UIView.animate(withDuration: s) { self.view.layoutIfNeeded() }
    }

    @objc func clearKeyboard() {
        view.endEditing(true)
    }

    func keyboardNotifications() {
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardNotifications()
        let t = UITapGestureRecognizer(target: self, action: #selector(clearKeyboard))
        view.addGestureRecognizer(t)
        t.cancelsTouchesInView = false
    }
}
