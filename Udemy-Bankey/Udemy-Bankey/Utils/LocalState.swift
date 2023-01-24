//
//  LocalState.swift
//  Udemy-Bankey
//
//  Created by jimi bird on 2023-01-24.
//

import Foundation

public class LocalState {
    private enum Keys: String {
        case hasOnboarding
    }
    
    public static var hasOnboarding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Keys.hasOnboarding.rawValue)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.hasOnboarding.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
