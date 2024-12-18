//
//  HomeView.swift
//  CheersMate
//
//  Created by 재훈 on 10/25/24.
//

import UIKit

public final class HomeView: UIView {
    
    // 네비게이션 왼쪽 바 버튼 아이템 - 메인 타이틀
    public let leftBarLabel: UILabel = {
        let lb = UILabel()
        lb.text = "CheersMate"
        lb.font = UIFont.Moneygraphy(size: 24)
        lb.textColor = .selectedIconColor
        return lb
    }()
    
    // 네비게이션 오른쪽 바 버튼 아이템 - 하트 이미지
    public let rightBarSearchButton: UIButton =  {
        let bt = UIButton(type: .custom)
        bt.setImage(UIImage(named: "heart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        bt.tintColor = .normalIconColor
        return bt
    }()
    
    // 네비게이션 오른쪽 바 버튼 아이템 - 종 이미지
    public let rightBarBellButton: UIButton =  {
        let bt = UIButton(type: .custom)
        bt.setImage(UIImage(named: "bell")?.withRenderingMode(.alwaysTemplate), for: .normal)
        bt.tintColor = .normalIconColor
        return bt
    }()
    
    // 네비게이션 오른쪽 바 버튼을 담고 있는 스택 뷰
    public lazy var rightBarButtonStackview: UIStackView = {
        let sv = UIStackView.init(arrangedSubviews: [rightBarSearchButton, rightBarBellButton])
        sv.distribution = .equalSpacing
        sv.axis = .horizontal
        sv.alignment = .center
        sv.spacing = 25
        return sv
    }()
    
    // 제목 label을 네비게이션 바의 왼쪽 아이템으로 설정
    public lazy var leftBarButtonItem = UIBarButtonItem(customView: leftBarLabel)
    
    // 버튼 stackView를 네비게이션 바의 오른쪽 아이템으로 설정
    public lazy var rightBarButtonItem = UIBarButtonItem(customView: rightBarButtonStackview)
    
    // 스크롤 뷰
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = .clear
        sv.showsVerticalScrollIndicator = true
        sv.showsHorizontalScrollIndicator = false
        sv.isDirectionalLockEnabled = true
        sv.alwaysBounceVertical = true
        return sv
    }()
    
    // 메인 컨테이너 뷰
    private let mainContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        return v
    }()
    
