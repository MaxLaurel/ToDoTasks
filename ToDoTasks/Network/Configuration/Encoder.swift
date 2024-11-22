//
//  Encoder.swift
//  ToDoTasks
//
//  Created by Максим on 09.11.2024.
//

import Foundation

class Encoder {
    
    static private let shared = JSONEncoder()
    
    private init() {}
    
    static func encode<T: Encodable>(object: T) -> Result<Data, Error> {
        do {
            shared.keyEncodingStrategy = .convertToSnakeCase // можно настроить стратегии для ключей
            shared.dateEncodingStrategy = .iso8601 // аналогичная стратегия для кодирования даты в формате ISO8601
            let encodedData = try shared.encode(object)
            return .success(encodedData)
        } catch {
            return .failure(error)
        }
    }
}
