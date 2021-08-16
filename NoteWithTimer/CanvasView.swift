//
//  CanvasView.swift
//  NoteWithTimer
//
//  Created by 髙橋　竜治 on 2021/08/16.
//

import SwiftUI
import PencilKit

struct CanvasView {
    @Binding var canvasView: PKCanvasView
    let onSaved: () -> Void
    @State var toolPicker = PKToolPicker()
}

// MARK: - UIViewRepresentable
extension CanvasView: UIViewRepresentable {
    func makeUIView(context: Context) -> PKCanvasView {
        canvasView.tool = PKInkingTool(.pen, color: .gray, width: 10)
        #if targetEnvironment(simulator)
        canvasView.drawingPolicy = .anyInput
        #endif
        canvasView.delegate = context.coordinator
        showToolPicker()
        return canvasView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(canvasView: $canvasView, onSaved: onSaved)
    }
}

// MARK: - Private Methods
private extension CanvasView {
    func showToolPicker() {
        toolPicker.setVisible(true, forFirstResponder: canvasView)
        toolPicker.addObserver(canvasView)
        canvasView.becomeFirstResponder()
    }
}

// MARK: - Coordinator
class Coordinator: NSObject {
    var canvasView: Binding<PKCanvasView>
    let onSaved: () -> Void

    // MARK: - Initializers
    init(canvasView: Binding<PKCanvasView>, onSaved: @escaping () -> Void) {
        self.canvasView = canvasView
        self.onSaved = onSaved
    }
}

// MARK: - PKCanvasViewDelegate
extension Coordinator: PKCanvasViewDelegate {
    func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
        if !canvasView.drawing.bounds.isEmpty {
            onSaved()
        }
    }
}
