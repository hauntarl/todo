//
//  Image+Extension.swift
//  Todo
//
//  Created by Sameer Mungole on 4/23/24.
//

import SwiftUI

extension Image {
    /// Loads an image from the Assets, returns a resizable view
    static func icon(for resource: ImageResource) -> some View {
        Image(resource)
            .resizable()
            .scaledToFit()
    }
}
