//
//  Journal.swift
//  MyJournals
//
//  Created by 典萱 高 on 2017/12/8.
//  Copyright © 2017年 LostRfounds. All rights reserved.
//

import Foundation

struct MyJournal {
    var journalID: UUID
    var image: Data?
    var title: String?
    var content: String?
    var created: Date
}
