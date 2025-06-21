//
//  SignUpViewController.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBAction func backToLoginButtonTapped(_ sender: UIButton) {
        // 로그인 화면으로 돌아가기
        self.dismiss(animated: true)
    }
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let pw = passwordTextField.text, !email.isEmpty, !pw.isEmpty else {
            showMessage("이메일과 비밀번호를 입력하세요", isError: true)
            return
        }
        
        // Firebase 회원가입
        Auth.auth().createUser(withEmail: email, password: pw) { [weak self] result, error in
            if let error = error {
                self?.showMessage("실패: \(error.localizedDescription)", isError: true)
            } else {
                self?.showMessage("회원가입 성공!", isError: false)
            }
        }
    }
    
    private func showMessage(_ text: String, isError: Bool) {
        messageLabel.text = text
        messageLabel.textColor = isError ? .systemRed : .systemGreen
        messageLabel.isHidden = false
    }
}
