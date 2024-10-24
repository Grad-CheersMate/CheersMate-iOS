//
//  EmailSearchFailureView.swift
//  CheersMate
//
//  Created by 재훈 on 10/25/24.
//

import UIKit

final class EmailSearchFailureView: UIView {

    // 사용자 안내 레이블
    private let infoLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = "이메일 찾기에\n실패하였습니다."
        lb.setLineSpacing(spacing: 3)
        lb.numberOfLines = 2
        lb.font = UIFont.gmarketSans(size: 25, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 이메일 주소 레이블
    private let emailLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = "가입된 이메일 주소"
        lb.font = UIFont.gmarketSans(size: 14, family: .Medium)
        lb.textAlignment = .left
        return lb
    }()
    
    // 이메일 입력 창
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont.pretendard(size: 16, family: .SemiBold)
        tf.text = "없음"
        tf.textColor = .red
        tf.isEnabled = false
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.contentVerticalAlignment = .center
        return tf
    }()
    
    // 이메일 입력 창이 클릭됬을 때 표시하는 언더라인
    var emailUnderLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.mainColor
        view.clipsToBounds = true
        return view
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
        
        [infoLabel, emailLabel, emailTextField, emailUnderLine]
            .forEach { self.addSubview($0) }
        
    } // closed setupUI
    
    // MARK: - Layout 설정
    private func setupLayout() {
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(40)
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
    } // closed setupLayout

}
