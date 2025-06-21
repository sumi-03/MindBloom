//
//  LoginViewController.swift
//  MindBloom
//
//  Created by 임수미 on 6/21/25.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines), let pw = passwordTextField.text, !email.isEmpty, !pw.isEmpty else {
            showMessage("이메일/비밀번호를 입력하세요", isError: true)
            return
        }
        // Firebase 로그인
        Auth.auth().signIn(withEmail: email, password: pw) { [weak self] result, error in
            if let error = error {
                // 로그인 실패
                self?.showMessage("로그인 실패: \(error.localizedDescription)", isError: true)
            } else {
                // 로그인 성공 → 루트 변경
                self?.showMessage("로그인 성공!", isError: false)
                self?.goToMain()
            }
        }
    }
    
    private func goToMain() {
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sd = scene.delegate as? SceneDelegate {
            sd.changeRootToMain() // SceneDelegate 함수 그대로 사용
        }
    }


    private func showMessage(_ text: String, isError: Bool) {
        messageLabel.text = text
        messageLabel.textColor = isError ? .systemRed : .systemGreen
        messageLabel.isHidden = false
    }
}
