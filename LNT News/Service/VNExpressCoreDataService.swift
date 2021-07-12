//
//  VNExpressCoreDataService.swift
//  LNT News
//
//  Created by Luong Ngoc Thuyet on 12/07/2021.
//

import UIKit
import CoreData
typealias CoreDataInsert = (Bool) -> Void

class VNExpressCoreDataService {
    let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    
    private init() {
        let group = DispatchGroup()
        group.enter()
        DispatchQueue.main.async {
            self.privateContext.parent = MainController.context
            group.leave()
        }
        group.wait()
    }
    
    static let shared = VNExpressCoreDataService()
    
    func fetchAllBookmarkedItem() -> [VNExpressModel] {
        print("Fetch all thread \(Thread.current)")
        let fetchRequest: NSFetchRequest<VNExpressModel> = VNExpressModel.fetchRequest()

        fetchRequest.sortDescriptors = []
                
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: privateContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        
        return fetchedResultsController.fetchedObjects?.reversed() ?? []
    }
    
    
    func markBookmarkedItem(vnExpress: ItemVNExpress, completion: @escaping CoreDataInsert) {
        print("Mark Bookmark thread \(Thread.current)")
        let entity = NSEntityDescription.entity(forEntityName: "VNExpressModel", in: privateContext)!
   
        let newItem = NSManagedObject(entity: entity, insertInto: privateContext)
           
        
        newItem.setValue(vnExpress.title, forKeyPath: "title")
        newItem.setValue(vnExpress.itemDescription, forKeyPath: "itemDescription")
        newItem.setValue(vnExpress.pubDate, forKeyPath: "pubDate")
        newItem.setValue(vnExpress.link, forKeyPath: "link")
        newItem.setValue(vnExpress.guid, forKeyPath: "guid")
        newItem.setValue(vnExpress.comments, forKeyPath: "comments")
           
        do {
            try privateContext.save()
            privateContext.performAndWait {
                try! MainController.context.save()
            }
            completion(true)
        } catch _ as NSError {
            completion(false)
        }
    }
    
    func findBookmarkedItem(title: String) -> VNExpressModel? {
        print("find Bookmark thread \(Thread.current)")
        let fetchRequest: NSFetchRequest<VNExpressModel> = VNExpressModel.fetchRequest()

        fetchRequest.sortDescriptors = []
        fetchRequest.predicate = NSPredicate(format: "title = %@", title)
                
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: privateContext, sectionNameKeyPath: nil, cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
        
        if let objects = fetchedResultsController.fetchedObjects, objects.count > 0 {
            return objects[0]
        } else {
            return nil
        }
    }
    
    func unmarkBookmarkedItem(vnExpress: ItemVNExpress, completion: @escaping CoreDataInsert) {
        print("unmark Bookmark thread \(Thread.current)")
        let findItem = findBookmarkedItem(title: vnExpress.title)
        
        guard let entity = findItem else {
            return
        }
   
        privateContext.delete(entity)
        do {
            try privateContext.save()
            privateContext.performAndWait {
                try! MainController.context.save()
            }
            completion(true)
        } catch _ as NSError {
            completion(false)
        }
    }
    
    func unmarkBookmarkedItem(vnExpressModel: VNExpressModel, completion: @escaping CoreDataInsert) {
        print("unmark Bookmark thread \(Thread.current)")
   
        privateContext.delete(vnExpressModel)
        do {
            try privateContext.save()
            privateContext.performAndWait {
                try! MainController.context.save()
            }
            completion(true)
        } catch _ as NSError {
            completion(false)
        }
    }
}
