//
//  MomentCellController.swift
//  MindBloom
//
//  Created by 임수미 on 6/19/25.
//

import UIKit

class MomentCellController: UIViewController {
    // 스토리보드에서 연결된 아울렛
    @IBOutlet weak var tableView: UITableView!
    
    // 테이블에 표시할 데이터 배열
    let titles = ["Apple", "Banana", "Cherry"]
    let imageNames = ["a", "b", "c"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 데이터소스 지정
        tableView.dataSource = self
    }
}


extension MomentCellController: UITableViewDataSource {
    
    // 행(셀) 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    // 각 행에 표시할 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 스토리보드에서 지정한 식별자로 재사용 셀 가져오기
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        // 텍스트, 이미지 할당
        cell.textLabel?.text = titles[indexPath.row]
        cell.imageView?.image = UIImage(named: imageNames[indexPath.row])
        
        return cell
    }
}
