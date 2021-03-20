//
//  RemoteImage.swift
//  CookFlow
//
//  Created by Alexander Krupichko on 20.03.2021.
//

import SwiftUI

struct RemoteImage: View {
    private enum LoadState {
        case loading, success, failure
    }

    private class Loader: ObservableObject {
        var data = Data()
        var state = LoadState.loading

        init(url: URL) {

            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, data.count > 0 {
                    self.data = data
                    self.state = .success
                } else {
                    self.state = .failure
                }

                DispatchQueue.main.async {
                    self.objectWillChange.send()
                }
            }.resume()
        }
    }

    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image

    var body: some View {
        selectImage()
            .resizable()
    }

    init(url: URL, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }

    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            if let image = UIImage(data: loader.data) {
                return Image(uiImage: image)
            } else {
                return failure
            }
        }
    }
}

extension RemoteImage {
    func bigImage() -> AnyView {
        AnyView(
            scaledToFit()
                .cornerRadius(16)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        )
    }
    func smallImage() -> AnyView {
        AnyView(
            scaledToFit()
                .cornerRadius(8)
        )
    }
}
