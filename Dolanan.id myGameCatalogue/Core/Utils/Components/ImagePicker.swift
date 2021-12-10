//
//  ImagePicker.swift
//  Dolanan.id myGameCatalogue
//
//  Created by Dimas Putro on 23/11/21.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

  var sourceType: UIImagePickerController.SourceType = .photoLibrary // default
  @Binding var selectedImageData: Data

  @Environment(\.presentationMode) private var presentation

  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIViewController {
    let imagePicker = UIImagePickerController()
    imagePicker.allowsEditing = false
    imagePicker.sourceType = sourceType
    imagePicker.delegate = context.coordinator

    return imagePicker
  }

  class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let parent: ImagePicker

    init(parent: ImagePicker) {
      self.parent = parent
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
      if let selectedImageFromPicker = info[.originalImage] as? UIImage {

        guard let imageData = selectedImageFromPicker.jpegData(compressionQuality: 0.6) else { return }

        let encodedImage = (try? PropertyListEncoder().encode(imageData)) ?? Data()
        self.parent.selectedImageData = encodedImage

        parent.presentation.wrappedValue.dismiss()
      }
    }
  }

  func makeCoordinator() -> Coordinator {
    return Coordinator(parent: self)
  }

  func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<ImagePicker>) {

  }
}
