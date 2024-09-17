//
//  YouTubeAPIClient.swift
//  ToDoTasks
//
//  Created by Максим on 05.09.2024.
//

import Foundation
import Alamofire

class YouTubeAPIClient {
    
    static var shared = YouTubeAPIClient()
    private init() {}
    
    var youTubeArticle = [YouTubeArticle]()
    
    func getVideoFromAPI(clouser: @escaping ([YouTubeArticle]?) -> Void) {
        AF.request(APIEndpoints.getVideo).responseDecodable(of: YouTubeAPIModel.self) { [weak self] response in
            switch response.result {
            case .success(let data):
                for article in data.articles {
                    self?.youTubeArticle.append(article)
                }
                clouser(self?.youTubeArticle)
            case .failure(let error):
                guard let statusCode = self?.getStatusCode(responseData: response) else {return}
                self?.handleStatusCode(statusCode)
            }
        }
    }
    
    func getStatusCode(responseData: DataResponse <YouTubeAPIModel, AFError>) -> NetworkErrorStatusCode {
        guard let responsData = responseData.response?.statusCode else {
            return .unknownError("No server Response. Network issues possible")
        }
        switch responseData.response?.statusCode {
        case 400: return .badRequest("Неверный запрос: 400 Bad Request")
        case 401: return .unauthorized("Необходима аутентификация: 401 Unauthorized")
        case 403: return .forbidden("Доступ запрещен: 403 Forbidden")
        case 404: return .notFound("Ресурс не найден: 404 Not Found")
        case 500: return .internalServerError("Ошибка сервера: 500 Internal Server Error")
        case 502: return .badGateway("Плохой шлюз: 502 Bad Gateway")
        case 503: return .serviceUnavailable("Сервис недоступен: 503 Service Unavailable")
        case 504: return .gateWayTimeout("Тайм-аут шлюза: 504 Gateway Timeout")
        default: return .unknownStatusCode("Неизвестный статус код: \(responseData.response?.statusCode)")
        }
    }
    
    enum NetworkErrorStatusCode: Error {
        case noData(String)
        case tooManyRequests(String)
        case parsingError(String)
        case badRequest(String)
        case unauthorized(String)
        case forbidden(String)
        case notFound(String)
        case internalServerError(String)
        case badGateway(String)
        case gateWayTimeout(String)
        case serviceUnavailable(String)
        case unknownStatusCode(String)
        case unknownError(String)
    }
    
    private func handleStatusCode(_ statusCode: NetworkErrorStatusCode) {
            switch statusCode {
//            case .unauthorized, .forbidden, .notFound:
                // Пример: показать алерт (для UIKit)
//                DispatchQueue.main.async {
//                    if let rootVC = UIApplication.shared.windows.first?.rootViewController {
//                        let alert = UIAlertController(title: "Ошибка", message: statusCode.localizedDescription, preferredStyle: .alert)
//                        alert.addAction(UIAlertAction(title: "OK", style: .default))
//                        rootVC.present(alert, animated: true)
//                    }
//                }
            case .internalServerError, .serviceUnavailable:
                // Пример: повторный запрос
                getVideoFromAPI { articles in
                    // Обработка повторного запроса
                }
            default:
                // Логирование или другие действия
                print(statusCode.localizedDescription)
            }
        }
}
/////////
/////////
///llllllll
///////////lllllkijijijij
