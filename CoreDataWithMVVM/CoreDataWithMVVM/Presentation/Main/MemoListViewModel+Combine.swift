import UIKit
import Combine
import CoreData
import SwiftUI

var bag: [AnyCancellable] = []


class MemoListViewModelWithCombine {
    let repository = CoreDataRepositoryWithCombine.shared
    
    @Published var meomoData: [MemoData] = []
    @Published var meomoDataCount: Int = 0
    @Published var errMsg: String?
    
    // MARK: 참조용
    var currentMemoData: [MemoData] = []
    var subscriber: Set<AnyCancellable> = .init()
    
    init() {
        loadMemoData()
    }
    
    func loadMemoData() {
        repository.fetchMemoData().sink{ completion in
            
            switch completion {
            case .failure(let error):
                print("err \(error)")
            case .finished:
                break
            }
        } receiveValue: { memoDatas in
            self.meomoData = memoDatas
            print(self.meomoData)
        }.store(in: &subscriber)
    }
    
    func createMemoData(memoText: String?) {
        repository.createMemoData(memoText: memoText).sink{ completion in
            
            switch completion {
            case .failure(let error):
                print("err \(error)")
                debugPrint("an error occurred \(error.localizedDescription)")
            case .finished:
                break
            }
        } receiveValue: { memoData in
            print(memoData)
            
        }
    }
    
    func updateMemoData() {
        print("called")
    }
}
