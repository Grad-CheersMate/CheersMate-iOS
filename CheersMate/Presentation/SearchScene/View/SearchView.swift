//
//  SearchView.swift
//  CheersMate
//
//  Created by 재훈 on 11/21/24.
//

// MARK: - 사용자가 원하는 주류를 검색하기 위한 검색 화면

import UIKit
import SnapKit

public final class SearchView: UIView {
    
    // 프로퍼티
    // 서치 바
    public let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.autocapitalizationType = .none // 자동 대문자
        sb.autocorrectionType = .no // 자동 수정
        sb.spellCheckingType = .no // 맞춤법 검사
        sb.backgroundColor = .backgroundColor
        sb.searchTextField.backgroundColor = .backgroundColor
        sb.setImage(UIImage(systemName: "magnifyingglass"), for: .search, state: .normal) // 돋보기 이미지 등록
        sb.setImage(UIImage(systemName: "xmark.circle.fill")?.withTintColor(.buttonColor, renderingMode: .alwaysOriginal), for: .clear, state: .normal) // 텍스트 초기화 버튼 이미지 등록
        sb.clipsToBounds = true
        
        if let textField = sb.value(forKey: "searchField") as? UITextField  {
            textField.font = UIFont.pretendard(size: 17, family: .Medium)
            textField.backgroundColor = .textFieldBackgroundColor
            textField.attributedPlaceholder = NSAttributedString(string: "상품을 검색해보세요", attributes: [NSAttributedString.Key.foregroundColor : UIColor.subTextColor])
            textField.textColor = .mainNavyColor
        }
        
        return sb
    }()
    
    // 네비게이션 바의 왼쪽 아이템 설정
    public lazy var rightBarButtonItem = UIBarButtonItem(customView: rightBarButton)
    
    // 네비게이션 왼족 바 버튼 아이템 - 뒤로가기 이미지
    public let rightBarButton: UIButton =  {
        let bt = UIButton(type: .custom)
        bt.setTitle("취소", for: .normal)
        bt.setTitleColor(.mainNavyColor, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 16, family: .Medium)
        return bt
    }()
    
    //  컬렉션 뷰
    public lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.ID)
        cv.backgroundColor = .backgroundColor
        cv.clipsToBounds = true
        //cv.keyboardDismissMode = .onDrag // 드래그할 때 키보드 내리기
        return cv
    }()
    
    // init 설정
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        setupDataSource()
    }
    
    // 데이터 소스
    public var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .backgroundColor
        [searchBar, collectionView].forEach { self.addSubview($0) }
    }

    // Layout 설정
    private func setupLayout() {
        
        searchBar.snp.makeConstraints { make in
            make.edges.centerY.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(5)
            make.leading.trailing.bottom.centerX.equalToSuperview()
        }
        
        
    }
    
    // 컬렉션 뷰의 레이아웃 설정
    private func createLayout() -> UICollectionViewCompositionalLayout {
        // 아이템 설정
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0)) // 그룹에 대해 너비는 절반, 높이는 동일한 크기
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // 그룹 설정
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(330)) // 섹션에 대해 너비는 동일, 높이는 사이즈 지정
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2) // 하나의 수평 그룹에 아이템 2개씩 배치
        group.interItemSpacing = .fixed(8) // 그룹 내부의 아이템 간격
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10) // 그룹의 inset
        // 섹션 설정
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 8 // 섹션 내부의 그룹 간격
        // 레이아웃 설정
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    // 데이터 소스 설정
    private func setupDataSource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .productItem(let liquordata):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.ID, for: indexPath) as? ProductCollectionViewCell
                cell?.configure(liquor: liquordata)
                return cell
            default:
                return UICollectionViewCell()
            }
        })
    }
    
    
} // closed SearchView
