//
//  MemoData+CoreDataProperties.swift
//  CoreDataWithMVVM
//
//  Created by 최승원 on 2022/09/24.
//
//

import Foundation
import CoreData


extension MemoData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemoData> {
        return NSFetchRequest<MemoData>(entityName: "MemoData")
    }

    @NSManaged public var text: String?
    @NSManaged public var date: Date?
    
    // MARK: to deal with date as String
    var dateString: String? {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let date = self.date else { return "" }
        let savedDateString = myFormatter.string(from: date)
        return savedDateString
    }
}

extension MemoData : Identifiable {

}
