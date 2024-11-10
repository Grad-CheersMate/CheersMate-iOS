//
//  RecommendListView.swift
//  CheersMate
//
//  Created by 재훈 on 11/5/24.
//

import UIKit

final public class RecommendListView: UIView {
    
    // 컬렉션 뷰를 포함하는 스크롤 뷰
    public let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        sv.isDirectionalLockEnabled = true
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // 컨테이너 뷰
    private let containerView: UIView = {
        let v = UIView()
        return v
    }()
    
    // 테스트 진행 상태 표시 뷰
    public let progressView: UIProgressView = {
        let pv = UIProgressView(progressViewStyle: .default)
        pv.trackTintColor = .progressViewBackgroundColor
        pv.progressTintColor = .mainColor
        pv.progress = 0.20
        pv.layer.cornerRadius = 3
        pv.clipsToBounds = true
        return pv
    }()
    
    // 메인 설명 레이블
    private let mainInfoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .textColor
        lb.text = "오늘 당신의 기분은 어떤가요?"
        lb.font = UIFont.gmarketSans(size: 23, family: .Bold)
        lb.textAlignment = .left
        lb.numberOfLines = 2
        return lb
    }()
    
    // 보충 설명 레이블
    private let subInfoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.systemGray
        lb.text = "가장 비슷한 감정을 선택해 주세요."
        lb.setLineSpacing(spacing: 3)
        lb.numberOfLines = 2
        lb.font = UIFont.gmarketSans(size: 15, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    //  테이블 뷰
    public let tableView: UITableView = {
        let tv = UITableView()
        tv.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.ID)
        tv.backgroundColor = .white
        tv.rowHeight = 120
        tv.separatorStyle = .none
        tv.showsVerticalScrollIndicator = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    // 확인 버튼
    public let completeButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("확인", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 17, family: .Medium)
        bt.layer.cornerRadius = 12
        bt.backgroundColor = .mainColor
        return bt
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    } // closed init
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } // closed required init
    
    
    // MARK: - UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        [scrollView, completeButton].forEach { self.addSubview($0) }
        [containerView].forEach { scrollView.addSubview($0) }
        [mainInfoLabel, subInfoLabel, tableView].forEach { containerView.addSubview($0) }
        
    } // closed setupUI
    
    // MARK: - Layout 설정
    private func setupLayout() {
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(completeButton.snp.top).offset(-20)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            make.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            make.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            make.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
        
        progressView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(7)
        }
        
        mainInfoLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        subInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(mainInfoLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(subInfoLabel.snp.bottom).offset(40)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(400)
        }
        
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(50)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
    } // closed setupLayout
    
    // 페이지에 따른 텍스트와 진행률 설정
    public func configure(page progress: Int) {
        switch progress {
        case 1: // 감정
            updateLabelAndProgressBar(mainText: "오늘 당신의 기분은 어떤가요?", subText: "가장 비슷한 감정을 선택해 주세요.", progress: progress)
        case 2: // 동반자
            updateLabelAndProgressBar(mainText: "오늘 함께할 사람은 누구인가요?", subText: "이 순간을 나누고 싶은 사람을 선택해 주세요.", progress: progress)
        case 3: // 선호 주종
            updateLabelAndProgressBar(mainText: "어떤 주종을 선호하시나요?", subText: "가장 즐기고 싶은 술을 선택해 보세요.", progress: progress)
        case 4: // 선호 도수
            updateLabelAndProgressBar(mainText: "어느 정도의 도수가 좋으신가요?", subText: "선호하는 도수를 선택해 주세요.", progress: progress)
        default:
            break
        }
    } // closed configure
    
    // 추천 화면에서 정보 레이블과 진행률을 업데이트하기 위한 설정
    private func updateLabelAndProgressBar(mainText: String, subText: String, progress: Int) {
        mainInfoLabel.text = mainText
        subInfoLabel.text = subText
        progressView.setProgress(0.20 * Float(progress), animated: true)
    } // closed updateLabelAndProgressBar
    
    
    
} // closed RecommendListView
