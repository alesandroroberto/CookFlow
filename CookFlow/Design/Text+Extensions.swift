//
//  Text+Extensions.swift
//  CookFlow
//
//  Created by Alexander Krupichko on 20.03.2021.
//

import SwiftUI

extension Text {
    func titleStyle() -> AnyView {
        AnyView(self.font(.title)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)))
    }
    func textStyle() -> AnyView {
        AnyView(font(.body)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)))
    }
}
