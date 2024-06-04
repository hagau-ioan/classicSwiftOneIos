//
//  AlertDialog.swift
//  ClassicSwiftOne
//
//  Created by Hagau Ioan on 03.06.2024.
//

import Foundation
import UIKit

class DialogUseCase: NSObject {
    
    private var dialogController: UIAlertController?
    
    // @escaping is required for closers function which are called async
    func buildAlert(onSuccess: @escaping () -> Void = {}) {
        dialogController = UIAlertController(
            title: "Title window dialog controller",
            message: "Description window dialog controller", preferredStyle: .alert)
        dialogController?.addAction(UIAlertAction(title: "Button Action", style: .default) {_ in
            onSuccess()
        })
    }
    
    // @escaping is required for closers function which are called async
    func buildConfirmation(onSuccess: @escaping (String) -> Void = {_ in }, onDismiss: @escaping () -> Void = {}) {
        dialogController = UIAlertController(
            title: "Title window dialog controller",
            message: "Description window dialog controller", 
            preferredStyle: .alert)
        dialogController?.addTextField() {tf in
            tf.text = "Add a text here" // prefill the input text
        }
        dialogController?.addAction(UIAlertAction(title: "Cancel", style: .default){ _ in
            onDismiss()
        })
        dialogController?.addAction(UIAlertAction(title: "Action", style: .default) {
            [weak dialogController] _ in // dialogController is a self reference of created controller.
            let userInput = dialogController?.textFields?[0].text ?? ""
            // pressing the button will read the input text value and we will pass forward
            onSuccess(userInput)
        })
        dialogController?.dismiss(animated: true) {
            onDismiss()
        }
    }
    
    func show(context: UIViewController?) {
        if let dc = dialogController {
            context?.present(dc, animated: true)
        }
        
    }
}
