//
//  TextInputTraitsOptions.swift
//  Utils
//
//  Created by Maksim Sashcheka on 17.04.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

import UIKit

public enum TextInputTraitsOptions {
    case autocapitalizationType(UITextAutocapitalizationType)
    case autocorrectionType(UITextAutocorrectionType)
    case keyboardType(UIKeyboardType)
    case keyboardAppearance(UIKeyboardAppearance)
    case returnKeyType(UIReturnKeyType)
    case contentType(UITextContentType?)
}

extension TextInputTraitsOptions: Hashable {
    private var uniqueKey: Int {
        switch self {
        case .autocapitalizationType: return 0
        case .autocorrectionType: return 1
        case .keyboardAppearance: return 2
        case .keyboardType: return 3
        case .returnKeyType: return 4
        case .contentType: return 5
        }
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(uniqueKey)
    }

    public static func == (lhs: TextInputTraitsOptions, rhs: TextInputTraitsOptions) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

// MARK: Default values
public extension TextInputTraitsOptions {
    static var email: [TextInputTraitsOptions] {
        combine([.autocapitalizationType(.none), .keyboardType(.emailAddress), .contentType(.emailAddress)])
    }
    static var password: [TextInputTraitsOptions] {
        combine([.autocapitalizationType(.none), .contentType(.password)])
    }
    static var name: [TextInputTraitsOptions] {
        combine([.autocapitalizationType(.words), .contentType(.givenName)])
    }
    static var number: [TextInputTraitsOptions] {
        combine([keyboardType(.numberPad)])
    }
    static var search: [TextInputTraitsOptions] {
        combine([.autocorrectionType(.no), .returnKeyType(.search), .contentType(.init(rawValue: .empty))])
    }
    static var cardHolder: [TextInputTraitsOptions] {
        combine([.autocapitalizationType(.allCharacters), .autocorrectionType(.no)])
    }
    static var noOtpPrompt: [TextInputTraitsOptions] {
        combine([keyboardType(.numberPad), .contentType(.username)])
    }

    static var `default`: [TextInputTraitsOptions] {
        [.autocapitalizationType(.sentences),
            .autocorrectionType(.default),
            .keyboardType(.default),
            .keyboardAppearance(.default),
            .returnKeyType(.default),
            .contentType(nil)]
    }

    private static func combine(_ options: [TextInputTraitsOptions]) -> [TextInputTraitsOptions] {
        combine(default: `default`, new: options)
    }

    static func combine(default options: [TextInputTraitsOptions], new: [TextInputTraitsOptions]) -> [TextInputTraitsOptions] {
        var combined = options
        combined.append(contentsOf: new, unique: true)
        return combined
    }
}

public protocol TextInputTraits: AnyObject {
    var textInputTraitsOptions: [TextInputTraitsOptions] { get set }
}

public extension TextInputTraits where Self: UITextField {
    var textInputTraitsOptions: [TextInputTraitsOptions] {
        get {[
            .autocapitalizationType(autocapitalizationType),
            .autocorrectionType(autocorrectionType),
            .keyboardType(keyboardType),
            .keyboardAppearance(keyboardAppearance),
            .returnKeyType(returnKeyType),
            .contentType(textContentType)
        ]}
        set {
            newValue.forEach {
                switch $0 {
                case .autocapitalizationType(let value): autocapitalizationType = value
                case .autocorrectionType(let value): autocorrectionType = value
                case .keyboardType(let value): keyboardType = value
                case .keyboardAppearance(let value): keyboardAppearance = value
                case .returnKeyType(let value): returnKeyType = value
                case .contentType(let value): textContentType = value
                }
            }
        }
    }
}

public extension TextInputTraits where Self: UITextView {
    var textInputTraitsOptions: [TextInputTraitsOptions] {
        get {[
            .autocapitalizationType(autocapitalizationType),
            .autocorrectionType(autocorrectionType),
            .keyboardType(keyboardType),
            .keyboardAppearance(keyboardAppearance),
            .returnKeyType(returnKeyType),
            .contentType(textContentType)
        ]}
        set {
            newValue.forEach {
                switch $0 {
                case .autocapitalizationType(let value): autocapitalizationType = value
                case .autocorrectionType(let value): autocorrectionType = value
                case .keyboardType(let value): keyboardType = value
                case .keyboardAppearance(let value): keyboardAppearance = value
                case .returnKeyType(let value): returnKeyType = value
                case .contentType(let value): textContentType = value
                }
            }
        }
    }
}

extension UITextView: TextInputTraits { }
extension UITextField: TextInputTraits { }
