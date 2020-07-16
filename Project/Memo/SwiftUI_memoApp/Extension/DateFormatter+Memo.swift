 //
//  DateFormatter+Memo.swift
//  SwiftUI_memoApp
//
//  Created by jaekyung you on 2020/07/15.
//  Copyright © 2020 jaekyung you. All rights reserved.
//

import Foundation

 extension DateFormatter {
    static let memoDateFormatter: DateFormatter = {
       let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        f.locale = Locale(identifier: "Ko_kr ")
        return f
    }()
 }

 extension DateFormatter : ObservableObject {
    
 }
