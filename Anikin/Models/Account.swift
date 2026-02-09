//
//  Account.swift
//  Anikin
//
//  Created by Abhinav Prasad Yasaswi on 1/21/26.
//

import Foundation
import SwiftData

@Model
final class AccountDraft {
    var username: String = ""
    var email: String = ""
    var birthday: Date = Date()
    var theriotype: Theriotype? // From the previous screen
    
    init(username: String, email: String, birthday: Date, theriotype: Theriotype?) {
        self.username = username
        self.email = email
        self.birthday = birthday
        self.theriotype = theriotype
    }
}
