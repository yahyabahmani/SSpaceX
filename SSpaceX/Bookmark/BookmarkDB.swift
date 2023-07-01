//
//  BookmarkDB.swift
//  SSpaceX
//
//  Created by Jabama on 7/1/23.
//

import Foundation
import UIKit
import CoreData
class BookmarkDB{
    static let shared = BookmarkDB()
    private var context:NSManagedObjectContext
    init() {
        self.context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    }
    func checkID(id:String,completion : @escaping(Bool) -> Void,errorCompletion : @escaping(Error?) -> Void) {
        do {
            let item = try context.fetch(Bookmark.fetchRequest())
            let firstIndex = item.firstIndex(where: {$0.id == id})
            firstIndex == nil ? completion(false) :  completion(true)
        }catch{
            errorCompletion(error)
        }
    }
    
    func deleteItem(id:String, completion : @escaping(Error?) -> Void){
      
//        context.delete(item)
        do {
            var fetch = try context.fetch(Bookmark.fetchRequest())
            let filterSelect = fetch.filter{($0.id == id)}
            for item in filterSelect {
                context.delete(item)
            }

            try context.save()
            completion(nil)
        }catch{
            completion(error)
        }
    }
    func createItem(id:String,completion : @escaping(Error?) -> Void){
        let newItem = Bookmark(context: self.context)
        newItem.id = id
        do {
            try context.save()
            completion(nil)
        }catch{
            completion(error)
        }
        
    }
}
