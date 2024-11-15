//
//  DetailView.swift
//  CheersMate
//
//  Created by 재훈 on 11/12/24.
//

import UIKit
import SnapKit

public final class RecommendResultView: UIView {
    // MARK: - 프로퍼티 설정
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "추천 결과"
        lb.textColor = UIColor.textColor
        lb.font = UIFont.gmarketSans(size: 20, family: .Bold)
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()
    
    public let dismissButton: UIButton = {
        let bt = UIButton(type: .custom)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .light)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        bt.setImage(image, for: .normal)
        bt.tintColor = .black
        bt.adjustsImageWhenHighlighted = false
        bt.clipsToBounds = true
        return bt
    }()
    
    public lazy var collectionview: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.ID)
        cv.register(HorizontalListCollectionViewCell.self, forCellWithReuseIdentifier: HorizontalListCollectionViewCell.ID)
        cv.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderView.ID)
        return cv
    }()
    
    public var dataSource: UICollectionViewDiffableDataSource<Section, Item>?
    
    // MARK: - 초기화
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        setupDatasource()
    } //closed init
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    } // closed required init
    
    // MARK: - UI 설정
    private func setupUI() {
        self.backgroundColor = .white
        [titleLabel, dismissButton, collectionview].forEach { self.addSubview($0) }
    } // closed setupUI

    // MARK: - Layout 설정
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(15)
            make.centerX.equalToSuperview()
        }
        
        dismissButton.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        collectionview.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
    } // closed setupLayout
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 60 // 섹션 사이 간격 조정
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.dataSource?.sectionIdentifier(for: sectionIndex)
            switch section {
            case .product: // 메인 주류 상품 정보 섹션
                return self.createProductSection()
            case .food, .similar: // 잘 어울리는 음식 섹션 그리고 비슷한 주류 섹션
                return self.createHorizontalSection() // 동일하게 수평 레이아웃 사용
            default:
                return nil
            }
        }, configuration: config)
    } // closed createLayout
    
    // MARK: - 주류 상품의 정보를 보여주는 섹션 레이아웃 설정
    private func createProductSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) // 그룹과 상대적인 사이즈
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(450)) // 섹션과 상대적인 사이즈
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1) // 그룹 안 아이템은 1개만
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // 스크롤 효과 없음
        return section
    } // closed createProductSection
    
    // MARK: - 주류 상품과 어울리는 음식 정보를 보여주는 섹션 레이아웃 설정
    // MARK: - 주류 상품과 비슷한 또 다른 주류 상품을 보여주는 섹션 레이아웃 설정
    private func createHorizontalSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) // 그룹과 상대적인 사이즈
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        //item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10) // 아이템 간 간격
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .absolute(230)) // 섹션과 상대적인 사이즈
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 25
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25)
        section.orthogonalScrollingBehavior = .continuous // 연속적인 스크롤 효과
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
        section.boundarySupplementaryItems = [header]
        return section
    } // closed createFoodSection
    
    // MARK: - 데이터 소스 설정
    private func setupDatasource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionview, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .productItem(let liquordata):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.ID, for: indexPath) as? ProductCollectionViewCell
                cell?.configure(imageURL: liquordata.imageUrl, name: liquordata.name, type: liquordata.type, volume: liquordata.volume)
                return cell
            case .foodItem(let foodData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalListCollectionViewCell.ID, for: indexPath) as? HorizontalListCollectionViewCell
                cell?.configure(imageURL: foodData.imageUrl, name: foodData.name)
                return cell
            case .similarItem(let liquordata):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalListCollectionViewCell.ID, for: indexPath) as? HorizontalListCollectionViewCell
                cell?.configure(imageURL: liquordata.imageUrl, name: liquordata.name)
                return cell
            }
        })
        
        dataSource?.supplementaryViewProvider = {[weak self] collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.ID, for: indexPath)
            let section = self?.dataSource?.sectionIdentifier(for: indexPath.section)

            switch section {
            case .food(let title), .similar(let title):
                (header as? HeaderView)?.configure(title: title)
            default:
                break
            }
            return header
        }
    } // closedsetupDatasource
     
    
} // closed main
