//
//  DetailScene.swift
//  SwiftUI_memoApp
//
//  Created by jaekyung you on 2020/07/16.
//  Copyright © 2020 jaekyung you. All rights reserved.
//

import SwiftUI

struct DetailScene: View {
    
    @ObservedObject var memo: Memo //이전 화면에서 전달한 메모 속성을 저장
    @EnvironmentObject var store: MemoStore // memoStore를 주입할 속성
    @EnvironmentObject var formatter: DateFormatter // 날짜를 주입할 속성
    
    @State private var showEditSheet = false // 분리 속성 필요
    @State private var showDeleteAlert = false // 삭제 경고알림창
    
    @Environment(\.presentationMode) var presentationMode // 화면 전환을 관리하는 객체
    
    var body: some View {
        VStack{
            ScrollView{
                VStack{
                    HStack {
                        Text(self.memo.content)
                            .padding()
                        
                        Spacer() // 왼쪽 정렬
                    }
                    
                    Text("\(self.memo.writtenDate, formatter : formatter)")
                        .padding()
                        .font(.footnote)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
            }
            HStack{
                Button(action: {
                    // 경고창을 먼저 띄워주고 삭제
                    self.showDeleteAlert.toggle()
                    
                }){
                    Image(systemName: "trash")
                        .foregroundColor(Color.red)
                }
                .padding()
                .alert(isPresented: $showDeleteAlert, content: {
                    Alert(title: Text("삭제 경고"), message: Text("삭제하시겠습니까?"), primaryButton: .destructive(Text("삭제"), action: {
                        self.store.delete(memo: self.memo)
                        self.presentationMode.wrappedValue.dismiss() // 이전화면으로 전환
                    }), secondaryButton: .cancel() )
                })
                // 메모가 삭제되면 목록 화면(MemoListScene)으로 돌아가야함 
                
                Spacer()
                
                Button(action: {
                    // 편집 화면을 모달 방식으로
                    self.showEditSheet.toggle()
                    
                }){
                    Image(systemName: "square.and.pencil")
                }.padding()
                .sheet(isPresented: $showEditSheet, content: {
                    ComposeScene(showComposer: self.$showEditSheet, memo: self.memo)
                    // 편집할 메모도 함께 전달
                    .environmentObject(self.store)
                    .environmentObject(KeyboardObserver())
                    
                })
            }
            .padding(.leading)
            .padding(.trailing) // 양쪽에 기본 여백 추가
        }
    .navigationBarTitle("메모 보기")
    }
}

struct DetailScene_Previews: PreviewProvider {
    static var previews: some View {
        DetailScene(memo: Memo(content: "Memo Content"))
            .environmentObject(MemoStore())
            .environmentObject(DateFormatter.memoDateFormatter)
        
    }
}
