//
//  ListTableViewCell.swift
//  CheersMate
//
//  Created by 재훈 on 11/6/24.
//

import UIKit
import SnapKit

final public class RecommendSelectionTableViewCell: UITableViewCell {
    
    // MARK: - 프로퍼티 설정
    // 셀 아이디
    static let ID = "RecommendSelectionTableViewCell"
    private var status: Bool = false
    
    private let containerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 12
        v.clipsToBounds = true
        return v
    }()
    
    // 이미지 뷰
    private let mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.kf.indicatorType = .activity
        return iv
    }()
    
    // 설명 레이블
    private let descLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = UIColor.textColor
        lb.text = "기쁨"
        lb.font = UIFont.gmarketSans(size: 16, family: .Medium)
        lb.textAlignment = .left
        lb.numberOfLines = 0
        return lb
    }()
    
    // 체크박스: 셀 선택 여부 표시
    private let checkBoxImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "checkmark.circle.fill")
        iv.tintColor = .mainColor
        iv.clipsToBounds = true
        iv.isHidden = true
        return iv
    }()
    
    // MARK: - 오버라이드 함수 설정
    // 셀 재사용: UI 갱신
    public override func prepareForReuse() {
        super.prepareForReuse()
        resetCell()
    } // closed prepareForReuse
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = self.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30))
    } // closed layoutSubviews
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupLayout()
        setupShadow()
    } // closed init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } // closed required init
    
    // MARK: - 기타 함수 설정
    // 외부에서 셀을 변경하기 위한 설정
    public func configure(imageName: String, desc: String) {
        mainImageView.image = UIImage(named: imageName)
        descLabel.text = desc
    } // closed configure
    
    // 셀에 그림자 효과를 설정
    private func setupShadow() {
        contentView.layer.shadowColor = UIColor.systemGray.cgColor
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOffset = CGSize(width: 0, height: 0) // 위치조정
        contentView.layer.shadowRadius = 7 // 반경
        contentView.layer.shadowOpacity = 0.1 // alpha값
    } // closed setupShadow
    
    // 셀의 클릭 여부 판단
    public func isCellSelected(_ condition: Bool) {
        status.toggle()
        setCellActive(status)
    } // closed itemSelected
    
    // 셀의 활성화 여부 판단
    private func setCellActive(_ condition: Bool) {
        condition ? (descLabel.textColor = .mainColor) : (descLabel.textColor = .textColor)
        checkBoxImageView.isHidden = !condition
    } // closed resetCellAppearance
    
    // 셀 리셋
    public func resetCell() {
        descLabel.textColor = .textColor
        checkBoxImageView.isHidden = true
        status = false
    } // closed resetCell
    
} // clsoed ListTableViewCell

// MARK: - 초기 UI와 Layout 설정
extension RecommendSelectionTableViewCell {
    // UI 설정
    private func setupUI() {
        contentView.addSubview(containerView)
        
        [mainImageView, descLabel, checkBoxImageView].forEach { containerView.addSubview($0) }
    } // closed setupUI
    
    // Layout 설정
    private func setupLayout() {
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(20)
            make.width.equalTo(mainImageView.snp.height)
        }
        
        descLabel.snp.makeConstraints { make in
            make.leading.equalTo(mainImageView.snp.trailing).offset(30)
            make.trailing.equalTo(checkBoxImageView.snp.leading)
            make.top.bottom.equalToSuperview().inset(5)
        }
        
        checkBoxImageView.setContentHuggingPriority(.required, for: .horizontal)
        
        checkBoxImageView.snp.makeConstraints { make in
            make.leading.equalTo(descLabel.snp.trailing)
            make.trailing.top.bottom.equalToSuperview().inset(20)
            make.width.equalTo(30)
        }
    } // closed setupLayout
    
} // extension
