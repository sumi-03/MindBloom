//
//  MomentRecordViewController.swift
//  MindBloom
//
//  Created by 임수미 on 6/19/25.
//

import UIKit
import Combine

class MomentRecordViewController: UIViewController {
    
    var selectedDate: Date!
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = MomentViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupBindings()
        
        // 선택된 날짜의 모먼트들 불러오기
        viewModel.fetchMoments(for: selectedDate)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        // 셀 높이 고정 (이미지 크기에 맞춰)
        tableView.rowHeight = 80
        tableView.estimatedRowHeight = 80
    }
    
    private func setupBindings() {
        viewModel.$moments
            .receive(on: DispatchQueue.main)
            .sink {
                [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] error in
                if let error = error {
                    self?.showErrorAlert(message: error)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                // 로딩 인디케이터 표시/숨김
                if isLoading {
                    // 로딩 스피너 시작
                } else {
                    // 로딩 스피너 종료
                }
            }
            .store(in: &cancellables)
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    // 이미지 크기를 고정된 사이즈로 리사이즈
    private func resizeImage(_ image: UIImage, to size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    // 플레이스홀더 이미지를 정확한 크기로 생성
    private func createPlaceholderImage(size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { context in
            // 배경색 설정
            UIColor.systemGray5.setFill()
            context.fill(CGRect(origin: .zero, size: size))
            
            // 아이콘 그리기
            if let icon = UIImage(systemName: "photo") {
                let iconSize: CGFloat = size.width * 0.5
                let iconRect = CGRect(
                    x: (size.width - iconSize) / 2,
                    y: (size.height - iconSize) / 2,
                    width: iconSize,
                    height: iconSize
                )
                UIColor.systemGray3.setFill()
                icon.draw(in: iconRect)
            }
        }
    }
}

extension MomentRecordViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        let moment = viewModel.moments[indexPath.row]
        
        // 텍스트 설정
        cell.textLabel?.text = moment.text
        cell.textLabel?.numberOfLines = 0 // 여러 줄 표시
        
        // 기본 플레이스홀더 이미지 (고정 크기로 생성)
        let imageSize = CGSize(width: 60, height: 60)
        let placeholderImage = createPlaceholderImage(size: imageSize)
        cell.imageView?.image = placeholderImage
        
        // 이미지뷰 설정
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.cornerRadius = 8
        
        // 이미지 로딩 (비동기)
        Task {
            do {
                let imageURL = URL(string: moment.image.fullImageURL)!
                let (data, _) = try await URLSession.shared.data(from: imageURL)
                
                if let originalImage = UIImage(data: data) {
                    // 이미지를 정확히 같은 크기로 리사이즈
                    let resizedImage = self.resizeImage(originalImage, to: imageSize)
                    
                    await MainActor.run {
                        // 셀이 재사용되지 않았는지 확인
                        if let currentCell = tableView.cellForRow(at: indexPath) {
                            currentCell.imageView?.image = resizedImage
                        }
                    }
                }
            } catch {
                print("이미지 로딩 실패: \(error)")
            }
        }
        
        return cell
    }
}

extension MomentRecordViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let moment = viewModel.moments[indexPath.row]
        
        // 모먼트 상세보기나 편집 화면으로 이동
        showMomentDetail(moment: moment)
    }
    
    private func showMomentDetail(moment: MomentResponse) {
        let alert = UIAlertController(title: "모먼트", message: moment.text, preferredStyle: .alert)
        
        // 확인 버튼
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        
        // 삭제 버튼 (빨간색)
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            self?.showDeleteConfirmation(for: moment)
        })
        
        present(alert, animated: true)
    }
    
    private func showDeleteConfirmation(for moment: MomentResponse) {
        let confirmAlert = UIAlertController(
            title: "모먼트 삭제",
            message: "이 모먼트를 삭제하시겠습니까?\n삭제된 모먼트는 복구할 수 없습니다.",
            preferredStyle: .alert
        )
        
        // 취소 버튼
        confirmAlert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        // 삭제 버튼
        confirmAlert.addAction(UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            self?.deleteMoment(moment)
        })
        
        present(confirmAlert, animated: true)
    }
    
    private func deleteMoment(_ moment: MomentResponse) {
        Task {
            do {
                // 삭제 요청
                try await viewModel.deleteMoment(id: moment.id)
                
                await MainActor.run {
                    // 성공 알림
                    let successAlert = UIAlertController(
                        title: "삭제 완료",
                        message: "모먼트가 삭제되었습니다.",
                        preferredStyle: .alert
                    )
                    successAlert.addAction(UIAlertAction(title: "확인", style: .default))
                    self.present(successAlert, animated: true)
                }
                
            } catch {
                await MainActor.run {
                    // 실패 알림
                    let errorAlert = UIAlertController(
                        title: "삭제 실패",
                        message: "모먼트 삭제 중 오류가 발생했습니다.\n\(error.localizedDescription)",
                        preferredStyle: .alert
                    )
                    errorAlert.addAction(UIAlertAction(title: "확인", style: .default))
                    self.present(errorAlert, animated: true)
                }
            }
        }
    }
}
