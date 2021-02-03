//
//  SettingsView.swift
//  Lato
//
//  Created by juandahurt on 3/02/21.
//

import SwiftUI

struct SettingsView: View {
    var onBackTap: () -> Void
    
    var body: some View {
        VStack {
            Button("Back") {
                onBackTap()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Background"))
        .statusBar(hidden: true)
    }
}
