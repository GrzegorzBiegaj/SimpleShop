//
//  ConstantsController.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 24.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

protocol ConstantsControllerProtocol {

    var jsonratesKey: String { get }
    var defaultCurrency: String { get }
    var maxProductAmount: Int { get }
}

class ConstantsController: ConstantsControllerProtocol {

    fileprivate let plistStorage: PListStorage
    fileprivate let bundle: Bundle

    // Mark: Public interface

    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
        self.plistStorage = PListStorage(bundle: bundle)
    }

    var jsonratesKey: String {
        return plistStorage.get("JsonratesKey", plistName: "Constants")!
    }

    var defaultCurrency: String {
        return plistStorage.get("DefaultCurrency", plistName: "Constants")!
    }

    var maxProductAmount: Int {
        return Int(exactly: plistStorage.get("MaxProductAmount", plistName: "Constants")! as NSNumber)!
    }

}
