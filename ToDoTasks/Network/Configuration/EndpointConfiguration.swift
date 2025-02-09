//
//  EndpointConfiguration.swift
//  ToDoTasks
//
//  Created by Максим on 28.09.2024.
//

import Foundation
import UIKit

protocol EndpointConfigurable {
    func returnRequest() throws -> URLRequest?
}

//здесь вызываем сами эндпоинты, в зависимости от выбранного будут меняться URL, хедеры, HTTPMethod и тд
enum EndpointType: EndpointConfigurable {
    case getForegroundData
    case downloadBackgroundData
    case uploadMultiPartData(image: UIImage?, text: String?)//нужно для мультипарт запроса
    case getForegroundDataWithToken(token: String?)
    
    
    var baseURLPath: URL {//формируем базовый путь URL
        get throws {
            guard let url = URL(string: "https://newsapi.org/v2/everything") else {
                throw EndpointError.cannotCreateBaseURL
            }
            return url
        }
    }
    
    func createEndpointPath() throws -> URL {//формируем единый URL из базового URL и заданных компонентов. Это тот случай когда мы д
        
        let url = try baseURLPath
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw EndpointError.cannotCreateURLWithComponent
        }
        
        switch self {
        case .getForegroundData:
            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: "Trump"),
                URLQueryItem(name: "from", value: "2025-01-01"),
                URLQueryItem(name: "sortBy", value: "popularity")]
        case .downloadBackgroundData:
            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: "tesla"),
                URLQueryItem(name: "from", value: "2024-08-05"),
                URLQueryItem(name: "sortBy", value: "publishedAt")]
        case .uploadMultiPartData:
            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: "IT"),
                URLQueryItem(name: "from", value: "2024-08-05"),
                URLQueryItem(name: "sortBy", value: "publishedAt")]
        case .getForegroundDataWithToken:
            urlComponents.queryItems = [
                URLQueryItem(name: "q", value: "IT"),
                URLQueryItem(name: "from", value: "2024-08-05"),
                URLQueryItem(name: "sortBy", value: "publishedAt")]
        }
        
        guard let url = urlComponents.url else {
            throw EndpointError.cannotCreateURLWithComponent
        }
        return url
    }
    
    var header: [String: String] {
        let boundary = "\(UUID().uuidString)"
        var headers = [String: String]()
        headers["X-Environment"] = Environment.current.rawValue//указываем общий заголовок для всех типов запросов в котором говорим о том какое окружение "Debag" или "Release" включено. Сервер пришлет ответ в соответствии с запрошенным окружением (ответ с тестового или боевого сервера к примеру)
        headers["Accept"] = "application/json"
       headers["Authorization"] = "23ed6969bd05413aa7680d0a492f26e9"
        
        switch self {
        case .getForegroundData: break
            
        case .downloadBackgroundData:
            headers["Content-Type"] = "application/json"
            
        case .uploadMultiPartData:
            headers["Content-Type"] = "multipart/form-data; boundary=\(boundary)"
            
        case .getForegroundDataWithToken(let token):
            headers["Authorization"] = "Bearer \(token)"
        }
        
        return headers
    }
    
    var method: String {
        switch self {
        case .getForegroundData, .getForegroundDataWithToken: return "GET"
        case .downloadBackgroundData: return "POST"
        case .uploadMultiPartData: return "POST"
        }
    }
    
    var body: Data? {
        switch self {
        case .getForegroundData, .getForegroundDataWithToken, .downloadBackgroundData:
            return nil
        case .uploadMultiPartData(let image, let text):
            let boundary = "/(UUID().uuidString)"
            let text = ["serverKey": text ?? ""]
            let httpBody = createMultiPartBody(text: text, boundary: boundary, image: image!, imageKey: EndpointType.imageKey)
            return httpBody
        }
    }
    
    //здесь создаем body а именно MultiPart Body для добавления в реквест. Принимаем условные параметры в виде текста и картинки, если например, пользователь отправляет обращение с текстом проблемы и скрином ошибки
    func createMultiPartBody(text: [String: String], boundary: String, image: UIImage, imageKey: String) -> Data {
        var body = Data()
        //добавляем текст который хотим отправить на сервер
        for (key, values) in text {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(values)\r\n".data(using: .utf8)!)
        }
        //добавляем картинку которую хотим отправить на сервер
        if let image = image.jpegData(compressionQuality: 1.0) {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(imageKey)\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return body
    }
    
    var cashPolicy: URLRequest.CachePolicy {
        switch self {
        case .getForegroundData: return .returnCacheDataElseLoad
        case .getForegroundDataWithToken: return .returnCacheDataElseLoad
        case .downloadBackgroundData: return .reloadIgnoringLocalAndRemoteCacheData
        case .uploadMultiPartData: return .reloadIgnoringLocalAndRemoteCacheData
        }
    }
    
    //здесь создаем и возвращаем URLRequest на основе всех данных из этого Enum
    func returnRequest() -> URLRequest? {
        do {
            let endpointPath = try createEndpointPath()
            var urlRequest = URLRequest(url: endpointPath)
            urlRequest.httpMethod = self.method // Устанавливаем HTTP метод
            let headers = self.header
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
            urlRequest.httpBody = self.body
            urlRequest.cachePolicy = self.cashPolicy
            return urlRequest
        } catch EndpointError.cannotCreateBaseURL {
            print("Не удалось создать базовый URL")
            return nil
        } catch EndpointError.cannotCreateURLWithComponent {
            print("Не удалось создать URL составной части")
            return nil
        } catch {
            return nil
        }
    }
}

extension EndpointType { //здесь организовано пространство имен например для imageKeys мультипарт запросов
    static var imageKey = "SomeImage"
}


enum EndpointError: Error {
    case cannotCreateURLWithComponent
    case cannotCreateBaseURL
}
