//
//  ContentView.swift
//  NoteWithTimer
//
//  Created by 髙橋　竜治 on 2021/08/16.
//

import SwiftUI
import PencilKit

struct DrawingView: View {

    @State var rendition: Rendition?
    @State private var canvasView = PKCanvasView()

    var body: some View {
        NavigationView {
            ZStack {
                CanvasView(canvasView: $canvasView, onSaved: saveDrawing)
                    .background(Color.black)
                    .navigationBarTitle(Text("タイマー付メモ"), displayMode: .inline)
                    .navigationBarItems(
                        leading: HStack {
                            TimerButton()
                                .environmentObject(TimeManager())
                        },
                    trailing: HStack {
                        Button(action: deleteDrawing) {
                            Image(systemName: "trash")
                        }
                    })
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}


private extension DrawingView {

    func saveDrawing() {
        let image = canvasView.drawing.image(
            from: canvasView.bounds, scale: UIScreen.main.scale)
        let rendition = Rendition(
            title: "Best Drawing",
            drawing: canvasView.drawing,
            image: image)
        self.rendition = rendition
    }

    func deleteDrawing() {
        canvasView.drawing = PKDrawing()
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView()
    }
}
