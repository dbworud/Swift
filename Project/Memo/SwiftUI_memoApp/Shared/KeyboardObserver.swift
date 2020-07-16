//
//  KeyboardObserver.swift
//  SwiftUI_memoApp
//
//  Created by jaekyung you on 2020/07/16.
//  Copyright © 2020 jaekyung you. All rights reserved.
//

import UIKit
import Combine

class KeyboardObserver: ObservableObject {
    
    // animation 시간과 높이를 설정하는 구조체 선언
    struct Context {
        let animationDuration: TimeInterval
        let height: CGFloat
        
        // 키보드가 숨겨진 상태의 기본값을 type property로 저장
        static let hide = Self(animationDuration: 0.25, height: 0)
    }
    
    @Published var context = Context.hide
    private var cancellables = Set<AnyCancellable>() // 메모리 관리 속성
    
    // UIKit을 사용하지 않고 Observer와 Combine을 이용
    init(){
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        
        // 두 Publisher를 merge 연산자로 합침
        /*
         willshow, willhide의 notification이 전달되면,
         parse method 가 실행되고
         해당 method의 결과가 context 속성에 자동으로 저장
         keyboardObserver 객체가 사라지면 관련된 메모리가 자동을 정리된다.
         */
        
        willShow.merge(with: willHide)
            .compactMap(parse) // compactMap을 사용해서 context형식으로 변환
            .assign(to: \.context, on: self) //assign을 이용하여 context 속성에 바인딩
            .store(in: &cancellables)// 메모리 처리에 필요한 코드
    }
    
    func parse(notification: Notification) -> Context? {
        // optional context를 리턴
        // 키보드 높이를 꺼냄
        guard let userInfo = notification.userInfo else { return nil }
        
        let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets // safeAreaInset를 상수에 저장
        let animationDuration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
        // animation 시간을 상수에 저장
        
        var height: CGFloat = 0
        
        // userInfo dictionary에서 frame값을 꺼냄
        if let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let frame = value.cgRectValue
            
            // keyboard가 시작되는 시점
            if frame.origin.y < UIScreen.main.bounds.height {
                height = frame.height - (safeAreaInsets?.bottom ?? 0)// safeAreaInsets이 반영된 높이를 저장
            }
            
        }
        // 새로운 context return
        return Context(animationDuration: animationDuration, height: height)
    }
    
}
