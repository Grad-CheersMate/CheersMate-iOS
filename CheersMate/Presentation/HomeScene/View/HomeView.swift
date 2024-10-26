//
//  HomeView.swift
//  CheersMate
//
//  Created by 재훈 on 10/25/24.
//

import UIKit

final class HomeView: UIView {
    
    // 네비게이션 왼쪽 바 버튼 아이템 - 메인 타이틀
    let leftBarLabel: UILabel = {
        let lb = UILabel()
        lb.text = "CheersMate"
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 23, family: .Bold)
        lb.textColor = .black // 원하는 색상으로 설정
        return lb
    }()
    
    // 네비게이션 오른쪽 바 버튼 아이템 - 돋보기 이미지
    let rightBarSearchButton: UIButton =  {
        let bt = UIButton(type: .custom)
        bt.setImage(UIImage(named: "search"), for: .normal)
        bt.tintColor = .black
        return bt
    }()
    
    // 네비게이션 오른쪽 바 버튼 아이템 - 종 이미지
    let rightBarBellButton: UIButton =  {
        let bt = UIButton(type: .custom)
        bt.setImage(UIImage(named: "bell"), for: .normal)
        bt.tintColor = .black
        return bt
    }()
    
    // 네비게이션 오른쪽 바 버튼을 담고 있는 스택 뷰
    lazy var rightBarButtonStackview: UIStackView = {
        let sv = UIStackView.init(arrangedSubviews: [rightBarSearchButton, rightBarBellButton])
        sv.distribution = .equalSpacing
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 25
        return sv
    }()
    
    // 제목 label을 네비게이션 바의 왼쪽 아이템으로 설정
    lazy var leftBarButtonItem = UIBarButtonItem(customView: leftBarLabel)
    
    // 버튼 stackView를 네비게이션 바의 오른쪽 아이템으로 설정
    lazy var rightBarButtonItem = UIBarButtonItem(customView: rightBarButtonStackview)

    // MARK: - 초기화
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI 설정
    private func setupUI() {
        self.backgroundColor = .white
    } // closed setupUI

    // MARK: - Layout 설정
    private func setupLayout() {
        rightBarSearchButton.snp.makeConstraints { make in
            make.height.width.equalTo(20)
        }
        
        rightBarBellButton.snp.makeConstraints { make in
            make.height.width.equalTo(20)
        }
    } // closed setupLayout

} // closed Class
