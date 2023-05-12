//
//  SKUsernameTextField.swift
//  Rentify App
//
//  Created by Sanzhar Koshkarbayev on 12.05.2023.
//

import SnapKit
import UIKit

class SKUsernameTextField: UITextField {
    private let checkmarkImageView = UIImageView()
    private let loadingIndicator = UIActivityIndicatorView(style: .medium)
    private let errorLabel = UILabel()
    
    private var isLoading = false {
        didSet {
            if isLoading {
                showLoadingState()
            } else {
                hideLoadingState()
            }
        }
    }
    
    private var timer: Timer?
    private let debounceInterval: TimeInterval = 1.0
    
    private let errorLabelHeight: CGFloat = 20.0
    private var errorLabelBottomConstraint: Constraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSubviews()
    }
    
    private func setupSubviews() {
        font = UIFont.systemFont(ofSize: 17)
        textColor = .black
        
        borderStyle = .roundedRect
        backgroundColor = .white
        layer.cornerRadius = 5
        
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8, height: 1))
        leftViewMode = .always
        
        returnKeyType = .done
        
        checkmarkImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        checkmarkImageView.contentMode = .scaleAspectFit
        rightView = checkmarkImageView
        rightViewMode = .always

        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        errorLabel.textColor = .red
        errorLabel.font = UIFont.systemFont(ofSize: 12.0)
        addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.snp.bottom).offset(4)
            make.height.equalTo(errorLabelHeight)
        }
        
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        guard let username = text, !username.isEmpty else {
            hideCheckmark()
            hideError()
            return
        }
        
        isLoading = true
        
        // Invalidate the previous timer
        timer?.invalidate()
        
        // Start a new timer
        timer = Timer.scheduledTimer(withTimeInterval: debounceInterval, repeats: false, block: { [weak self] _ in
            self?.isLoading = false
            let sanitizedUsername = self?.sanitizeUsername(username) ?? ""
            
            // Check for specific symbols in the username
            if let error = self?.checkForSpecificSymbols(sanitizedUsername) {
                self?.showError(error)
                self?.updateCheckmark(false) // Show x mark
            } else {
                self?.hideError()
                self?.updateCheckmark(true) // Show checkmark
                
                // Send sanitizedUsername to the server for processing
                self?.sendToServer(sanitizedUsername)
            }
        })
    }

    
    private func sanitizeUsername(_ username: String) -> String {
        // Remove any specific symbols or handle specific cases in the username
        // Customize this method based on your specific requirements
        var sanitizedUsername = username
        sanitizedUsername = sanitizedUsername.replacingOccurrences(of: "!", with: "")
        sanitizedUsername = sanitizedUsername.lowercased()
        return sanitizedUsername
    }
    
    private func checkForSpecificSymbols(_ username: String) -> String? {
        let symbolSet = CharacterSet(charactersIn: "!@#$%^&*()_+{}|:<>?-=\\[];',./ ")
        if let range = username.rangeOfCharacter(from: symbolSet) {
            return "Username must not contain specific symbols."
        }
        return nil
    }
    
    private func showError(_ error: String) {
        errorLabel.text = error
        errorLabelBottomConstraint?.update(offset: -errorLabelHeight)
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func hideError() {
        errorLabel.text = nil
        errorLabelBottomConstraint?.update(offset: 0)
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func sendToServer(_ username: String) {
        // Implement your code to send the sanitized username to the server
        // for further processing or username availability check.
        print("Sending username to the server: \(username)")
    }
    
    private func updateCheckmark(_ isUsernameAvailable: Bool) {
        let imageName = isUsernameAvailable ? "checkmark" : "xmark"
        let image = UIImage(systemName: imageName)
        checkmarkImageView.image = image
    }
    
    private func showLoadingState() {
        rightView = loadingIndicator
        loadingIndicator.startAnimating()
    }
    
    private func hideLoadingState() {
        rightView = checkmarkImageView
        loadingIndicator.stopAnimating()
    }
    
    private func hideCheckmark() {
        checkmarkImageView.image = nil
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 8)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 8)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 8)
    }
}
