//
//  AuthManager.swift
//  ToDoTasks
//
//  Created by Максим on 31.01.2025.
///
import FirebaseAuth
import Combine

class AuthManager {
    static let shared = AuthManager()
    private var handle: AuthStateDidChangeListenerHandle?
    
    // Публикуем состояние аутентификации через PassthroughSubject
    var authenticationStatePublisher = PassthroughSubject<Bool, Never>()

    private init() {}

    func addFirebaseListener() {
        handle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            guard let self = self else { return }
            if user != nil {
                self.authenticationStatePublisher.send(true)  // Пользователь вошел в систему
            } else {
                self.authenticationStatePublisher.send(false) // Пользователь вышел из системы
            }
        }
    }

    func removeFirebaseListener() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
