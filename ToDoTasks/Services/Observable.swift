//
//  Observable.swift
//  ToDoTasks
//
//  Created by Максим on 25.01.2025.
//

import Foundation

class ObservableObject<T> {
    var value: T {
        didSet {
            observers.values.forEach { $0(value) }// Уведомляем всех подписчиков при изменении значения
        }
    }
    
    private var observers: [UUID: (T) -> Void] = [:] // Храним подписчиков с их UUID
    
    init(_ value: T) {
        self.value = value
    }
    
    // Подписка
    func bind(observer: @escaping (T) -> Void) -> UUID {
        let id = UUID() // Генерируем уникальный идентификатор
        observers[id] = observer
        observer(value) // Немедленно уведомляем о текущем значении
        return id
    }
    
    // Удаление конкретного подписчика
    func unbind(id: UUID) {
        observers.removeValue(forKey: id)
    }
    
    // Удаление всех подписчиков
    func unbindAll() {
        observers.removeAll()
    }
}
