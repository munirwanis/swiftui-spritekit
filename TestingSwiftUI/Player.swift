//
//  Player.swift
//  TestingSwiftUI
//
//  Created by Jan Stehlík on 18.07.2024.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {

  // Convenience init so we can use sceneSize
  convenience init(sceneSize: CGSize) {
    self.init(color: .green, size: CGSize(width: 16, height: 16))
    self.name = "player"
    self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
    self.physicsBody?.affectedByGravity = false
    self.physicsBody?.linearDamping = 0

    // Collisions
    self.physicsBody?.categoryBitMask = 1
    self.physicsBody?.contactTestBitMask = 2
    self.physicsBody?.collisionBitMask = 0

    // Position
    self.position = .init(x: sceneSize.width/2, y: sceneSize.height/2)

  }

  // Required to enable our convenience init
  override init(texture: SKTexture?, color: UIColor, size: CGSize) {
    super.init(texture: texture, color: color, size: size)
  }

  // Required
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  /**
   Try turning, given the user's chosen direction.
   */
  func considerTurning(currentDirection: PlayerDirection) {
    if self.physicsBody?.velocity.dx ?? 0 < 0, currentDirection.velocity.dx > 0 {
      // player going left, we asked to go right
      // can't turn
    } else if self.physicsBody?.velocity.dx ?? 0 > 0, currentDirection.velocity.dx < 0 {
      // player going right, we asked to go left
      // can't turn
    } else if self.physicsBody?.velocity.dy ?? 0 < 0, currentDirection.velocity.dy > 0 {
      // player going down, we asked to go up
      // can't turn
    } else if self.physicsBody?.velocity.dy ?? 0 > 0, currentDirection.velocity.dy < 0 {
      // player going up, we asked to go down
      // can't turn
    } else {
      // turn
      self.physicsBody?.velocity = currentDirection.velocity
    }
  }

  /**
   Consider stopping if the player hits the edge.
   */
  func considerStopping(sceneSize: CGSize, currentDirection: inout PlayerDirection) {
    // Padded values.
    // This way, player will not stop just because it is touching the edge.
    // It must go one point over, and then will be returned to the edge and stopped.
    // After that, we can give it velocity again.
    let playerHeightPadding = (self.size.height / 2) - 1
    let playerWidthPadding = (self.size.width / 2) - 1

    if self.position.x <= playerWidthPadding {
      // player hit the leading edge
      self.position.x = self.size.width / 2
      currentDirection = .stop
    } else if self.position.x >= (sceneSize.width - playerWidthPadding) {
      // player hit the trailing edge
      self.position.x = sceneSize.width - (self.size.width / 2)
      currentDirection = .stop
    } else if self.position.y <= playerHeightPadding {
      // player hit the bottom edge
      self.position.y = self.size.height / 2
      currentDirection = .stop
    } else if self.position.y >= (sceneSize.height - playerHeightPadding) {
      // player hit the top edge
      self.position.y = sceneSize.height - (self.size.height / 2)
      currentDirection = .stop
    }
  }

}
