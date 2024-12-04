//
//  ProfileView.swift
//  CheersMate
//
//  Created by 재훈 on 11/28/24.
//

import UIKit
import SnapKit

public final class ProfileView: UIView {
    
    // 프로필 사진
    public let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = .seulgi
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    // 사진 변경 버튼
    public let editProfileButton: UIButton =  {
        let bt = UIButton(type: .custom)
        bt.setImage(UIImage(named: "landscape")?.withRenderingMode(.alwaysTemplate), for: .normal)
        bt.tintColor = .buttonColor
        bt.adjustsImageWhenHighlighted = false
        return bt
    }()
    
    // 닉네임 레이블
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTextColor
        label.text = "닉네임"
        label.font = UIFont.gmarketSans(size: 15, family: .Medium)
        label.textAlignment = .left
        return label
    }()
    
    // 닉네임 입력 창
    public let nicknameTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.gmarketSans(size: 16, family: .Medium)
        tf.text = "강슬기"
        tf.placeholder = "닉네임"
        tf.backgroundColor = .textFieldBackgroundColor
        tf.textColor = .mainTextColor
        tf.layer.borderColor = UIColor.textFieldLayerColor.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        tf.leftPadding()
        return tf
    }()
    
    // 전화번호 레이블
    private let tellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .subTextColor
        label.text = "전화번호"
        label.font = UIFont.gmarketSans(size: 15, family: .Medium)
        label.textAlignment = .left
        return label
    }()
    
    // 전화번호 입력 창
    public let tellTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.gmarketSans(size: 16, family: .Medium)
        tf.text = "01012345678"
        tf.placeholder = "전화번호"
        tf.backgroundColor = .textFieldBackgroundColor
        tf.textColor = .mainTextColor
        tf.layer.borderColor = UIColor.textFieldLayerColor.cgColor
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.clipsToBounds = true
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        tf.leftPadding()
        return tf
    }()
    
    // 수정하기 버튼
    public var editButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("수정 완료", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 17, family: .Medium)
        bt.layer.cornerRadius = 16
        bt.backgroundColor = .mainColor
        return bt
    }()
    
    // layoutSubviews
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutIfNeeded()
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2 // 이미지 둥글게 처리
    }
    
    // init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        [profileImageView, editProfileButton, nicknameLabel, nicknameTextField, tellLabel, tellTextField, editButton].forEach { self.addSubview($0) }
    }
    
    // Layout 설정
    private func setupLayout() {
        
        // 프로필 사진
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(25)
            make.leading.trailing.equalToSuperview().inset(100)
            make.centerX.equalToSuperview()
            make.height.equalTo(profileImageView.snp.width)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.trailing.bottom.equalTo(profileImageView)
        }
        
        // 닉네임 레이블
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(60)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        // 닉네임 텍스트필드
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(53)
        }
        
        // 전화번호 레이블
        tellLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        // 전화번호 텍스트필드
        tellTextField.snp.makeConstraints { make in
            make.top.equalTo(tellLabel.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(53)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(tellTextField.snp.bottom).offset(30)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(40)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(55)
        }
        
    }
    
} // closed ProfileView
