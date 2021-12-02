//
//  ImagePicker.swift
//  LetsTell
//
//  Created by Елизавета Котлова on 03.04.2021.
//

import SwiftUI
import RxSwift

class ImagePicker: ObservableObject {
    static let shared = ImagePicker()
    private init() {}
    
    let view = ImagePicker.View()
    let coordinator = ImagePicker.Coordinator()
    
    let willChange = PublishSubject<Image?>()
    @Published var image: Image? = nil {
        didSet {
            if image != nil {
                willChange.onNext(image)
            }
        }
    }
    
}

extension ImagePicker {
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                ImagePicker.shared.image = Image(uiImage: image)
            }
            picker.dismiss(animated: true)
        }
    }
}

extension ImagePicker {
    struct View: UIViewControllerRepresentable {
        
        func makeCoordinator() -> Coordinator {
            ImagePicker.shared.coordinator
        }
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker.View>) -> UIImagePickerController {
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = context.coordinator
            return imagePickerController
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker.View>) {
        
        }
        
    }
}
