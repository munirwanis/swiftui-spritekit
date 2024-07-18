//
//  Food.swift
//  TestingSwiftUI
//
//  Created by Jan Stehlík on 18.07.2024.
//

import Foundation
import SpriteKit

class Food: SKSpriteNode {

  // Convenience initializer we created
  convenience init(sceneSize: CGSize) {
    self.init(color: .red, size: CGSize(width: 16, height: 16))
    self.name = "food"
    self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.linearDamping = 0

    // Collisions
    self.physicsBody?.categoryBitMask = 2
    self.physicsBody?.contactTestBitMask = 1
    self.physicsBody?.collisionBitMask = 0

    // Random position
    let minX: CGFloat = 0 + self.size.width/2
    let maxX: CGFloat = sceneSize.width - self.size.width/2
    let minY: CGFloat = 0 + self.size.height/2
    let maxY: CGFloat = sceneSize.height - self.size.height/2
    let randomX = CGFloat.random(in: minX...maxX)
    let randomY = CGFloat.random(in: minY...maxY)
    self.position = .init(x: randomX, y: randomY)
  }

  // Required to enable our convenience init
  override init(texture: SKTexture?, color: UIColor, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
  }

  // Required
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
