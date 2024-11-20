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
        lb.textColor = .mainNavyColor
        lb.font = UIFont.gmarketSans(size: 20, family: .Medium)
        lb.numberOfLines = 0
        lb.textAlignment = .center
        return lb
    }()
    
    public let dismissButton: UIButton = {
        let bt = UIButton(type: .custom)
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 22, weight: .light)
        let image = UIImage(systemName: "xmark", withConfiguration: imageConfig)
        bt.setImage(image, for: .normal)
        bt.tintColor = .mainNavyColor
        bt.adjustsImageWhenHighlighted = false
        bt.clipsToBounds = true
        return bt
    }()
    
    public lazy var collectionview: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.ID)
        cv.register(RecommendFoodCollectionViewCell.self, forCellWithReuseIdentifier: RecommendFoodCollectionViewCell.ID)
        cv.register(TitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderView.ID)
        cv.backgroundColor = .backgroundColor
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
        self.backgroundColor = .backgroundColor
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
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
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
            case .recommendMain: // 추천 주류 메인 섹션
                return self.createRecommendMainSection()
            case .recommendFood: // 함께하면 어울리는 음식 섹션
                return self.createRecommendFoodSection()
            case .recommendSimilar: // 추천 결과와 비슷한 느낌의 주류 섹션
                return self.createRecommendSimilarSection()
            default:
                return nil
            }
        }, configuration: config)
    }
    
    // 섹션 1
    // 추천 결과 화면에서, 추천받은 주류 상품을 보여주기 위한 결과 섹션 레이아웃
    private func createRecommendMainSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) // 그룹과 상대적인 사이즈
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(350)) // 섹션과 상대적인 사이즈
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1) // 그룹 안 아이템은 1개만
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25) // 그룹의 inset
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .none // 스크롤 효과 없음
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0)
        return section
    }
    
    // 섹션 2
    // 추천 결과 화면에서, 추천받은 주류 상품과 어울리는 음식 정보를 보여주는 섹션 레이아웃
    private func createRecommendFoodSection() -> NSCollectionLayoutSection {
        // 아이템 설정
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // 그룹 설정
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.35), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        // 섹션 설정
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 25 // 섹션 내부 그룹 간 간격
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25) // 컬렉션 뷰에 대해 상대적 inset
        section.orthogonalScrollingBehavior = .continuous // 연속적인 스크롤 효과
        // 헤더 설정
        let header = createHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    // 섹션 3
    // 추천 결과 화면에서, 추천받은 주류 상품과 비슷한 주류 상품들을 보여주기 위한 섹션 레이아웃
    private func createRecommendSimilarSection() -> NSCollectionLayoutSection {
        // 아이템 설정
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)) // 그룹에 대해 너비와 높이는 동일한 크기
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        // 그룹 설정
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.65), heightDimension: .absolute(330)) // 섹션에 대해 너비는 0.65%, 높이는 330 크기
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        // group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10) // 그룹의 inset
        // 섹션 설정
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25) // 컬렉션 뷰에 대해 상대적 inset
        section.interGroupSpacing = 25 // 섹션 내부의 그룹 간격
        section.orthogonalScrollingBehavior = .continuous // 연속적인 스크롤 효과
        // 헤더 설정
        let header = createHeader()
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    // 헤더 생성
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        return NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
    }
    
    // 데이터 소스 설정
    private func setupDatasource() {
        self.dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionview, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .productItem(let liquordata), .similarItem(let liquordata):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.ID, for: indexPath) as? ProductCollectionViewCell
                cell?.configure(liquor: liquordata)
                return cell
            case .foodItem(let foodData):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendFoodCollectionViewCell.ID, for: indexPath) as? RecommendFoodCollectionViewCell
                cell?.configure(food: foodData)
                return cell
            }
        })
        
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderView.ID, for: indexPath)
            let section = self?.dataSource?.sectionIdentifier(for: indexPath.section)
            switch section {
            case .recommendFood(let title), .recommendSimilar(let title): // 함께하면 어울리는 음식 섹션과 추천 결과와 비슷한 느낌의 주류 섹션의 헤더 설정
                (header as? TitleHeaderView)?.configure(title: title)
            default:
                break
            }
            return header
        }
    }
     
} // closed RecommendResultView
