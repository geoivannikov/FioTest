//
//  UIControl+.swift
//  FioTestApp
//
//  Created by George Ivannikov on 11.07.2021.
//

import UIKit
import Combine

extension UIControl: CombineCompatible { }

extension CombineCompatible where Self: UIControl {
    func publisher(for events: UIControl.Event) -> UIControlPublisher<UIControl> {
        UIControlPublisher(control: self, events: events)
    }
}
