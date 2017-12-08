//
//  ViewController.swift
//  MyJournals
//
//  Created by 典萱 高 on 2017/12/8.
//  Copyright © 2017年 LostRfounds. All rights reserved.
//

import UIKit
import CoreData

class EntryListViewController: UIViewController {
    let cellID = "EntryTableViewCell"
    var journals: [Journal]? = nil {
        didSet {
            self.entryTableView.reloadData()
        }
    }

    @IBOutlet weak var entryTableView: UITableView!
    @IBOutlet weak var createNewJournalButton: UIButton!

    let coreDataHandler = CoreDataHandler()

    override func viewDidLoad() {
        super.viewDidLoad()

        entryTableView.delegate = self
        entryTableView.dataSource = self
        createNewJournalButton.addTarget(
            self,
            action: #selector(presentNewEntryViewController),
            for: .touchUpInside
        )

        journals = coreDataHandler.fetchJournals()



    }


    @objc func presentNewEntryViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EntryCreatingViewController") as! EntryCreatingViewController
        present(viewController, animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension EntryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let myJournals = journals else {return 0}
        return myJournals.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = entryTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? EntryTableViewCell
        else { fatalError() }

        if let myJournals = journals {
            if let imageData = myJournals[indexPath.row].image as? Data {
                let image = UIImage(data: imageData)
                cell.photoImageView.image = image
            }
            cell.titleLabel.text = myJournals[indexPath.row].title
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EntryCreatingViewController") as! EntryCreatingViewController
        let journalID = journals![indexPath.row].journalID
        viewController.journalID = journalID
        present(viewController, animated: true, completion: nil)

    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let deleteAlert = UIAlertController(
                title: NSLocalizedString("Delete Journal?", comment: ""),
                message: NSLocalizedString("Confirm to delete this Journal", comment: ""),
                preferredStyle: UIAlertControllerStyle.alert)

            deleteAlert.addAction(UIAlertAction(
                title: NSLocalizedString("Ok", comment: ""),
                style: .default,
                handler: { (action: UIAlertAction!) in
                    let journalID = self.journals![indexPath.row].journalID
                    self.coreDataHandler.deleteJournal(with: journalID!)
                    self.coreDataHandler.fetchJournals()
            }))

            deleteAlert.addAction(UIAlertAction(
                title: NSLocalizedString("Cancel", comment: ""),
                style: .cancel,
                handler: { (action: UIAlertAction!) in
            }))

            present(deleteAlert, animated: true, completion: nil)
        }
    }


}

