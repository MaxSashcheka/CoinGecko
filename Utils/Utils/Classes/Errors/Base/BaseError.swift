//
//  BaseError.swift
//  Utils
//
//  Created by Maksim Sashcheka on 17.06.23.
//  Copyright © 2023 BSUIR. All rights reserved.
//

public protocol BaseErrorCode: RawRepresentable where RawValue == Int { }

open class BaseError<Code: BaseErrorCode>: AnyError {
    public let code: Code
    
    public required init(code: Code,
                         underlying: Error? = nil,
                         message: String? = nil,
                         method: String = #function) {
        self.code = code
        
        super.init(underlying: underlying, message: message, method: method)
    }
    
    open override var codeString: String {
        String(describing: type(of: self)) + "." + String(describing: code)
    }
    
    open override var codeStringShort: String {
        super.codeStringShort + "\(code.rawValue)"
    }
}
