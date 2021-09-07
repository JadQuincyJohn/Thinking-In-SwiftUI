//
//  BadgeApp.swift
//  Badge
//
//  Created by Abi-Abdallah Jad on 09/09/2021.
//

import SwiftUI

@main
struct BadgeApp: App {
    var body: some Scene {
        WindowGroup {
			Group {
				VStack(spacing: 16) {
					ContentView(count: 5, size: 32, color: Color.blue)
					ContentView(count: 13, badgeAlignment: Alignment.topLeading, color: Color.yellow)
					ContentView(count: 0)
				}
			}
		}
    }
}
