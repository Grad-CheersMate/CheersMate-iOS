//
//  HomeView.swift
//  CheersMate
//
//  Created by 재훈 on 10/25/24.
//

import UIKit

public final class HomeView: UIView {
    
    // 네비게이션 왼쪽 바 버튼 아이템 - 메인 타이틀
    public let leftBarLabel: UILabel = {
        let lb = UILabel()
        lb.text = "CheersMate"
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 23, family: .Bold)
        lb.textColor = .mainNavyColor
        return lb
    }()
    
    // 네비게이션 오른쪽 바 버튼 아이템 - 돋보기 이미지
    public let rightBarSearchButton: UIButton =  {
        let bt = UIButton(type: .custom)
        bt.setImage(UIImage(named: "search"), for: .normal)
        bt.tintColor = .mainNavyColor
        return bt
    }()
    
    // 네비게이션 오른쪽 바 버튼 아이템 - 종 이미지
    public let rightBarBellButton: UIButton =  {
        let bt = UIButton(type: .custom)
        bt.setImage(UIImage(named: "bell"), for: .normal)
        bt.tintColor = .mainNavyColor
        return bt
    }()
    
    // 네비게이션 오른쪽 바 버튼을 담고 있는 스택 뷰
    public lazy var rightBarButtonStackview: UIStackView = {
        let sv = UIStackView.init(arrangedSubviews: [rightBarSearchButton, rightBarBellButton])
        sv.distribution = .equalSpacing
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 25
        return sv
    }()
    
    // 제목 label을 네비게이션 바의 왼쪽 아이템으로 설정
    public lazy var leftBarButtonItem = UIBarButtonItem(customView: leftBarLabel)
    
    // 버튼 stackView를 네비게이션 바의 오른쪽 아이템으로 설정
    public lazy var rightBarButtonItem = UIBarButtonItem(customView: rightBarButtonStackview)
    
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
    
    // 날씨 컨테이너 뷰
    private let weatherContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 25
        return v
    }()
    
    // 날씨 메인 안내 레이블
    private let weatherMainInfoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .mainNavyColor
        lb.text = "날씨에 딱 맞는 주류 추천받기"
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 20, family: .Bold)
        lb.textAlignment = .center
        return lb
    }()
    
    // 날씨 서브 안내 레이블
    private let weatherSubInfoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .subTextColor
        lb.text = "위치와 날씨를 분석해 추천해드려요"
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .center
        return lb
    }()
    
    // 날씨 로고 이미지 뷰
    private let weatherImageView: UIImageView = {
        let v = UIImageView()
        v.image = .weather
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.layer.cornerRadius = 20
        return v
    }()
    
    // 날씨 맞춤 추천화면으로 이동하는 버튼
    public let weatherButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("확인하기", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 17, family: .Medium)
        bt.layer.cornerRadius = 12
        bt.backgroundColor = .mainColor
        return bt
    }()
    
    // 카테고리 안내 레이블
    private let categoryInfoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .mainNavyColor
        lb.text = "카테고리"
        lb.numberOfLines = 0
        lb.font = UIFont.gmarketSans(size: 23, family: .Bold)
        lb.textAlignment = .left
        return lb
    }()
    
    //  테이블 뷰
    public let categoryTableView: UITableView = {
        let tv = UITableView()
        tv.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.ID)
        tv.backgroundColor = .white
        tv.rowHeight = 90
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.isScrollEnabled = false
        tv.layer.cornerRadius = 25
        return tv
    }()
    
    // 데이터 소스
    public var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
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
        [weatherContainerView, categoryInfoLabel, categoryTableView].forEach { mainContainerView.addSubview($0) }
        [weatherMainInfoLabel, weatherSubInfoLabel, weatherImageView, weatherButton].forEach { weatherContainerView.addSubview($0) }
        
    } // closed setupUI

    // Layout 설정
    private func setupLayout() {
        // 네비게이션 바
        rightBarSearchButton.snp.makeConstraints { make in
            make.height.width.equalTo(20)
        }
        
        rightBarBellButton.snp.makeConstraints { make in
            make.height.width.equalTo(20)
        }
        
        // 스크롤 뷰
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        // 메인 컨테이너 뷰
        mainContainerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
        
        // 날씨
        weatherContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(350)
        }
        
        weatherMainInfoLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        weatherSubInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherMainInfoLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(weatherSubInfoLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        weatherButton.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        // 카테고리
        categoryInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherContainerView.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        
        categoryTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryInfoLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().offset(-30)
            make.centerX.equalToSuperview()
            make.height.equalTo(500)
        }
    
    } // closed setupLayout
    
} // closed Class
