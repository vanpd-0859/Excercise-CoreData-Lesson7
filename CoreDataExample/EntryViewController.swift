//
//  EntryViewController.swift
//  CoreDataExample
//
//  Created by Phan Dinh Van on 3/15/19.
//  Copyright © 2019 Phan Dinh Van. All rights reserved.
//

import UIKit
import CoreData

class EntryViewController: UIViewController {

    @IBOutlet weak var txvEntry: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txvEntry.delegate = self
        txvEntry.textColor = UIColor.lightGray
    }
    
    @IBAction func clickCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickAdd(_ sender: Any) {
        guard let entryContent = txvEntry.text else {
            return
        }
        
        if entryContent.isEmpty || entryContent == "Type anything..." {
            let alert = UIAlertController(title: "Notification", message: "You left the content emply!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let entry = NSEntityDescription.insertNewObject(forEntityName: "Entry", into: context)
            entry.setValue(txvEntry.text, forKey: "content")
            do {
                try context.save()
                self.dismiss(animated: true, completion: nil)
            } catch {
                let alert = UIAlertController(title: "Notification", message: "Occur an error while saving!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
extension EntryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        if (textView.text == "Type anything..." && textView.textColor == .lightGray)
        {
            textView.text = ""
            textView.textColor = .black
        }
        textView.becomeFirstResponder() //Optional
    }
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        if (textView.text == "")
        {
            textView.text = "Type anything..."
            textView.textColor = .lightGray
        }
        textView.resignFirstResponder()
    }
}
