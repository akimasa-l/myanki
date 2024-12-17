//
//  PenKitView.swift
//  myanki
//
//  Created by 劉明正 on 2024/06/12.
//

import SwiftUI
import PencilKit

struct PenKitView: UIViewRepresentable {
    typealias UIViewType = PKCanvasView
    let toolPicker = PKToolPicker()
//    let eraseAll: ()->Void
    let pkcView = PKCanvasView()
    
    func makeUIView(context: Context) -> PKCanvasView {
        toolPicker.addObserver(pkcView)
        toolPicker.setVisible(true, forFirstResponder: pkcView)
        pkcView.becomeFirstResponder()
        return pkcView
    }

    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        if uiView.isHidden{
            toolPicker.setVisible(false, forFirstResponder: uiView)
        }
    }
    func eraseAll(){
        pkcView.drawing = PKDrawing()
        pkcView.drawing = PKDrawing()
        print("erase")
    }
    
}

