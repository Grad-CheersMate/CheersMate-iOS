//
//  PasswordSearchView.swift
//  CheersMate
//
//  Created by 재훈 on 10/25/24.
//

import UIKit

final class PasswordSearchView: UIView {
    // 사용자 안내 레이블
    private let infoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = "가입 시 등록한 정보를 입력하면 휴대폰 번호로\n임시 비밀번호를 전송해 드릴게요."
        lb.setLineSpacing(spacing: 3)
        lb.numberOfLines = 2
        lb.font = UIFont.gmarketSans(size: 15, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 이메일 주소 레이블
    private let emailLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = "이메일 주소"
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 이메일 입력 창
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.pretendard(size: 16, family: .SemiBold)
        tf.placeholder = "ex) gachon123@gachon.ac.kr"
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        return tf
    }()
    
    // 이메일 입력 창이 클릭됬을 때 표시하는 언더라인
    var emailUnderLine: UIView = {
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
    let tellTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.pretendard(size: 16, family: .SemiBold)
        tf.placeholder = "ex) 010-1234-5678"
        tf.keyboardType = .numbersAndPunctuation
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        return tf
    }()
    
    // 휴대폰 번호 입력 창이 클릭됬을 때 표시하는 언더라인
    var tellUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        return view
    }()
    
    // 이메일 찾기 버튼
    let passwordSearchButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("비밀번호 찾기", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 17, family: .Medium)
        bt.layer.cornerRadius = 8
        //bt.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0.7843137255, blue: 0.8, alpha: 1)
        bt.backgroundColor = .mainColor
        return bt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    } // closed init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } // closed init
    
    // MARK: - UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        
        [infoLabel, emailLabel, emailTextField, emailUnderLine, tellLabel, tellTextField, tellUnderLine, passwordSearchButton]
            .forEach { self.addSubview($0) }
        
    } // closed setupUI

    // MARK: - Layout 설정
    private func setupLayout() {
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        
        emailUnderLine.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        tellLabel.snp.makeConstraints { make in
            make.top.equalTo(emailUnderLine.snp.bottom).offset(40)
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
        
        passwordSearchButton.snp.makeConstraints { make in
            make.top.equalTo(tellUnderLine.snp.bottom).offset(100)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
        }
    } // closed setupLayout
    
} // closed Class
