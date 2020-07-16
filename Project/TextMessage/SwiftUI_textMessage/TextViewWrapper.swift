//
//  TextViewWrapper.swift
//  SwiftUI_textMessage
//
//  Created by jaekyung you on 2020/07/14.
//  Copyright © 2020 jaekyung you. All rights reserved.
//

import SwiftUI

struct TextViewWrapper: UIViewRepresentable {
    
    init(text: Binding<String?>, focused: Binding<Bool>, contentHeight: Binding<CGFloat>)
    {
        self._text = text
        self._focused = focused
        self._contentHeight = contentHeight
    }
    
    @Binding var text: String?
    @Binding var focused: Bool
    @Binding var contentHeight: CGFloat
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.font = .systemFont(ofSize: 16)
        textView.backgroundColor = .clear
        textView.autocorrectionType = .no
        
        return textView
        
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(text: $text, focused: $focused, contentHeight: $contentHeight)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        init(text: Binding<String?>, focused: Binding<Bool>, contentHeight: Binding<CGFloat>)
           {
               self._text = text
               self._focused = focused
               self._contentHeight = contentHeight
           }
        
        @Binding var text: String?
        @Binding var focused: Bool
        @Binding var contentHeight: CGFloat
        
        func textViewDidChange(_ textView: UITextView) {
            text = textView.text
            contentHeight = textView.contentSize.height
        }
        
        
        func textViewDidBeginEditing(_ textView: UITextView) {
            focused = true
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            focused = false
            contentHeight = text == nil ? 0 : textView.contentSize.height
        }
    }
   
}

#if DEBUG
struct TextViewWrapper_Previews: PreviewProvider {
    
    @State static var text: String?
    
    static var previews: some View {
        TextViewWrapper(text: $text, focused: .constant(false), contentHeight: .constant(0))
    }
}
#endif
