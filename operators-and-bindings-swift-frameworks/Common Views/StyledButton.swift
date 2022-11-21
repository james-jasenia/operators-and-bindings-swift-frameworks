//
//  StyledButton.swift
//  operators-and-bindings-swift-frameworks
//
//  Created by james.jasenia on 20/11/2022.
//

import UIKit

class StyledButton: UIButton {

    open var enabledBackgroundColour: UIColor { .blue }
    open var disabledBackgroundColour: UIColor { .lightGray }

    open var enabledFontColour: UIColor { .white }
    open var disabledFontColour: UIColor { .white }
    
    open var tintColour: UIColor { .white }

    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.hidesWhenStopped = true
        view.color = .white
        return view
    }()

    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? enabledBackgroundColour : disabledBackgroundColour
        }
    }
    
    var normalTitle: String {
        get {
            title(for: .normal) ?? ""
        }
        
        set {
            setTitle(newValue, for: .normal)
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            isLoadingIndicatorEnabled(isLoading)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        styleView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        styleView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        styleView()
    }

    func styleView() {
        titleLabel?.lineBreakMode = .byTruncatingTail
        titleLabel?.textAlignment = .center
        titleLabel?.adjustsFontForContentSizeCategory = true

        backgroundColor = enabledBackgroundColour

        setTitleColor(enabledFontColour, for: .normal)
        setTitleColor(disabledFontColour, for: .disabled)

        tintColor = tintColour

        layer.cornerRadius = {
            let shorterSide: CGFloat = layer.frame.height < layer.frame.width ? layer.frame.height : layer.frame.width
            return shorterSide / 2
        }()

        positionActivityIndicatorInButton()
    }

    func isLoadingIndicatorEnabled(_ shouldShow: Bool) {
        if shouldShow {
            activityIndicator.startAnimating()
            isEnabled = false
        } else {
            activityIndicator.stopAnimating()
            isEnabled = true
        }
    }

    private func positionActivityIndicatorInButton() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)

        let trailingConstraint = NSLayoutConstraint(item: self,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: activityIndicator,
                                                    attribute: .trailing,
                                                    multiplier: 1, constant: 16)
        addConstraint(trailingConstraint)

        let yCenterConstraint = NSLayoutConstraint(item: self,
                                                   attribute: .centerY,
                                                   relatedBy: .equal,
                                                   toItem: activityIndicator,
                                                   attribute: .centerY,
                                                   multiplier: 1, constant: 0)
        addConstraint(yCenterConstraint)
    }
}