    // 날씨 컨테이너 뷰
    private let weatherContainerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 25
        return v
    }()
    
    // 날씨 메인 안내 레이블
    private let weatherMainInfoLabel: UILabel = {
        let lb = UILabel()
        lb.text = "지금 날씨와 어울리는 주류는?"
        lb.font = .gmarketSans(size: 19, family: .Medium)
        lb.textColor = .mainTextColor
        lb.textAlignment = .center
        return lb
    }()
    
    // 날씨 서브 안내 레이블
    private let weatherSubInfoLabel: UILabel = {
        let lb = UILabel()
        lb.text = "현재 위치를 기반으로 추천해 드릴게요"
        lb.font = UIFont.gmarketSans(size: 13, family: .Medium)
        lb.textColor = .subTextColor
        lb.textAlignment = .center
        return lb
    }()
    
    // 날씨 로고 이미지 뷰
    private let weatherImageView: UIImageView = {
        let v = UIImageView()
        v.image = .weather
        v.contentMode = .scaleAspectFit
        v.clipsToBounds = true
        v.layer.cornerRadius = 20
        return v
    }()
    
    // 날씨 맞춤 추천화면으로 이동하는 버튼
    public let weatherButton: UIButton = {
        let bt = UIButton(type: .custom)
        bt.setTitle("확인하기", for: .normal)
        bt.setTitleColor(.white, for: .normal)
        bt.titleLabel?.font = UIFont.gmarketSans(size: 17, family: .Medium)
        bt.layer.cornerRadius = 12.5
        bt.backgroundColor = .mainColor
        return bt
    }()
    
    //  컬렉션 뷰
    public lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        cv.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.ID)
        cv.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.ID)
        cv.register(TitleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: TitleHeaderView.ID)
        cv.backgroundColor = .backgroundColor
        cv.clipsToBounds = true
        cv.isScrollEnabled = false
        cv.layer.cornerRadius = 25
        return cv
    }()
    
    // 데이터 소스
    public var dataSource: UICollectionViewDiffableDataSource<HomeSection, HomeItem>!
    
    // init
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        setupDatasource()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // UI 설정
    private func setupUI() {
        self.backgroundColor = .backgroundColor
        [scrollView].forEach { self.addSubview($0) }
        [mainContainerView].forEach { scrollView.addSubview($0) }
        [weatherContainerView, collectionView].forEach { mainContainerView.addSubview($0) }
        [weatherMainInfoLabel, weatherSubInfoLabel, weatherImageView, weatherButton].forEach { weatherContainerView.addSubview($0) }
        
    }

    // Layout 설정
    private func setupLayout() {
        // 네비게이션 바
        rightBarSearchButton.snp.makeConstraints { make in
            make.height.width.equalTo(21)
        }
        
        rightBarBellButton.snp.makeConstraints { make in
            make.height.width.equalTo(21)
        }
        
        // 스크롤 뷰
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        
        // 메인 컨테이너 뷰
        mainContainerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
        
        // MARK: - 섹션 1
        weatherContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(350)
        }
        
        weatherMainInfoLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        weatherSubInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherMainInfoLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints { make in
            make.top.equalTo(weatherSubInfoLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
        }
        
        weatherButton.snp.makeConstraints { make in
            make.top.equalTo(weatherImageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
        
        // MARK: - 섹션 2
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(weatherContainerView.snp.bottom).offset(35)
            make.leading.trailing.bottom.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.height.equalTo(640)
        }
    }
    
    // createLayout
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 35 // 섹션 사이 간격 조정
        
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, _ in
            let section = self?.dataSource.sectionIdentifier(for: sectionIndex)
            switch section {
            case .category:
                return self?.createCategorySection()
            case .best:
                return self?.createBestSection()
            default:
                return nil
            }
        }, configuration: config)
        
        layout.register(DecorationView.self, forDecorationViewOfKind: DecorationView.ID)
        return layout
    }
    
    // createHeader
    private func createHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(25))
        let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        headerItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
        return headerItem
    }
    
    // createCategorySection
    private func createCategorySection() -> NSCollectionLayoutSection {
        // 아이템 설정
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / 3.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 그룹 설정
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3) // 3열
        
        // 섹션 설정
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 25 // 섹션 내부 그룹 간 간격
        // 헤더가 있을 경우 top의 기준은 헤더이고, 헤더가 없을 경우 top의 기준은 컬렉션 뷰
        // leading, trailing, bottom은 컬렉션 뷰를 기준으로 Inset이 잡힘
        section.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 25, bottom: 25, trailing: 25)
        
        // 데코레이션 뷰 설정
        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: DecorationView.ID)
        // 섹션 전체를 기준으로 Inset이 잡힘(헤더의 존재와 독립적)
        decorationItem.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0)
        section.decorationItems = [decorationItem]
        
        // 헤더 설정
        let header = createHeader()
        section.boundarySupplementaryItems = [header]
        section.supplementariesFollowContentInsets = false
        return section
    }
    
    // createBestSection
    private func createBestSection() -> NSCollectionLayoutSection {
        // 아이템 설정
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        // 그룹 설정
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        
        // 섹션 설정
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 25, bottom: 25, trailing: 25) // 컬렉션 뷰에 대해 상대적 inset
        section.orthogonalScrollingBehavior = .groupPagingCentered // 스크롤 방식
        
        // 데코레이션 뷰 설정
        let decorationItem = NSCollectionLayoutDecorationItem.background(elementKind: DecorationView.ID)
        decorationItem.contentInsets = NSDirectionalEdgeInsets(top: 40, leading: 0, bottom: 0, trailing: 0) // 상단 간격 추가
        section.decorationItems = [decorationItem]
        
        // 헤더 설정
        let header = createHeader()
        section.boundarySupplementaryItems = [header]
        section.supplementariesFollowContentInsets = false
        return section
    }
    
    // setupDatasource
    private func setupDatasource() {
        dataSource = UICollectionViewDiffableDataSource<HomeSection, HomeItem>(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .categoryItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.ID, for: indexPath) as? CategoryCollectionViewCell
                cell?.configure(imageName: item.imageName, title: item.title, productType: item.productType)
                return cell
            case .bestItem(let item):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.ID, for: indexPath) as? ProductCollectionViewCell
                cell?.updateLiquorImage(150)
                cell?.configure(liquor: item)
                return cell
            }
        })

        dataSource.supplementaryViewProvider = { [weak self] collectionView, kind, indexPath -> UICollectionReusableView in
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TitleHeaderView.ID, for: indexPath)
            let section = self?.dataSource.sectionIdentifier(for: indexPath.section)
            
            switch section {
            case .category(let title):
                (header as? TitleHeaderView)?.configure(title: title, isSubButtonHidden: true)
            case .best(let title):
                (header as? TitleHeaderView)?.configure(title: title, isSubButtonHidden: false)
            default:
                break
            }
            return header
        }
        
    }
    
} // closed HomeView


#Preview {
    HomeView()
}
