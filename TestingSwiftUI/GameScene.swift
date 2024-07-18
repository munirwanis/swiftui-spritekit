//
//  GameScene.swift
//  TestingSwiftUI
//
//  Created by Jan Stehlík on 18.07.2024.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {

  // Direction - given in SwiftUI and passed to SpriteKit
  @Binding var currentDirection: PlayerDirection
  // Score - given in SpriteKit and given to SwiftUI
  @Binding var score: Int

  init(size: CGSize, direction: Binding<PlayerDirection>, score: Binding<Int>) {
    _currentDirection = direction
    _score = score
    super.init(size: size)
    self.scaleMode = .fill
  }

  required init?(coder aDecoder: NSCoder) {
    _currentDirection = .constant(.up)
    _score = .constant(0)
    super.init(coder: aDecoder)
  }

  override func sceneDidLoad() {
    // set the physics contact delegate, so this class can register contact events.
    self.physicsWorld.contactDelegate = self
  }

  override func didMove(to view: SKView) {
    // Add player
    addChild(Player(sceneSize: self.size))
    // Add food
    addChild(Food(sceneSize: self.size))
  }

  override func update(_ currentTime: TimeInterval) {

    guard let player = self.childNode(withName: "player") as? Player else {
      print("Failed to find the node")
      return
    }

    player.considerTurning(currentDirection: currentDirection)
    player.considerStopping(sceneSize: self.size, currentDirection: &currentDirection)
  }

  func didBegin(_ contact: SKPhysicsContact) {
    // Remove food
    [contact.bodyA, contact.bodyB].first(where: {$0.node?.name == "food"})?.node?.removeFromParent()
    // Add new food
    self.addChild(Food(sceneSize: self.size))
    // Increment score
    score += 1
  }
}
