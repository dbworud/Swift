//
//  MemoStore.swift
//  SwiftUI_memoApp
//
//  Created by jaekyung you on 2020/07/15.
//  Copyright © 2020 jaekyung you. All rights reserved.
//

import SwiftUI

// 메모 목록을 저장하는 클래스 구현

class MemoStore: ObservableObject {
    @Published var list: [Memo] //update될 때마다 binding되어있는 뷰에도 같이 업데이트
    
    init(){
        list = [
            Memo(content: "Jaekyung You 1"),
            Memo(content: "Jaekyung You 2"),
            Memo(content: "Jaekyung You 3")
        ]
    }
    
    
    // CRUD code (Create, Read, Update, Delete) 함수 구현
    func insert(memo: String){
        list.insert(Memo(content: memo), at: 0)
    }
    
    func update(memo: Memo?, content: String){
        guard let memo = memo else {return}
        memo.content = content
    }
    
    // delete method: 1. instance 받는 것 2. IndexSet 받는 것
    func delete(memo: Memo){
        DispatchQueue.main.async {
            self.list.removeAll{ $0 == memo}
        } // console창에 경고 메세지 없이 simulator run
    }
        
    func delete(set: IndexSet){
        for index in set {
             self.list.remove(at: index)
        }
    }
    
}
