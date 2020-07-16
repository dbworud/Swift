//
//  String.swift
//  SwiftUI_textMessage
//
//  Created by jaekyung you on 2020/07/14.
//  Copyright © 2020 jaekyung you. All rights reserved.
//

import SwiftUI

extension Optional where Wrapped == String {
    
    var orEmpty: String{
        self ?? ""
    }
}
