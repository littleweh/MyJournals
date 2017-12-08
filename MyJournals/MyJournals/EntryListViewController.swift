//
//  ViewController.swift
//  MyJournals
//
//  Created by 典萱 高 on 2017/12/8.
//  Copyright © 2017年 LostRfounds. All rights reserved.
//

import UIKit

class EntryListViewController: UIViewController {
    let cellID = "EntryTableViewCell"

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
        return 5
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = entryTableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as? EntryTableViewCell
        else { fatalError() }
        return cell
    }


}

