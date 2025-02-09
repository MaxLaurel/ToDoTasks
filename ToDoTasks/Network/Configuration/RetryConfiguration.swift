//
//  RetryConfiguration.swift
//  ToDoTasks
//
//  Created by Максим on 09.10.2024.
//

import Foundation

protocol RetryConfigurable {
    func handleRetry()
}

 enum RetryPolicy: RetryConfigurable {
    
    case moderate
    case aggressive
    
   static var attempts = 0
    
    var retriesCount: Int {
        switch self {
        case .moderate: return 3
        case .aggressive: return 5
        }
    }
    
    var delay: TimeInterval {
        switch self {
        case .moderate: return 1.0
        case .aggressive: return 0.10
        }
    }
    
    func handleRetry() {
        if RetryPolicy.attempts < retriesCount {
            RetryPolicy.attempts += 1
            let nextDelay = delay * pow(2, Double(RetryPolicy.attempts))
            DispatchQueue.global().asyncAfter(deadline: .now() + nextDelay) {
            }
        } else {
           Log.info("Max attempts reached")
        }
        }
    }
