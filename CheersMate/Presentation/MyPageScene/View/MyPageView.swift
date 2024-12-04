//
//  MyPageView.swift
//  CheersMate
//
//  Created by 재훈 on 11/25/24.
//

import UIKit
import SnapKit

public final class MyPageView: UIView {
    
    // 네비게이션 왼쪽 바 버튼 아이템 - 메인 타이틀
    public let leftBarLabel: UILabel = {
        let lb = UILabel()
        lb.text = "내 정보"
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 24, family: .Bold)
        lb.textColor = .mainTextColor
        return lb
    }()
    
    // 네비게이션 바의 왼쪽 아이템으로 설정
    public lazy var leftBarButtonItem = UIBarButtonItem(customView: leftBarLabel)
    
    // 네비게이션 오른쪽 바 버튼 아이템 - 설정 톱니 이미지
    public let rightBarSettingButton: UIButton =  {
        let bt = UIButton(type: .custom)
        bt.setImage(UIImage(named: "gear"), for: .normal)
        bt.tintColor = .mainTextColor
        return bt
    }()
    
    // 네비게이션 바의 오른쪽 아이템으로 설정
    public lazy var rightBarButtonItem = UIBarButtonItem(customView: rightBarSettingButton)
    
    // 스크롤 뷰
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.isDirectionalLockEnabled = true
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // 메인 컨테이너 뷰
    private let mainContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    // 프로필 컨테이너 뷰
    private let profileContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 25
        return v
    }()
    
    // 프로필 사진 이미지 뷰
    private let profileImageView: UIImageView = {
        let v = UIImageView()
        v.image = .seulgi
        v.contentMode = .scaleAspectFill
        v.clipsToBounds = true
        return v
    }()
    
    // 닉네임 + 이메일 스택 뷰
    private lazy var profileStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [nicknameLabel, emailLabel])
        sv.axis = .vertical
        sv.spacing = 10
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.backgroundColor = .white
        return sv
    }()
    
    // 닉네임 레이블
    private let nicknameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .mainTextColor
        lb.text = "강슬기"
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 20, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 이메일 레이블
    private let emailLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .subTextColor
        lb.text = "seulgi@gachon.ac.kr"
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 프로필 수정 버튼
    public let editProfileButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        bt.tintColor = .buttonColor
        bt.backgroundColor = .white
        bt.adjustsImageWhenHighlighted = false // 버튼 클릭 하이라이트 제거
        return bt
    }()
    
    // 좋아요 버튼
    public let heartButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "heart")
        config.imagePadding = 15 // 이미지와 텍스트 사이 간격
        config.imagePlacement = .top // 수직 배치
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        // 폰트 스타일 변경
        var titleAttributes = AttributeContainer()
        titleAttributes.font = UIFont.gmarketSans(size: 14, family: .Medium)
        config.attributedTitle = AttributedString("좋아요", attributes: titleAttributes)
        let bt = UIButton(type: .custom)
        bt.configuration = config
        bt.tintColor = .mainTextColor
        bt.backgroundColor = .white
        bt.layer.cornerRadius = 25
        return bt
    }()
    
    // 북마크 버튼
    public let bookmarkButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "bookmark")
        config.imagePadding = 15 // 이미지와 텍스트 사이 간격
        config.imagePlacement = .top // 수직 배치
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        // 폰트 스타일 변경
        var titleAttributes = AttributeContainer()
        titleAttributes.font = UIFont.gmarketSans(size: 14, family: .Medium)
        config.attributedTitle = AttributedString("추천 목록", attributes: titleAttributes)
        let bt = UIButton(type: .custom)
        bt.configuration = config
        bt.tintColor = .mainTextColor
        bt.backgroundColor = .white
        bt.layer.cornerRadius = 25
        return bt
    }()
    
    // 스택 뷰
    private lazy var dashboardStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [heartButton, bookmarkButton])
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.spacing = 20
        sv.backgroundColor = .backgroundColor
        return sv
    }()
    
    // 좋아요 컨테이너 뷰
    private let leftSubContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 25
        return v
    }()
    
    // 추천 목록 컨테이너 뷰
    private let rightSubContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 25
        return v
    }()
    
    //  테이블 뷰
    public let tableView: UITableView = {
        let tv = UITableView()
        tv.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.ID)
        tv.backgroundColor = .white
        tv.rowHeight = 70
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.isScrollEnabled = false
        tv.layer.cornerRadius = 20
        return tv
    }()
    
    // layoutSubviews
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }

    // init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()

    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .backgroundColor
        [scrollView].forEach { self.addSubview($0) }
        [mainContainerView].forEach { scrollView.addSubview($0) }
        [profileContainerView, dashboardStackView, tableView].forEach { mainContainerView.addSubview($0) }
        [profileImageView, profileStackView, editProfileButton].forEach { profileContainerView.addSubview($0) }
    }

    // Layout 설정
    private func setupLayout() {
        // 스크롤 뷰
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        // 메인 컨테이너 뷰
        mainContainerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
        
        // 프로필 컨테이너
        profileContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(130)
        }
        // 프로필 사진
        profileImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
            make.width.equalTo(profileImageView.snp.height)
        }
        
        // 스택 뷰
        profileStackView.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(25)
            make.centerY.equalToSuperview()
            make.height.equalTo(60)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(profileStackView.snp.trailing).offset(15)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(editProfileButton.snp.width)
        }
        
        // 대시보드 스택 뷰
        dashboardStackView.snp.makeConstraints { make in
            make.top.equalTo(profileContainerView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(dashboardStackView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(300)
        }
    
    }
    
} // closed Class
