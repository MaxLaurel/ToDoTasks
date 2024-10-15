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
    
    private struct Regex {
        static var password = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,25}$"
        static var email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
    
      func isValidated(validityType: ValidityType) -> Bool {
        var regex = ""
        
        if validityType == .email {
            regex = Regex.email
        } else if validityType == .password {
            regex = Regex.password
        }
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
        }
    }

