//
//  UIViewController+.swift
//  FioTestApp
//
//  Created by George Ivannikov on 11.07.2021.
//

import UIKit

extension UIViewController {
    func dismissKeyboardAfterTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
