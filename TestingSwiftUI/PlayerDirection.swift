//
//  PlayerDirection.swift
//  TestingSwiftUI
//
//  Created by Jan Stehlík on 18.07.2024.
//

import Foundation

enum PlayerDirection: String {
  case up, down, left, right, stop

  var velocity: CGVector {
    switch self {
    case .up: return .init(dx: 0, dy: 100)
    case .down: return .init(dx: 0, dy: -100)
    case .left: return .init(dx: -100, dy: 0)
    case .right: return .init(dx: 100, dy: 0)
    case .stop: return .init(dx: 0, dy: 0)
    }
  }
}
