# OCR On-Device App – Mobile Activity 13

This project demonstrates how to use **Apple’s Vision framework** for **on-device OCR (Optical Character Recognition)**. The goal is to explore Apple’s built-in AI/ML capabilities, integrate them into a SwiftUI app, and document findings and trade-offs for class presentation and Padlet.

---

## Overview

* **Framework chosen:** `Vision` → `VNRecognizeTextRequest`
* **Why Vision?**

  * 100% **on-device** (privacy, low latency, works offline)
  * **No training** or external APIs needed
  * Maintained by Apple, stable and well-integrated with iOS
* **Languages tested:** English (`en-US`) and Spanish (`es-MX`)
* **Modes provided:**

  * **Precise** (`.accurate`) – higher quality, a bit slower
  * **Fast** (`.fast`) – lower latency, good for quick scans

---

## Learning Objectives

1. Investigate Apple’s AI/ML options and justify framework selection.
2. Integrate a Vision-based OCR feature in a SwiftUI app.
3. Explain performance/quality trade-offs (fast vs precise, languages, image quality).
4. Deliver a working demo + documentation + short video.

---

## Apple AI/ML Landscape (Where Vision fits)

* **Vision** (this project): Prebuilt, on-device CV tasks (OCR, face/object detection, etc.). No training required.
* **Core ML**: Run custom ML models (.mlmodel). Use for tasks that need bespoke training or third-party models.
* **Foundation Models (Apple Intelligence)**: New high-level APIs for generative tasks (where available). Powerful but different scope than classical OCR.
* **VisionKit**: High-level UI for live data capture (e.g., `DataScannerViewController`)—great for **real-time scanning**; can complement this project later.

**Conclusion:** For OCR on photos without training or cloud, **Vision** is the most direct, stable, and offline-friendly choice.

---

## Architecture & File Structure

```
.
├─ OCROnDeviceApp.swift        # App entry (WindowGroup)
├─ RootView.swift              # Simple navigation hub
├─ ContentView.swift           # OCR UI: image picker, mode buttons, results
├─ OCRViewModel.swift          # ObservableObject state + actions
└─ TextRecognitionService.swift# Vision wrapper: VNRecognizeTextRequest
```

**Flow:**
`RootView` → `ContentView` (UI) → `OCRViewModel` (state & intents) → `TextRecognitionService` (Vision OCR)

---

## How It Works (End-to-End)

1. **Select image:** The user picks a photo from the gallery.
2. **Run OCR:** We create a `VNRecognizeTextRequest` with:

   * `recognitionLevel`: `.accurate` (Precise) or `.fast`
   * `recognitionLanguages`: `["es-MX", "en-US"]`
   * `usesLanguageCorrection`: `true`
3. **Process image:** A `VNImageRequestHandler` runs the request on the image.
4. **Display result:** We merge recognized strings and show them in a read-only text area with copy/clear actions.
5. **All on-device:** No network calls → better privacy and consistent performance.

---

## Key Implementation Details

* **Recognition Level**

  * `.accurate`: best quality; use for documents/screenshots.
  * `.fast`: responsive; good for quick checks or low-power devices.

* **Languages**

  * You can pass multiple languages; Vision will try to match the text. This project uses **English + Spanish** to reflect the course context.

* **Language Correction**

  * `usesLanguageCorrection = true` can improve outputs (spellings, spaces), but can slightly increase processing time.

* **Image Quality Matters**

  * Good lighting, high resolution, minimal blur → better accuracy.
  * Busy backgrounds reduce precision.

* **Orientation**

  * Photos may carry EXIF orientation; Vision supports orientation inputs. (If you later see rotated scans, map `UIImage.Orientation` to `CGImagePropertyOrientation` when creating the request handler.)

---

## Usage Scenarios for the Demo

* **Printed page** (English): book paragraph or printed sheet
* **Ticket/receipt** (Spanish): store receipt with prices/dates
* **Label/photo at an angle**: to illustrate real-world variability
* **Fast vs Precise**: show any accuracy/speed differences

---

## Requirements & Setup

* **Xcode** 15 or later
* **iOS** 16 or later target
* **Permissions:

  ```xml
  <key>NSPhotoLibraryUsageDescription</key>
  <string>We need access to your photo library to recognize text from images.</string>
  ```
* **Build & Run:** Open in Xcode → choose simulator or device → Run.

---

## App Walkthrough

1. Launch the app and open the **OCR screen**.
2. Tap **Select Photo** and choose an image.
3. Tap **Precise** or **Fast** to run OCR.
4. View extracted text → **Copy** or **Clear** as needed.

---

## Performance & Quality Tips (What we learned)

* **Precise vs Fast:** Start with **Precise** for documents; switch to **Fast** for quick tests or simple text.
* **Pre-processing (optional):**

  * **Downscale** very large images (e.g., max 2000px on the long edge) to reduce memory/time.
  * Use **Region of Interest** (`request.regionOfInterest`) if you know where the text is.
  * Set **minimumTextHeight** (e.g., `0.02`) to ignore tiny artifacts.
* **Lighting & Focus:** Encourage users to capture clear, straight photos.

---

## Extensibility / Future Work

* **Bounding Boxes Overlay:** Visualize `VNRecognizedTextObservation` rectangles over the image (great for demos).
* **Region of Interest UI:** Let users select a crop/area for faster, cleaner results.
* **VisionKit (Live OCR):** Add a second screen with `DataScannerViewController` for real-time scanning.
* **Post-Processing:** Regex extract emails, dates, amounts, product codes, etc.
* **Share/Export:** Add a share sheet or export to `.txt`/`.pdf`.

---

## Limitations

* Handwriting or stylized fonts can be inconsistent.
* Heavy glare, low resolution, or strong skew reduces accuracy.
* Mixed languages in a single line may not always separate perfectly.

---

## Troubleshooting

* **Empty result:** Ensure the image has legible text; try **Precise** mode.
* **App asks for Photos permission every time:** Check `NSPhotoLibraryUsageDescription` in `Info.plist`.
* **Text looks rotated/garbled:** Re-capture photo straighter; consider passing the correct **image orientation** to Vision.
* **Simulator camera limitations:** Prefer photo library images or test on a real device.

---

## References (for your report/Padlet)

* Apple Developer – Machine Learning (high-level)
* Apple Developer – Vision framework docs
* Apple Developer – App Intents (optional future integration)
  *(Links are already in the assignment brief; include them on Padlet/Slides as needed.)*

---

## 👤 Authors

José Manuel Sánchez
Grecia Klarissa
Guillermo Lira

ITESM – Mobile Activity 13
