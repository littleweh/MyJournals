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

    override func viewDidLoad() {
        super.viewDidLoad()

        entryTableView.delegate = self
        entryTableView.dataSource = self
        createNewJournalButton.addTarget(
            self,
            action: #selector(presentNewEntryViewController),
            for: .touchUpInside
        )

        journals = showJournals()



    }

    func showJournals() -> [Journal]? {
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let journalObject = appDelegate.persistentContainer.viewContext
            let query: NSFetchRequest<Journal> = Journal.fetchRequest()

            do {
                let searchResult = try journalObject.fetch(query)
                if searchResult.count > 0 {
                    return searchResult
                } else {
                    return nil
                }
            } catch {
                print(error)
                return nil
            }
        } else {
            fatalError()
        }
    }


    @objc func presentNewEntryViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "EntryCreatingViewController") as UIViewController
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
        let viewController = storyboard.instantiateViewController(withIdentifier: "EntryCreatingViewController") as UIViewController
        present(viewController, animated: true, completion: nil)
    }


}

