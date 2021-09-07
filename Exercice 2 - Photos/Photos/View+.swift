//
//  View+.swift
//  Photos
//
//  Created by Abi-Abdallah Jad on 28/07/2021.
//

import SwiftUI

extension View {
	func debug() -> Self {
		print(Mirror(reflecting: self).subjectType)
		return self
	}
}
