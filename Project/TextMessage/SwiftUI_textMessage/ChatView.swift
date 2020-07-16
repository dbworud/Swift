//
//  ContentView.swift
//  SwiftUI_textMessage
//
//  Created by jaekyung you on 2020/07/14.
//  Copyright © 2020 jaekyung you. All rights reserved.
//

import SwiftUI

struct ChatView: View {
    
    @State var text: String?
    @State var messages : [Message] = []
    
    var body: some View {
        ZStack {
             Color.background
               .edgesIgnoringSafeArea(.all)
             VStack(spacing: 0) {
               HStack(alignment: .center) {
                 TextInputView(text: $text, placeholder: "Message")
                   .cornerRadius(10)
                 Button(action: sendAction) {
                   Text("Send")
                 }
               }.padding()
               Divider()
               ScrollView {
                 VStack(alignment: .trailing, spacing: 16) {
                   ForEach(messages, id: \.id) {
                     self.viewMessage(text: $0.text)
                   }
                 }.padding(.top, 16)
                 .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
               }.edgesIgnoringSafeArea(.bottom)
             }
           }
        
        /*
        ZStack{
            
            Color.gray.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0){
                HStack{
                    TextInputView(text: $text, placeholder: "Message")
                        .cornerRadius(10)
                    Button(action: sendAction){
                        Text("Send")
                    }
                }.padding()
                Divider()
                ScrollView{
                    VStack(alignment: .trailing, spacing: 16){
                        ForEach(messages, id: \.id){
                            self.viewMessage(text: $0.text)
                        }
                    }.padding(.top, 16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .trailing)
                }.edgesIgnoringSafeArea(.bottom)
            }
        }*/
        
    }
    
    
    struct Message{
        let id = UUID()
        let text: String
    }
    
    // 보내기
    func sendAction(){
        guard let text = text, !text.isEmpty else { return }
        
        let newMessage = Message(text: text)
        messages.insert(newMessage, at: 0) // 새로운 메세지를 맨 위에 넣기
        self.text = nil
        UIApplication.shared.windows.forEach{ $0.endEditing(true)}
        
    }
    
    // 보기
    func viewMessage(text: String) -> some View {
        return Text(text)
            .foregroundColor(Color.white)
            .padding(.all, 12)
            .background(Color.green)
            .cornerRadius(14)
            .padding(.trailing, 12)
            .padding(.leading, 32)
            
    }
}

#if DEBUG
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
#endif
