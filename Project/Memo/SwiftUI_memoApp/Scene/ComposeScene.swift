//
//  ComposeScene.swift
//  SwiftUI_memoApp
//
//  Created by jaekyung you on 2020/07/15.
//  Copyright © 2020 jaekyung you. All rights reserved.
//

import SwiftUI

struct ComposeScene: View {
    
    @EnvironmentObject var store: MemoStore
    @EnvironmentObject var keyboard: KeyboardObserver// KeyboardObserver 주입 속성
    @State private var content: String = ""
     
    @Binding var showComposer: Bool
    
    // 메모 편집 기능: memo가 전달되면 편집기능 혹은 memo가 없으면 새로 쓰기
    var memo: Memo? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                // content속성과 TextField가 binding되어 TextField에 저장된 값이 content에 자동을 반영
                TextView(text: $content) // SwiftUI에서는 기본적으로 중앙에 배치됨
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.bottom, keyboard.context.height)
                    .animation(.easeInOut(duration: keyboard.context.animationDuration))
                    .background(Color.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarTitle(memo != nil ? "메모 편집" : "새 메모", displayMode: .inline)
            .navigationBarItems(leading: DismissButton(show: $showComposer), trailing: SaveButton(show: $showComposer, content: $content, memo: memo))}
            // binding된 내용을 전달할 때 '$'
        .onAppear{
            // 화면이 표시되는 시점에서 초기화 구현
            self.content = self.memo?.content ?? "" // 없으면 빈 문자열 출력
        }
    } 
}

// 해당 버튼은 이 파일 내에서만 사용하므로 따로 파일을 만들지 않고 fileprivate으로 정의
fileprivate struct DismissButton: View {
    @Binding var show: Bool
    
    var body: some View {
        Button(action: {
            self.show = false
        }){
            Text("취소")
        }
    }
}

// 해당 버튼은 이 파일 내에서만 사용하므로 따로 파일을 만들지 않고 fileprivate으로 정의
fileprivate struct SaveButton: View {
    @Binding var show: Bool
    
    @EnvironmentObject var store: MemoStore
    @Binding var content: String // 새로 쓴 메모 내용
    
    var memo: Memo? = nil
    
    var body: some View {
        Button(action: {
            
            if let memo = self.memo {
                // memo가 전달되었다면 편집 모드이므로 update method
                self.store.update(memo: memo, content: self.content)
            } else {
                // 새로운 메모 쓰기. 입력한 메모 저장
                self.store.insert(memo: self.content) // store가 초기화되어있지 않아 compile error
            }
            self.show = false
        }){
            Text("저장")
        }
    }
}

struct ComposeScene_Previews: PreviewProvider {
    static var previews: some View {
        ComposeScene(showComposer: .constant(false)) //전달할 수 있는 속성이 없을 경우 .constan
        .environmentObject(MemoStore())
        .environmentObject(KeyboardObserver())
    }
}
