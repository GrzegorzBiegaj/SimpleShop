//
//  PListStorage.swift
//  SimpleShop
//
//  Created by Grzegorz Biegaj on 24.04.18.
//  Copyright © 2018 Grzegorz Biegaj. All rights reserved.
//

import Foundation

class PListStorage {

    fileprivate let bundle: Bundle

    // Mark: Public interface
    
    init(bundle: Bundle = Bundle.main) {
        self.bundle = bundle
    }

    func get<T>(_ key: String, plistName: String) -> T? {

        guard let path = bundle.path(forResource: plistName, ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else { return nil }
        return dict[key] as? T
    }
}
