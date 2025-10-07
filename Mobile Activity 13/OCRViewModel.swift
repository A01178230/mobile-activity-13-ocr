//
//  OCRViewModel.swift
//  Mobile Activity 13
//
//  Created by Guillermo Lira on 06/10/25.
//
import SwiftUI
import UIKit
import Combine   // <- necesario para ObservableObject y @Published

@MainActor
final class OCRViewModel: ObservableObject {
    @Published var selectedImage: UIImage?
    @Published var extractedText: String = ""
    @Published var isProcessing: Bool = false
    @Published var errorMessage: String?

    private let service = TextRecognitionService()

    func runOCR(precise: Bool = true) {
        guard let img = selectedImage else {
            errorMessage = "Selecciona o toma una imagen primero."
            return
        }
        isProcessing = true
        errorMessage = nil

        Task {
            do {
                let text = try service.recognizeText(in: img, precise: precise)
                self.extractedText = text
            } catch {
                self.errorMessage = "No se pudo reconocer el texto: \(error.localizedDescription)"
            }
            self.isProcessing = false
        }
    }

    func clear() {
        selectedImage = nil
        extractedText = ""
        errorMessage = nil
    }
}
