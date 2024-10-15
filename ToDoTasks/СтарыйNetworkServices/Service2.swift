//import Alamofire
//import Foundation
//
//class NetworkService {
//    
//    static let shared = NetworkService()
//    private init() {}
//    
//    func getData(url: String, completion: @escaping (Result<Welcome, NetworkErrors>) -> Void) {
//        AF.request(url, method: .get).validate().responseData { responseData in
//            switch responseData.result {
//            case .success(let successData):
//                print("мы получили дату до парсинга")
//                if let decodedData: Welcome = self.decode(from: successData) {
//                    completion(.success(decodedData))
//                    print("мы распарсили данные")
//                } else {
//                    completion(.failure(.parsingError))
//                }
//            case .failure(let AFerror):
//                switch responseData.response?.statusCode {
//                case 400:
//                    completion(.failure(.badRequest))
//                case 401:
//                    completion(.failure(.unauthorized))
//                case 403:
//                    completion(.failure(.forbidden))
//                case 404:
//                    completion(.failure(.notFound))
//                case 429:
//                    completion(.failure(.tooManyRequests))
//                case 500, 502, 503, 504:
//                    completion(.failure(.serverError))
//                default:
//                    completion(.failure(.noData))
//                }
//            }
//        }
//    }
//    
//    enum NetworkErrors: Error {
//        case noData
//        case tooManyRequests
//        case parsingError
//        case badRequest
//        case unauthorized
//        case forbidden
//        case notFound
//        case serverError
//    }
//    
//    func decode<T:Codable>(from data: Data) -> T? {
//        do {
//            let decodedData = try JSONDecoder().decode(T.self, from: data)
//            return decodedData
//        } catch {
//            print(error)
//            return nil
//        }
//    }
//}
