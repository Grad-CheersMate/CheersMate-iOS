//
//  DetailViewController.swift
//  CheersMate
//
//  Created by 재훈 on 11/12/24.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

final public class RecommendResultViewController: UIViewController {
    
    private let recommendResultView = RecommendResultView()
    private let viewModel: RecommendResultViewModelProtocol
    private let resData: RecommendResponse
    private let disposeBag = DisposeBag()

    // MARK: - 뷰 교체
    public override func loadView() {
        self.view = recommendResultView
    } // closed loadView
    
    public init(viewModel: RecommendResultViewModelProtocol, data: RecommendResponse) {
        self.viewModel = viewModel
        self.resData = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        bindView()
        applySnapshot()
    }
    
    // 바인드 뷰
    private func bindView() {
        // X버튼을 눌렀을 때 이벤트 감지 - 팝업 창을 표시하여 사용자에게 별점을 매기도록 유도
        recommendResultView.dismissButton.rx.tap
            .bind(onNext: { [weak self] _ in
                // MARK: - Data Layer
                let realmDB = RealmDB(realm: try! Realm())
                let network = RecommendNetwork(manager: RecommendNetworkManager())
                // MARK: - Domain Layer
                let recommendRP = RecommendRepository(network: network, realm: realmDB)
                let recommendUC = RecommendUseCase(repository: recommendRP)
                // MARK: - Presentation Layer
                let recommendEvaluateVM = RecommendEvaluateViewModel(useCase: recommendUC)
                let recommendEvaluateVC = RecommendEvaluateViewController(viewModel: recommendEvaluateVM)
                recommendEvaluateVC.modalPresentationStyle = .overFullScreen
                recommendEvaluateVC.modalTransitionStyle = .crossDissolve // 흐릿하게 전환해주는 효과
                self?.present(recommendEvaluateVC, animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
    // 바인드 뷰 모델
    private func bindViewModel() {
        
        
    }
    
    // applySnapshot
    private func applySnapshot() {
        // 스냅샷
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        
        // 주류 추천 결과
        let recommendLiquorItems = [Item.productItem(resData.data.recommendLiquor[0].liquor)]
        let productSection = Section.recommendMain
        snapshot.appendSections([productSection])
        snapshot.appendItems(recommendLiquorItems, toSection: productSection)
        
        // 어울리는 음식 추천 결과
        let foodItems = resData.data.food.map { Item.foodItem($0) }
        //foodItems.append(foodItem)
        let foodSection = Section.recommendFood("완벽한 페어링, 이 음식은 어때요?")
        snapshot.appendSections([foodSection])
        snapshot.appendItems(foodItems, toSection: foodSection)
        
        // 비슷한 제품 추천 결과
        let similarLiquorItems = resData.data.similarLiquor.map { Item.similarItem($0.liquor) }
        let similarSection = Section.recommendSimilar("더 다양한 선택을 즐겨보세요")
        snapshot.appendSections([similarSection])
        snapshot.appendItems(similarLiquorItems, toSection: similarSection)
        
        // 스냅샷 적용
        recommendResultView.dataSource?.apply(snapshot, animatingDifferences: true)
    }
    
} // closed DetailViewController
