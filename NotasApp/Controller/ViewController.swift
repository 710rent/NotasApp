//
//  ViewController.swift
//  NotasApp
//
//  Created by Florent Tino on 16/07/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tblNotes: UITableView!
    
    var notes: [NoteEntitty] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notas"
        tblNotes.dataSource = self
        tblNotes.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        notes = CoreDataHelper.shared.GetNotes()
        tblNotes.reloadData()
        
    }
    
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
}


// MARK: - UITableViewDataSource & Delegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = note.title
        content.secondaryText = formattedDate(note.date!)
        cell.contentConfiguration = content
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = FormNotas()
        detailVC.noteToEdit = notes[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let noteToDelete = notes[indexPath.row]
            
            CoreDataHelper.shared.RemoveNote(note: noteToDelete)
            notes.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
