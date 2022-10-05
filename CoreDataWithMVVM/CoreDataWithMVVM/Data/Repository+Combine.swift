
import UIKit
import CoreData
import Combine

// TODO: AnyPublisher<> 에 대한 정리


final class CoreDataRepositoryWithCombine {
    
    static let shared = CoreDataRepositoryWithCombine()
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "MemoData"
    
    
    // MARK: - [Read]
    func fetchMemoData() -> AnyPublisher<[MemoData], Error> {
//        var memoList: [MemoData] = []
        
        Deferred { [context] in
            Future { promise in
                context?.perform {
                    let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
                    let dataOrder = NSSortDescriptor(key: "date", ascending: false)
                    request.sortDescriptors = [dataOrder]
                    
                    do {
                        let results = try context?.fetch(request) as! [MemoData]
                        promise(.success(results))
                    } catch {
                        
                        promise(.failure(error))
                    }
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    // MARK: - [Create]
    func createMemoData(memoText: String?) -> AnyPublisher<MemoData, Error> {
        Deferred { [context] in
            Future  { promise in
                context?.perform {
                    if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context!) {

                        if let memoData = NSManagedObject(entity: entity, insertInto: context) as? MemoData {
                            memoData.text = memoText
                            memoData.date = Date()

                            if context!.hasChanges {
                                do {
                                    try context!.save()
                                    promise(.success(memoData))
                                } catch {
                                    promise(.failure(error))
                                }
                            }
                        }


                    }

                }
            }
        }
        .eraseToAnyPublisher()
    }
    
//        // MARK: - [Create]
//        func createMemoData(memoText: String?, completion: @escaping () -> Void) {
//
//            // check context is valid
//            if let context = context {
//
//                // 엔티티의 형태 파악
//                if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
//
//                    // 임시 저장소에 올라갈 객체 생성 (NSManagedObject ===> ToDoData)
//                    if let memoData = NSManagedObject(entity: entity, insertInto: context) as? MemoData {
//
//                        // MARK: data 할당
//                        memoData.text = memoText
//                        memoData.date = Date()
//
//                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
//                        if context.hasChanges {
//                            do {
//                                try context.save()
//                                completion()
//                            } catch {
//                                print(error)
//                                completion()
//                            }
//                        }
//                    }
//                }
//            }
//            completion()
//        }
//
    }

            


