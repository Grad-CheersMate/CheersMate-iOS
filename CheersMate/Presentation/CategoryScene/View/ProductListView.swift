//
//  ProductView.swift
//  CheersMate
//
//  Created by 재훈 on 11/19/24.
//

import UIKit

public final class ProductListView: UIView {
    //  컬렉션 뷰
    public lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.ID)
        cv.backgroundColor = .backgroundColor
        cv.clipsToBounds = true
        return cv
    }()
    // 영역을 구분하기 위한 뷰
    public let seperateView: UIView = {
        let view = UIView()
        view.backgroundColor = .buttonColor
        view.clipsToBounds = true
        return view
    }()
    public var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    // init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        setupDataSource()
    }
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .backgroundColor
        [seperateView, collectionView].forEach { self.addSubview($0) }
        
    }
    // Layout 설정
    private func setupLayout() {
        
        seperateView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(1)
            make.leading.trailing.centerX.equalToSuperview()
            make.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(seperateView.snp.bottom).offset(5)
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
} // closed Class
