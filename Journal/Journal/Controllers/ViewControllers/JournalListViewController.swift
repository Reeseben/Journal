//
//  JournalListViewController.swift
//  Journal
//
//  Created by Ben Erekson on 7/20/21.
//

import UIKit

class JournalListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - IBOutlets
    @IBOutlet weak var journalTitleTextField: UITextField!
    @IBOutlet weak var journalListTableView: UITableView!
    @IBOutlet weak var createNewJournalButton: UIButton!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        JournalController.sharedInstance.loadFromPresistenceStore()
        journalListTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        journalListTableView.delegate = self
        journalListTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    @IBAction func createNewJournalButtonTapped(_ sender: Any) {
        guard let title = journalTitleTextField.text, !title.isEmpty else {return}
        JournalController.sharedInstance.createJournalWith(title: title)
        journalTitleTextField.text = ""
        journalListTableView.reloadData()
    }
    
    //MARK: - TableViewFunctions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JournalController.sharedInstance.journals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // bad v
        //let cell = UITableViewCell(style: .default, reuseIdentifier: "journalCell")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        // good ^
        
        cell.textLabel?.text = JournalController.sharedInstance.journals[indexPath.row].title
        cell.detailTextLabel?.text = "\(JournalController.sharedInstance.journals[indexPath.row].entries.count) Entries"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                
                let toDelete = JournalController.sharedInstance.journals[indexPath.row]
                JournalController.sharedInstance.delete(journal: toDelete)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showJournal"{
        guard let destination = segue.destination as? EntryListTableViewController,
              let indexPath = journalListTableView.indexPathForSelectedRow else {return}
            destination.journal = JournalController.sharedInstance.journals[indexPath.row]
        }
    }


}//End Of Class
