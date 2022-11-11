//
//  UIApplication.swift
//  GeoCode
//
//  Created by Spencer Rafada on 11/10/22.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
