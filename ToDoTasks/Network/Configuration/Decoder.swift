//
//  Decoder.swift
//  ToDoTasks
//
//  Created by Максим on 29.10.2024.
//

import Foundation

class Decoder {
    
   static private let shared = JSONDecoder()
    
    private init() {}
    
    static func decode<T: Decodable>(type: T.Type, from data: Data) -> Result<T, Error> {
        shared.keyDecodingStrategy = .convertFromSnakeCase//если будут приходить данные с сервера в формате снейккейс то метод автоматически конвертнет в кэмлкейс
        shared.dateDecodingStrategy = .iso8601// если в модели есть даты и с сервера будут приходить даты в формате например 2024-11-09T15:00:00Z (это формат iso8601) то будут конвертированы в формат Date для дальнейшей удобной работы с датами а не строками. Если формат другой то нужно писать кастомный декодер по примеру ниже

//        let dateformatter = DateFormatter()
//        dateformatter.dateFormat = "yyyy-MM-dd"
//        shared.dateDecodingStrategy = .formatted(dateformatter)
        do {
            let DecodedData = try Decoder.shared.decode(T.self, from: data)
            return .success(DecodedData)
        } catch {
            return .failure(error)
        }
    }
}
