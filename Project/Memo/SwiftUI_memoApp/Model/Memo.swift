//
//  Memo.swift
//  SwiftUI_memoApp
//
//  Created by jaekyung you on 2020/07/15.
//  Copyright © 2020 jaekyung you. All rights reserved.
//

import SwiftUI

class Memo: Identifiable, ObservableObject{
    
    /*
     identifiable: tableView , collectionView에 쉽게 data binding 가능
     ObservableObject: 반응형 UI
     */
    
    let id: UUID // identifiable이 요구하는 프로토콜, memo를 구분할 때 고유 number
    @Published var content: String // 메모 내용 저장, published로 정의하면 binding 되어있는 UI에 자동으로 update
    let writtenDate : Date // memo를 생성한 날짜
    
    // 세 가지 속성을 초기화하는 생성자
    init(id: UUID = UUID(), content: String, writtenDate: Date = Date()){
        self.id = id
        self.content = content
        self.writtenDate = writtenDate
    }
    
}

extension Memo: Equatable {
    static func == (lhs: Memo, rhs: Memo) -> Bool {
        return lhs.id == rhs.id
    }
}
