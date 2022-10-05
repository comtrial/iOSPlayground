//
//  CoreDataStore.swift
//  CoreDataWithMVVM
//
//  Created by 최승원 on 2022/10/03.
//
import CoreData

enum StorageType {
    case persistent, inMemory
}

protocol CoreDataFetchResultsPublishing {
    var viewContext: NSManagedObjectContext { get }
    func publicher<T: NSManagedObject>(fetch request: NSFetchRequest<T>) -> CoreDataFetchResultsPublisher<T>
}

extension CoreDataFetchResultsPublishing {
    func publicher<T: NSManagedObject>(fetch request: NSFetchRequest<T>) -> CoreDataFetchResultsPublisher<T> {
        return CoreDataFetchResultsPublisher(request: request, context: viewContext)
    }
}

protocol CoreDataStoring: CoreDataFetchResultsPublishing {
    var viewContext: NSManagedObjectContext { get }
}


class CoreDataStore: CoreDataStoring {
    
    private let container: NSPersistentContainer
    
    static var `default`: CoreDataStoring = {
        return CoreDataStore(name: "CoreDataExample", in: .persistent)
    }()
    
    var viewContext: NSManagedObjectContext {
        return self.container.viewContext
    }
    
    init(name: String, in storageType: StorageType) {
        self.container = NSPersistentContainer(name: name)
        self.setupIfMemoryStorage(storageType)
        self.container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    private func setupIfMemoryStorage(_ storageType: StorageType) {
        if storageType  == .inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            self.container.persistentStoreDescriptions = [description]
        }
    }
}
