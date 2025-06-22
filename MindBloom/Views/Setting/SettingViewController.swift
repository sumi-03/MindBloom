//
//  SettingViewController.swift
//  MindBloom
//
//  Created by 임수미 on 6/22/25.
//


import UIKit
import FirebaseAuth

class SettingViewController: UIViewController {
    
    
    @IBAction func logoutTapped(_ sender: UIButton) {
        logoutAndShowLogin()
    }

    @IBAction func deleteAccountTapped(_ sender: UIButton) {
        deleteAccountAndShowLogin()
    }

    
    private func logoutAndShowLogin() {
        do {
            try Auth.auth().signOut()
            showLoginVC()
        } catch {
            print("로그아웃 실패:", error)
        }
    }

    private func deleteAccountAndShowLogin() {
        guard let user = Auth.auth().currentUser else { return }
        user.delete { [weak self] error in
            if let error = error {
                print("회원탈퇴 실패:", error)
            } else {
                self?.showLoginVC()
            }
        }
    }

    private func showLoginVC() {
        // SceneDelegate 사용(iOS 13+)
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let delegate = scene.delegate as? SceneDelegate,
           let window = delegate.window {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(
                withIdentifier: "LoginViewController"
            )
            window.rootViewController = loginVC
            window.makeKeyAndVisible()
        } else {
            // iOS 12 이하나 SceneDelegate 미사용 프로젝트
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(
                withIdentifier: "LoginViewController"
            )
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true)
        }
    }
}
