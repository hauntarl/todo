//
//  Samples.swift
//  Todo
//
//  Created by Sameer Mungole on 4/21/24.
//
//  These samples are utilized by previews while building and testing the interface

import Foundation

/// As the api is currently using in-memory database, this extension creates some sample
/// tasks, intentionally done for demo purposes.
///
/// TODO: Remove once the api uses persistent storage
extension NewTask {
    static let samples: [NewTask] = [
        .init(
            description: "Meal Prep",
            dueAt: randomDate,
            completed: Bool.random()
        ),
        .init(
            description: "Send Email",
            dueAt: randomDate,
            completed: Bool.random()
        ),
        .init(
            description: "Write Offer",
            dueAt: randomDate,
            completed: Bool.random()
        ),
        .init(
            description: "Organize Files",
            dueAt: randomDate,
            completed: Bool.random()
        ),
        .init(
            description: "Blog Post",
            dueAt: randomDate,
            completed: Bool.random()
        ),
        .init(
            description: "Clean House",
            dueAt: randomDate,
            completed: Bool.random()
        ),
        .init(
            description: "Grocery Shopping",
            dueAt: randomDate,
            completed: Bool.random()
        )
    ]
    
    private static var randomDate: Date {
        .now.addingTimeInterval(TimeInterval(timeIntervalRange.randomElement()!))
    }
    
    private static let timeIntervalRange = (60 * 60 * 24)...(60 * 60 * 24 * 20)
}

extension TaskItem {
    static var samples: [Self] = {
        try! JSONDecoder().decode([Self].self, from: sampleJSON)
    }()
    
    static var sampleJSON = """
    [
        {
            "id": "800513d7-1c11-416e-8287-8480cb41accd",
            "taskDescription": "Grocery Shopping",
            "createdDate": "2024-04-21T02:32:39.014829Z",
            "dueDate": "2024-04-30T11:00:00Z",
            "completed": false
        },
        {
            "id": "0095da82-5a1f-4715-ad0f-e05347c58c41",
            "taskDescription": "Clean House",
            "createdDate": "2024-04-21T02:33:11.346353Z",
            "dueDate": "2024-05-10T15:00:00Z",
            "completed": true
        },
        {
            "id": "f328e10e-141f-4f0d-8e24-767cb20b5baf",
            "taskDescription": "Blog Post",
            "createdDate": "2024-04-21T02:33:54.172113Z",
            "dueDate": "2024-05-20T15:00:00Z",
            "completed": false
        }
    ]
    """.data(using: .utf8)!
}

extension TaskError {
    static var sample: Self = {
        try! JSONDecoder().decode(Self.self, from: sampleJSON)
    }()
    
    static var sampleJSON = """
    {
        "type": "https://tools.ietf.org/html/rfc9110#section-15.5.5",
        "title": "Task not found",
        "status": 404,
        "traceId": "00-67084c94108517c7b13dd97ebb1c171f-ecfe7623d119970b-00"
    }
    """.data(using: .utf8)!
}
