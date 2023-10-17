//
//  Extensions.swift
//  X-iOS
//
//  Created by Anqi on 2023/10/16.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
