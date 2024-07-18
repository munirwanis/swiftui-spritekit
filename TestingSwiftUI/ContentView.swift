//
//  ContentView.swift
//  TestingSwiftUI
//
//  Created by Munir Xavier Wanis on 23/06/20.
//

import SwiftUI
import SpriteKit

struct ContentView: View {

  // Current direction for the player, set by the user
  @State private var currentDirection = PlayerDirection.stop

  // Current score
  @State private var score = 0

  var body: some View {
    ZStack {
      Color.clear.background(.gray.gradient)
      VStack {
        // Use GeometryReader to set the Scene size, no need to use fixed numbers.
        GeometryReader { geo in
          ZStack {
            Color.clear
            SpriteView(scene: GameScene(size: geo.size, direction: $currentDirection, score: $score))
          }
          .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
          .padding()
        } // geo

        Text("Score: \(score)")
          .bold()

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

}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
