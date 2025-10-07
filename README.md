# OCR On-Device App – Mobile Activity 13

This project demonstrates how to use **Apple’s Vision framework** for **on-device OCR (Optical Character Recognition)** as part of Mobile Activity 13.

## 📖 Overview
- Framework chosen: **Vision** (`VNRecognizeTextRequest`)
- Runs **completely offline** (no dataset or API required)
- Supports **multiple languages** (English & Spanish included)
- Provides two modes: **Precise** (slower, more accurate) and **Fast** (faster, less accurate)

## ⚙️ Architecture
- `OCROnDeviceApp.swift`: App entry
- `RootView.swift`: Main navigation
- `ContentView.swift`: UI for image selection & results
- `OCRViewModel.swift`: ViewModel handling state
- `TextRecognitionService.swift`: Vision framework integration

## 🚀 How it works
1. User selects an image from gallery
2. App runs OCR using `VNRecognizeTextRequest`
3. Extracted text is displayed and can be copied
4. Works **entirely on-device** (privacy + speed)

## 📱 Requirements
- Xcode 15+
- iOS 16+
- Add `NSPhotoLibraryUsageDescription` to **Info.plist**

## 🌟 Future Improvements
- Draw bounding boxes on detected text
- Use Region of Interest (ROI) for performance
- Integrate **VisionKit** for real-time scanning

## 👤 Author
José Manuel Sánchez – ITESM Mobile Activity 13
