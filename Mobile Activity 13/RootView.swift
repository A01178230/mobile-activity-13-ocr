//
//  RootView.swift
//  Mobile Activity 13
//
//  Created by Guillermo Lira on 06/10/25.
//


import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    OCRView()
                } label: {
                    Label("OCR On-Device (Vision)", systemImage: "text.viewfinder")
                }
            }
            .navigationTitle("AI/ML – Proyecto Nuevo")
        }
    }
}
