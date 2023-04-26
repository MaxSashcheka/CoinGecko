//
//  AppPropertiesDataManager.swift
//  Core
//
//  Created by Maksim Sashcheka on 26.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

public class AppPropertiesDataManager {
    public enum Property: String {
        case user
    }
    
    private let userDefaults: UserDefaults
    
    public var user: User? { self[.user] }
    
    public init(group: String) {
        self.userDefaults = UserDefaults(suiteName: group) ?? .standard
    }

    public subscript<Result: AppPropertyCodable>(key: Property) -> Result? {
        get {
            do {
                guard let value = try userDefaults.value(forKey: key.rawValue) as? NSCoding else {
                    return nil
                }
                return Result(appPropertyValue: value)
            } catch {
                return nil
            }
        }
        set {
            userDefaults.set(newValue?.appPropertyValue, forKey: key.rawValue)
        }
    }
}
