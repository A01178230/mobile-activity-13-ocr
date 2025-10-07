//
//  TextRecognitionService.swift
//  Mobile Activity 13
//
//  Created by Guillermo Lira on 06/10/25.
//


import Foundation
import Vision
import UIKit

final class TextRecognitionService {

    func recognizeText(in image: UIImage, precise: Bool = true) throws -> String {
        guard let cg = image.cgImage else { return "" }

        let request = VNRecognizeTextRequest()
        request.recognitionLevel = precise ? .accurate : .fast
        request.usesLanguageCorrection = true
        request.recognitionLanguages = ["es-MX", "en-US"] // ajusta si quieres

        let handler = VNImageRequestHandler(cgImage: cg, options: [:])
        try handler.perform([request])

        let lines = (request.results ?? []).compactMap { $0.topCandidates(1).first?.string }
        return lines.joined(separator: "\n")
    }
}
