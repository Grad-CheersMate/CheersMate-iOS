//
//  MyPageViewController.swift
//  CheersMate
//
//  Created by 재훈 on 10/26/24.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate struct Settings {
    let mainImageText: String
    let descText: String
}

public final class MyPageViewController: UIViewController {
    // 프로퍼티
    private let myPageView = MyPageView()
    private let disposeBag = DisposeBag()
    
    // loadView
    public override func loadView() {
        self.view = myPageView
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setupTableView()
        bindView()
    }
    
    // 네비게이션 설정
    private func setupNavi() {
        // 뒤로가기 버튼
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .mainTextColor
        self.navigationItem.backBarButtonItem = backBarButtonItem
        // 네비게이션 바의 왼쪽과 오른쪽 설정
        navigationItem.leftBarButtonItem = myPageView.leftBarButtonItem
        navigationItem.rightBarButtonItem = myPageView.rightBarButtonItem
    }
    
    // 테이블 뷰 설정
    private func setupTableView() {
        let items = Observable<[Settings]>.just([
            Settings(mainImageText: "lock", descText: "비밀번호 변경"),
            Settings(mainImageText: "megaphone", descText: "공지사항"),
            Settings(mainImageText: "question", descText: "자주 묻는 질문"),
            Settings(mainImageText: "plane", descText: "1:1 문의하기"),
            Settings(mainImageText: "delete", descText: "회원탈퇴"),
            Settings(mainImageText: "exit", descText: "로그아웃"),
        ])
        
        updateTableViewHeight(cellCount: 6)
        
        items
            .bind(to: myPageView.tableView.rx.items(cellIdentifier: SettingTableViewCell.ID, cellType: SettingTableViewCell.self)) { row, element, cell in
                cell.configure(imageText: element.mainImageText, descText: element.descText)
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
    }
    
    // 아이템 수에 따른 테이블 뷰 높이 제약 업데이트
    private func updateTableViewHeight(cellCount: Int) {
        myPageView.tableView.snp.updateConstraints { make in
            make.height.equalTo(cellCount * 70)
        }
    }
    
    // 바인드 뷰
    private func bindView() {
        // 프로필 수정 버튼 클릭 이벤트 감지
        myPageView.editProfileButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                let profileVC = ProfileViewController()
                profileVC.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(profileVC, animated: true) // 프로필 수정 화면으로 이동
            })
            .disposed(by: disposeBag)
        
        // 좋아요 버튼 클릭 이벤트 감지
        myPageView.heartButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                print("heartButton tapped") // 좋아요 화면으로 전환
            })
            .disposed(by: disposeBag)
        
        // 추천목록 버튼 클릭 이벤트 감지
        myPageView.bookmarkButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
                print("bookmarkButton tapped") // 추천 목록 화면으로 전환
            })
            .disposed(by: disposeBag)
    }
    
    // 바인드 뷰 모델
    private func bindViewModel() {
        
    }

    

} // closed MyPageViewController
