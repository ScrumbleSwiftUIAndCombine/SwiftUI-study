//
//  AppState.swift
//  SwiftUI_Redux_tutorial
//
//  Created by min on 2023/10/04.
//

import Foundation

struct AppState {
    var currentDice: String = "" {
        didSet {
            print("currentDice : \(currentDice)", #fileID, #line)
        }
    }
}
