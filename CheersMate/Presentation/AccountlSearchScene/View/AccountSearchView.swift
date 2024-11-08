//
//  SearchingEmailView.swift
//  CheersMate
//
//  Created by 재훈 on 10/24/24.
//

// MARK: - 사용자의 이메일 또는 비밀번호를 찾기 위한 뷰
import UIKit

final public class AccountSearchView: UIView {
    
    // 사용자 안내 레이블
    private let infoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = ""
        lb.setLineSpacing(spacing: 3)
        lb.numberOfLines = 2
        lb.font = UIFont.gmarketSans(size: 15, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 닉네임 또는 이메일 레이블
    private let contactLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = ""
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 닉네임 또는 이메일 입력 창
    public let contactTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.pretendard(size: 16, family: .Medium)
        tf.placeholder = ""
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        return tf
    }()
    
    // 닉네임 또는 이메일 입력 창이 클릭됬을 때 표시하는 언더라인
    public var contactUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        return view
    }()
    
    // 휴대폰 번호 레이블
    private let tellLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = "휴대폰 번호"
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 휴대폰 번호 입력 창
    public let tellTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.pretendard(size: 16, family: .Medium)
        tf.placeholder = "ex) 01012345678"
        tf.keyboardType = .numbersAndPunctuation
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        return tf
    }()
    
    // 휴대폰 번호 입력 창이 클릭됬을 때 표시하는 언더라인
    public var tellUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        return view
    }()
    // 이메일 또는 비밀번호 찾기 버튼
    public let contactSearchButton: UIButton = {
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
        
        [infoLabel, contactLabel, contactTextField, contactUnderLine, tellLabel, tellTextField, tellUnderLine, contactSearchButton]
            .forEach { self.addSubview($0) }
        
    } // closed setupUI

    // MARK: - Layout 설정
    private func setupLayout() {
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
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
        
        tellLabel.snp.makeConstraints { make in
            make.top.equalTo(contactUnderLine.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        tellTextField.snp.makeConstraints { make in
            make.top.equalTo(tellLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        
        tellUnderLine.snp.makeConstraints { make in
            make.top.equalTo(tellTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        contactSearchButton.snp.makeConstraints { make in
            make.top.equalTo(tellUnderLine.snp.bottom).offset(100)
            make.leading.trailing.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
    } // closed setupLayout
    
    // MARK: - 뷰 타입에 따라 텍스트 설정
    public func configure(viewType: ViewType) {
        switch viewType {
        case .searchEmail:
            infoLabel.text = "가입 시 등록한 정보를 입력하면\n이메일 주소를 알려드릴게요."
            contactLabel.text = "닉네임"
            contactSearchButton.setTitle("이메일 찾기", for: .normal)
        case .searchPassword:
            infoLabel.text = "가입 시 등록한 정보를 입력하면 휴대폰 번호로\n임시 비밀번호를 전송해 드릴게요."
            contactLabel.text = "이메일"
            contactTextField.placeholder = "seulgi@gachon.ac.kr"
            contactSearchButton.setTitle("비밀번호 찾기", for: .normal)
        }
    } // closed configure
    
} // closed class
