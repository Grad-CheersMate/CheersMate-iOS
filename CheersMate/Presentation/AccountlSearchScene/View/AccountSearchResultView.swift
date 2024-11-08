//
//  EmailSearchSuccessView.swift
//  CheersMate
//
//  Created by 재훈 on 10/24/24.
//

import UIKit

final public class AccountSearchResultView: UIView {
    
    // 사용자 안내 레이블
    private let infoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = ""
        lb.setLineSpacing(spacing: 3)
        lb.numberOfLines = 2
        lb.font = UIFont.gmarketSans(size: 25, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 이메일 주소 또는 전화번호 레이블
    private let contactLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = ""
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 이메일 주소 또는 전화번호 결과 창
    public var contactTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.pretendard(size: 16, family: .Medium)
        tf.text = "결과창입니다"
        tf.isEnabled = false
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        return tf
    }()
    
    // 이메일 주소 또는 전화번호 입력 창이 클릭됬을 때 표시하는 언더라인
    public var contactUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainColor
        view.clipsToBounds = true
        return view
    }()
    
    // 완료 버튼
    public let completeButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("", for: .normal)
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
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } // closed init
    
    // MARK: - UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        
        [infoLabel, contactLabel, contactTextField, contactUnderLine, completeButton]
            .forEach { self.addSubview($0) }
        
    } // closed setupUI
    
    // MARK: - Layout 설정
    private func setupLayout() {
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(80)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        contactLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        contactTextField.snp.makeConstraints { make in
            make.top.equalTo(contactLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        
        contactUnderLine.snp.makeConstraints { make in
            make.top.equalTo(contactTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        completeButton.snp.makeConstraints { make in
            make.top.equalTo(contactUnderLine.snp.bottom).offset(100)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    } // closed setupLayout
    
    public func configure(viewType: ViewType, outcome: Outcome) {
        switch (viewType, outcome) {
        case (.searchEmail, .success):
            self.infoLabel.text = "이메일 찾기에\n성공했어요."
            self.contactLabel.text = "이메일 주소"
            self.completeButton.setTitle("로그인하기", for: .normal)
        case (.searchEmail, .failure):
            self.infoLabel.text = "이메일 찾기에\n실패했어요."
            self.contactLabel.text = "이메일 주소"
            self.completeButton.setTitle("뒤로가기", for: .normal)
        case (.searchPassword, .success):
            self.infoLabel.text = "임시 비밀번호를\n전송했어요."
            self.contactLabel.text = "휴대폰 번호"
            self.completeButton.setTitle("로그인하기", for: .normal)
        case (.searchPassword, .failure):
            self.infoLabel.text = "비밀번호 찾기에\n실패했어요."
            self.contactLabel.text = "휴대폰 번호"
            self.completeButton.setTitle("뒤로가기", for: .normal)
        }

    } // closed config
    
} // closed Class
