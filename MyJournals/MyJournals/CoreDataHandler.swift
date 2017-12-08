//
//  CoreDataHandler.swift
//  MyJournals
//
//  Created by 典萱 高 on 2017/12/8.
//  Copyright © 2017年 LostRfounds. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHandler: NSObject {
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

    public class func saveObject(journalTitle: String?, journalContent: String?, image: UIImage?) {
        let journalContext = getContext()
        let newJournal = Journal(context: journalContext)

        newJournal.journalID = UUID()
        newJournal.title = journalTitle
        newJournal.content = journalContent
        if let photoImage = image {
            guard let imageData = UIImageJPEGRepresentation(photoImage, 1) else {
                // handle failed conversion
                print("jpg error")
                return
            }
            newJournal.image = imageData
        }

        newJournal.created = Date()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        appDelegate.saveContext()
    }

    public func fetchJournals() -> [Journal]? {
        let journalContext = CoreDataHandler.getContext()
        var journals: [Journal]? = nil
        let fetchRequest: NSFetchRequest<Journal> = Journal.fetchRequest()
        do {
            journals = try journalContext.fetch(fetchRequest)
            return journals
        } catch let error {
            print("fetchJournals error: \(error)")
            return nil
        }
    }

    public func fetchJournalWith(journalID: UUID) -> [Journal]? {
        let journalContext = CoreDataHandler.getContext
        var journals: [Journal]? = nil
        let fetchRequest: NSFetchRequest<Journal> = Journal.fetchRequest()

        let predicate = NSPredicate(format: "journalID == %@", journalID as CVarArg)
        fetchRequest.predicate = predicate
        do {
            journals = try journalContext().fetch(fetchRequest)
            return journals
        } catch let error {
            print("fetchJournal with \(journalID) error: \(error)")
            return nil
        }
    }

    public func updateJournalWith(journalID: UUID,
                                  journalTitle: String?,
                                  journalContent: String?,
                                  image: UIImage?
    ) {
        let journalContext = CoreDataHandler.getContext
        var journals: [Journal]? = nil
        let fetchRequest: NSFetchRequest<Journal> = Journal.fetchRequest()

        let predicate = NSPredicate(format: "journalID == %@", journalID as CVarArg)
        fetchRequest.predicate = predicate
        do {
            journals = try journalContext().fetch(fetchRequest)
            guard let myJournals = journals else { return }
            if myJournals.count > 0{
                myJournals[0].title = journalTitle
                myJournals[0].content = journalContent
                if let photoImage = image {
                    guard let imageData = UIImageJPEGRepresentation(photoImage, 1) else {
                        // handle failed conversion
                        print("jpg error")
                        return
                    }
                    myJournals[0].image = imageData
                }

                let appDelegate = UIApplication.shared.delegate as! AppDelegate

                appDelegate.saveContext()
            }
        } catch let error {
            print("updateJournal with \(journalID) error: \(error)")
        }
    }





}

