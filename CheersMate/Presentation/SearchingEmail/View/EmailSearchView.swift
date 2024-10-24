//
//  SearchingEmailView.swift
//  CheersMate
//
//  Created by 재훈 on 10/24/24.
//

// MARK: - 사용자의 이메일을 찾기 위한 뷰
import UIKit

final class EmailSearchView: UIView {
    // 사용자 안내 레이블
    private let infoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = "가입 시 등록한 정보를 입력하면\n이메일 주소를 알려드릴게요."
        lb.setLineSpacing(spacing: 3)
        lb.numberOfLines = 2
        lb.font = UIFont.gmarketSans(size: 15, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    // 닉네임 주소 레이블
    private let nickNameLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = "닉네임"
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    // 닉네임 입력 창
    let nickNameTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.pretendard(size: 16, family: .SemiBold)
        tf.placeholder = ""
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        return tf
    }()
    // 닉네임 입력 창이 클릭됬을 때 표시하는 언더라인
    var nickNameUnderLine: UIView = {
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
    let emailSearchButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("이메일 찾기", for: .normal)
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
        
        [infoLabel, nickNameLabel, nickNameTextField, nickNameUnderLine, tellLabel, tellTextField, tellUnderLine, emailSearchButton]
            .forEach { self.addSubview($0) }
        
    } // closed setupUI

    // MARK: - Layout 설정
    private func setupLayout() {
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.top.equalTo(nickNameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(25)
        }
        
        nickNameUnderLine.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        tellLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNameUnderLine.snp.bottom).offset(40)
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
        
        emailSearchButton.snp.makeConstraints { make in
            make.top.equalTo(tellUnderLine.snp.bottom).offset(100)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
        }
        
        
        
    } // closed setupLayout
    
} // closed class
