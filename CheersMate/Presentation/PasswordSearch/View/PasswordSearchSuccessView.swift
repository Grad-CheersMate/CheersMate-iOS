//
//  PasswordSearchSuccessView.swift
//  CheersMate
//
//  Created by 재훈 on 10/25/24.
//

import UIKit

final class PasswordSearchSuccessView: UIView {

    // 사용자 안내 레이블
    private let infoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = "임시 비밀번호를\n전송했어요."
        lb.setLineSpacing(spacing: 3)
        lb.numberOfLines = 2
        lb.font = UIFont.gmarketSans(size: 25, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 이메일 주소 레이블
    private let tellLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = "전송받은 휴대폰 번호"
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 이메일 입력 창
    let tellTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.pretendard(size: 16, family: .SemiBold)
        tf.text = "010-1234-5678"
        tf.isEnabled = false
        tf.contentVerticalAlignment = .center
        return tf
    }()
    
    // 이메일 입력 창이 클릭됬을 때 표시하는 언더라인
    var tellUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainColor
        view.clipsToBounds = true
        return view
    }()
    
    // 로그인 하기 버튼
    let logInButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("로그인 하기", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 17, family: .Medium)
        bt.layer.cornerRadius = 8
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
        
        [infoLabel, tellLabel, tellTextField, tellUnderLine, logInButton]
            .forEach { self.addSubview($0) }
        
    } // closed setupUI
    
    // MARK: - Layout 설정
    private func setupLayout() {
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(80)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        tellLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(60)
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
        
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(tellUnderLine.snp.bottom).offset(100)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
        }
    } // closed setupLayout

}
