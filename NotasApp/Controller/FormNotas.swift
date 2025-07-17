//
//  FormNotas.swift
//  NotasApp
//
//  Created by Florent Tino on 16/07/25.
//

import UIKit

class FormNotas: UIViewController {

    
    @IBOutlet weak var txrTitle: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    
    public var noteToEdit:NoteEntitty!
    
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        if noteToEdit != nil {
            txrTitle.text = noteToEdit.title
            txtDescription.text = noteToEdit.content
        }
    }

    
    @IBAction func OnSaveClick(_ sender: Any) {
         let title = txrTitle.text ?? ""
         let description = txtDescription.text ?? ""
        
        if title.isEmpty || description.isEmpty {
            print("Hay campos vacíos")
            return
        }
        
        activityIndicator.startAnimating()
        
        if noteToEdit != nil {
            noteToEdit.title = title
            noteToEdit.content = description
            CoreDataHelper.shared.saveContext()
        } else {
            CoreDataHelper.shared.AddNote(title: title, description: description)
        }
        
        activityIndicator.stopAnimating()
        navigationController?.popViewController(animated: true)
    }
    
}

