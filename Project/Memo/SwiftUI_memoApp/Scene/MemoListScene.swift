//
//  ContentView.swift
//  SwiftUI_memoApp
//
//  Created by jaekyung you on 2020/07/15.
//  Copyright © 2020 jaekyung you. All rights reserved.
//

import SwiftUI

struct MemoListScene: View {
    
    // 하나의 데이터를 여러 뷰에서 공유
    // custom 공유데이터, 자동으로 저장해줌
    @EnvironmentObject var store: MemoStore
    @EnvironmentObject var formatter: DateFormatter
    
    @State var showComposer: Bool = false // ComposeScene을 제어하기 위함
    
    var body: some View {
        
        NavigationView {
            
            List {
                ForEach(store.list){ memo in
                    NavigationLink(destination: DetailScene(memo: memo),
                    label: {
                            MemoCell(memo: memo)
                    })
                }
                .onDelete(perform: store.delete) // list에서 삭제시, onDelete.
                // 왼쪽으로 swipe하면 delete버튼이 나옴
                
            }
            .navigationBarTitle("내 메모")
            .navigationBarItems(trailing: CreateButton(show: $showComposer)) //값이 복사되는게 아니라 Binding이 저장. show속성을 바꾸면 Binding되어있는 showComposer속성이 바뀌게 됨
                .sheet(isPresented: $showComposer, content: {ComposeScene(showComposer: self.$showComposer)
                    .environmentObject(self.store)
                    .environmentObject(KeyboardObserver())
            })// showComposer=true이면, ComposeScene을 modal 방식으로 전달
        }
    }
}

struct MemoListScene_Previews: PreviewProvider {
    static var previews: some View {
        MemoListScene()
            .environmentObject(MemoStore())
            .environmentObject(DateFormatter.memoDateFormatter)
    }
}


fileprivate struct CreateButton: View {
    @Binding var show: Bool //다른 곳에 있는 속성을 바꿈
    
    var body: some View {
        Button(action: {
            self.show = true
        }){
            Image(systemName: "plus")
        }
    }
}
