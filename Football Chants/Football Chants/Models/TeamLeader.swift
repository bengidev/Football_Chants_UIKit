//
//  TeamLeader.swift
//  Football Chants
//
//  Created by Bambang Tri Rahmat Doni on 17/12/23.
//

import Foundation

struct TeamLeader: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let job: Job
    
    static let empty: TeamLeader = .init(name: "", job: .manager)
}

extension TeamLeader {
    enum Job: String, Hashable, Identifiable, CaseIterable {
        var id: Self { return self }
        case manager = "Manager"
        case headCoach = "Head Coach"
    }
}
