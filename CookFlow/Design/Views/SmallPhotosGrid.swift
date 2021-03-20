//
//  SmallPhotosGrid.swift
//  CookFlow
//
//  Created by Alexander Krupichko on 20.03.2021.
//

import SwiftUI

struct SmallPhotosGrid: View {
    let photoUrls: [URL]

    let columns = [
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80)),
        GridItem(.adaptive(minimum: 80))
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            ForEach(photoUrls, id: \.absoluteString) { url in
                RemoteImage(url: url).smallImage()
            }
        }.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
    }
}

struct SmallPhotosGrid_Previews: PreviewProvider {
    static var previews: some View {
        SmallPhotosGrid(photoUrls: Array(0..<20).map { URL(string: "https://cookflow\($0).ru")! })
    }
}
