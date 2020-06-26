//
//  ContentView.swift
//  TestingSwiftUI
//
//  Created by Munir Xavier Wanis on 23/06/20.
//

import SwiftUI
import SpriteKit

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

class GameScene: SKScene {
    var player = SKSpriteNode(color: .green, size: CGSize(width: 16, height: 16))
    @Binding var currentDirection: PlayerDirection
    
    override func didMove(to view: SKView) {
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.affectedByGravity = false
        player.position = .init(x: size.width / 2, y: size.height / 2)
        player.physicsBody?.linearDamping = 0
        addChild(player)
    }
    
    override func update(_ currentTime: TimeInterval) {
        if player.physicsBody?.velocity.dx ?? 0 < 0, currentDirection.velocity.dx > 0 {
            // can't turn
        } else if player.physicsBody?.velocity.dx ?? 0 > 0, currentDirection.velocity.dx < 0 {
            // can't turn
        } else if player.physicsBody?.velocity.dy ?? 0 < 0, currentDirection.velocity.dy > 0 {
            // can't turn
        } else if player.physicsBody?.velocity.dy ?? 0 > 0, currentDirection.velocity.dy < 0 {
            // can't turn
        } else {
            player.physicsBody?.velocity = currentDirection.velocity
        }
        
        
        let playerHeightPadding = (player.size.height / 2) - 1
        let playerWidthPadding = (player.size.width / 2) - 1
        
        if player.position.x <= playerWidthPadding {
            player.position.x = player.size.width / 2
            currentDirection = .stop
        } else if player.position.x >= (self.size.width - playerWidthPadding) {
            player.position.x = self.size.width - (player.size.width / 2)
            currentDirection = .stop
        } else if player.position.y <= playerHeightPadding {
            player.position.y = player.size.height / 2
            currentDirection = .stop
        } else if player.position.y >= (self.size.height - playerHeightPadding) {
            player.position.y = self.size.height - (player.size.height / 2)
            currentDirection = .stop
        }
    }
    
    init(_ direction: Binding<PlayerDirection>) {
        _currentDirection = direction
        super.init(size: CGSize(width: 414, height: 896))
        self.scaleMode = .fill
    }
    
    required init?(coder aDecoder: NSCoder) {
        _currentDirection = .constant(.up)
        super.init(coder: aDecoder)
    }
}

struct ContentView: View {
    @State private var currentDirection = PlayerDirection.stop
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                LinearGradient(gradient: Gradient(colors: [Color.gray, Color.gray.opacity(0.8), Color.gray]),
                               startPoint: .top,
                               endPoint: .bottom)
                
            }.edgesIgnoringSafeArea(.all)
            
            VStack {
                SpriteView(scene: GameScene($currentDirection))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .padding(50)

                VStack(spacing: 10) {
                    HStack {
                        Spacer()
                        directionalButton(.up)
                        Spacer()
                    }
                    HStack {
                        directionalButton(.left)
                        directionalButton(.down)
                        directionalButton(.right)
                    }
                }
                .padding(.all, 10)
            }
        }
    }
    
    func directionalButton(_ direction: PlayerDirection) -> some View {
        VStack {
            Button(action: { self.currentDirection = direction }, label: {
                Image(systemName: "arrow.\(direction.rawValue)")
                    .frame(width: 50, height: 50, alignment: .center)
                    .foregroundColor(.black)
                    .background(Color.white.opacity(0.6))
            })
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5)
        }
    }
    
    func redButtonForTesting() -> some View {
        Button(action: {}) {
            Circle()
                .frame(width: 50, height: 50)
                .foregroundColor(.red)
                .overlay(Circle()
                            .foregroundColor(.red)
                            .padding(10)
                            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                            .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5))
                .background(RoundedRectangle(cornerRadius: 10)
                                .frame(width: 80, height: 80)
                                .foregroundColor(Color.black.opacity(0.4))
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 10, y: 10)
                                .shadow(color: Color.white.opacity(0.7), radius: 10, x: -5, y: -5))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
