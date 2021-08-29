//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Ben Erekson on 7/19/21.
//

import UIKit

class EntryDetailViewController: UIViewController {

    var entry: Entry?
    var journal: Journal?
    
    //MARK: - IBOutlets
    @IBOutlet weak var titleTextFeild: UITextField!
    @IBOutlet weak var bodyTextView: UITextField!
    @IBOutlet weak var clearButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    @IBAction func clearButtonHandler(_ sender: Any) {
        titleTextFeild.text = ""
        bodyTextView.text = ""
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let entryTitle = titleTextFeild.text, !entryTitle.isEmpty else{return}
        guard let entryBody = bodyTextView.text, !entryBody.isEmpty else{return}
//if entry can be assigned to this new property then assign unwrapped to new entry and use it
        guard let journal = journal else {return}
        if let entry = entry {
            EntryController.updateEntry(entry: entry, newTitle: entryTitle, newBody: entryBody, journal: journal)
        } else{
            EntryController.createEntryWith(title: entryTitle, body: entryBody, journal: journal)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews(){
        guard let entry = entry else{return}
        titleTextFeild.text = entry.title
        bodyTextView.text = entry.text
    }
    
}
