//
//  EntryListTableViewController.swift
//  Journal
//
//  Created by Ben Erekson on 7/19/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    var journal: Journal?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addEntryButtonPressed(_ sender: Any) {
        
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return journal?.entries.count ?? 0
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                
                guard let journal = journal else {return}
                
                let entryToDelete = journal.entries[indexPath.row]
                EntryController.delete(entry: entryToDelete, journal: journal)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        guard let journal = journal else { return cell }
        
        cell.textLabel?.text = journal.entries[indexPath.row].title
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM/dd/yyyy"
        let dateString = formatter.string(from: journal.entries[indexPath.row].date)
        cell.detailTextLabel?.text = dateString
        return cell
    }

    
//MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EntryDetailViewController else {return}
            destination.journal = journal
        if segue.identifier == "entryShow" {
            
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let journal = journal else {return}
                destination.entry = journal.entries[indexPath.row]
        }
    }



}
