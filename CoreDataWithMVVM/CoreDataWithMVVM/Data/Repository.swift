//
//  Repository.swift
//  CoreDataWithMVVM
//
//  Created by 최승원 on 2022/09/24.
//
import UIKit
import CoreData
import Combine

// TODO: AnyPublisher<> 에 대한 정리


final class CoreDataRepository {
    
    static let shared = CoreDataRepository()
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "MemoData"
    
    
    // MARK: - [Read]
    func fetchMemoData() -> [MemoData] {
 
            var memoList: [MemoData] = []
            
            if let context = context {
                // 요청서 생성
                let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
                // 요청서에 대한 추가 조건 생성
                let dataOrder = NSSortDescriptor(key: "date", ascending: false)
                request.sortDescriptors = [dataOrder]
                
                do {
                    // fetch method 를 통한  data fetching
                    if let fetchMemoList = try context.fetch(request) as? [MemoData] {
                        memoList = fetchMemoList
                    }
                } catch {
                    print("fail to fetch data")
                }
            }
            
            
            return memoList
        }
    
    // MARK: - [Create]
    func createMemoData(memoText: String?, completion: @escaping () -> Void) {
        
        // check context is valid
        if let context = context {
            
            // 엔티티의 형태 파악
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                
                // 임시 저장소에 올라갈 객체 생성 (NSManagedObject ===> ToDoData)
                if let memoData = NSManagedObject(entity: entity, insertInto: context) as? MemoData {
                    
                    // MARK: data 할당
                    memoData.text = memoText
                    memoData.date = Date()
                    
                    //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
                    if context.hasChanges {
                        do {
                            try context.save()
                            completion()
                        } catch {
                            print(error)
                            completion()
                        }
                    }
                }
            }
        }
        completion()
    }
    
}

