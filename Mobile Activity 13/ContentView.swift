//
//  ContentView.swift
//  Mobile Activity 13
//
//  Created by Guillermo Lira on 06/10/25.
//
import SwiftUI
import PhotosUI

struct OCRView: View {
    @StateObject private var vm = OCRViewModel()
    @State private var photoItem: PhotosPickerItem?

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {

                PhotosPicker(selection: $photoItem, matching: .images) {
                    Label("Elegir foto", systemImage: "photo.on.rectangle")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .onChange(of: photoItem) { newValue in
                    Task {
                        if let data = try? await newValue?.loadTransferable(type: Data.self),
                           let ui = UIImage(data: data) {
                            vm.selectedImage = ui
                            vm.extractedText = ""
                            vm.errorMessage = nil
                        }
                    }
                }

                if let img = vm.selectedImage {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 240)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .overlay(RoundedRectangle(cornerRadius: 12).stroke(.gray.opacity(0.3)))
                        .padding(.top, 4)
                } else {
                    ContentPlaceholder()
                }

                HStack {
                    Button {
                        vm.runOCR(precise: true)
                    } label: {
                        Label("Reconocer (Preciso)", systemImage: "text.viewfinder")
                    }
                    .buttonStyle(.borderedProminent)

                    Button {
                        vm.runOCR(precise: false)
                    } label: {
                        Label("Rápido", systemImage: "bolt.fill")
                    }
                    .buttonStyle(.bordered)
                }

                if vm.isProcessing {
                    ProgressView("Procesando...")
                        .padding(.top, 4)
                }

                if let err = vm.errorMessage {
                    Text(err)
                        .foregroundStyle(.red)
                        .font(.callout)
                }

                if !vm.extractedText.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Texto detectado")
                            .font(.headline)

                        TextEditor(text: .constant(vm.extractedText))
                            .font(.body.monospaced())
                            .frame(minHeight: 180)
                            .scrollContentBackground(.hidden)
                            .padding(8)
                            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))

                        HStack {
                            Button {
                                UIPasteboard.general.string = vm.extractedText
                            } label: {
                                Label("Copiar", systemImage: "doc.on.doc")
                            }
                            .buttonStyle(.bordered)

                            Button("Limpiar") { vm.clear() }
                                .buttonStyle(.bordered)
                        }
                    }
                    .padding(.top, 8)
                }

                Spacer(minLength: 12)
            }
            .padding()
        }
        .navigationTitle("OCR On-Device")
    }
}

private struct ContentPlaceholder: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "doc.text.image")
                .font(.system(size: 40))
                .foregroundStyle(.secondary)
            Text("Selecciona una foto con texto para reconocerlo.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, minHeight: 140)
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}

