//
//  Validation.swift
//  ToDoTasks
//
//  Created by Максим on 12.05.2023.
//

import Foundation

extension String {
    
    enum ValidityType {
        case password
        case email
    }
    
    enum Regex: String {
        case password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,25}$"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
    
    func isValidated(validityType: ValidityType) -> Bool {
        var regex = ""
        
        switch validityType {
        case .email:
            regex = Regex.email.rawValue
        case .password:
            regex = Regex.password.rawValue
        }
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
        
    }
}
