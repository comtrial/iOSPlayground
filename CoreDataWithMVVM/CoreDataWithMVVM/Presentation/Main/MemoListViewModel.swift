//
//  MemoListViewModel.swift
//  CoreDataWithMVVM
//
//  Created by 최승원 on 2022/09/24.
//

//import UIKit
//import Combine
//import CoreData
//
//class MemoListViewModel {
//    let repository = CoreDataRepository.shared
//    
//    @Published var meomoData: [MemoData] = []
//    @Published var errMsg: String?
//    // MARK: 참조용
//    var currentMemoData: [MemoData] = []
//
//    var subscriber: Set<AnyCancellable> = .init()
//    
//    
//    func loadMemoData() {
//        
//        // MARK: working as mvvm
//        self.meomoData = repository.fetchMemoData()
//        currentMemoData = self.meomoData
//    }
//    
//    func updateMemoData() {
//        
//    }
//}
