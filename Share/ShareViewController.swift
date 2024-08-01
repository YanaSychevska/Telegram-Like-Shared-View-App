//
//  ShareViewController.swift
//  Share
//
//  Created by Yana Sychevska on 7/31/24.
//

import UIKit
import Social
import SwiftUI
import UniformTypeIdentifiers
import SwiftData

class ShareViewController: UIViewController {
    var hostingController: UIHostingController<ShareView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let extensionItem = extensionContext?.inputItems.first as? NSExtensionItem,
              let itemProvider = extensionItem.attachments?.first as? NSItemProvider else {
            print("No extension items or item providers found.")
            return
        }
        
        let plainTextType = UTType.plainText.identifier
        guard itemProvider.hasItemConformingToTypeIdentifier(plainTextType) else { return }
        itemProvider.loadItem(forTypeIdentifier: plainTextType) { [weak self] (item, error) in
            guard let self else { return }
            if let error = error {
                // Handle error
                print("Error loading item: \(error.localizedDescription)")
            } else if let text = item as? String {
                setSharedView(with: text)
            }
        }
        
        view.backgroundColor = UIColor.clear
        view.isOpaque = false
        modalPresentationStyle = .overCurrentContext
    }
    
    func setSharedView(with text: String) {
        let rootView = ShareView(sharedText: text, onDismiss: dismissAllViews)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let hostingController = UIHostingController(rootView: rootView)
            
            self.addChild(hostingController)
            self.view.addSubview(hostingController.view)
            
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            hostingController.view.backgroundColor = UIColor.clear
            hostingController.view.isOpaque = false
            NSLayoutConstraint.activate([
                hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
                hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
                hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                hostingController.view.heightAnchor.constraint(equalToConstant: 360)
            ])
            hostingController.didMove(toParent: self)
            
            self.hostingController = hostingController
        }
    }
    
    func dismissAllViews() {
        extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
}
