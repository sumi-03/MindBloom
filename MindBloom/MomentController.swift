//
//  MomentController.swift
//  MindBloom
//
//  Created by 임수미 on 6/19/25.
//

import UIKit

class MomentController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    // UIImagePickerController 인스턴스
    private let imagePicker = UIImagePickerController()
    
    // 초기 이미지/폰트 저장용
    private var placeholderImage: UIImage?
    private var initialFont: UIFont?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 초기 상태 이미지 저장
        placeholderImage = imageView.image
        initialFont = textView.font
        
        // 이미지 뷰도 탭 가능하도록 설정
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tap)
        
        // Delegate 설정
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }
    
    // 이미지 뷰 탭 시 호출
    @objc private func imageViewTapped() {
        
        // 사진 라이브러리만 열고 싶으면 .photoLibrary
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            return
        }
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        // 완료되면 UI를 초기 상태로 리셋
        resetUI()
        
        // 실제 저장 로직
    }
    
    private func resetUI() {
        
        // 이미지 원복
        imageView.image = placeholderImage
        
        // 텍스트/폰트 초기화
        textView.text = "음..."
        textView.font = initialFont
        
        // 키보드 내리기
        textView.resignFirstResponder()
    }
    
}

extension MomentController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 사진 선택 완료
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        // 편집된 이미지가 있으면, 없으면 원본
        let key: UIImagePickerController.InfoKey = picker.allowsEditing ? .editedImage : .originalImage
        if let pickedImage = info[key] as? UIImage {
            imageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 취소 버튼 눌렀을 때
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
