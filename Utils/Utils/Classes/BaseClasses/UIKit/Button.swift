//
//  Button.swift
//  Utils
//
//  Created by Maksim Sashcheka on 14.09.22.
//  Copyright © 2022 BSUIR. All rights reserved.
//

import Combine
import UIKit.UIButton
import SnapKit

open class Button: UIButton {
    public var cornerRadius: CGFloat {
        get { layer.cornerRadius }
        set { layer.cornerRadius = newValue }
    }
    
    public var textColor: UIColor {
        get { titleLabel?.textColor ?? .black }
        set { setTitleColor(newValue, for: .normal) }
    }
    
    public var text: String {
        get { titleLabel?.text ?? .empty }
        set { setTitle(newValue, for: .normal) }
    }
    
    public var font: UIFont {
        get { titleLabel?.font ?? UIFont() }
        set { titleLabel?.font = newValue }
    }
    
    open var cancellables: [AnyCancellable] = []
    
    public convenience init(image: UIImage? = nil,
                            title: String = .empty,
                            backgroundColor: UIColor = .clear) {
        self.init()
        
        setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        setupContent()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupContent()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupContent()
    }
    
    public static func make(_ closure: (Button) -> Void) -> Button {
        let button = Button()
        closure(button)
        return button
    }
    
    private func setupContent() {
        imageView?.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
}
