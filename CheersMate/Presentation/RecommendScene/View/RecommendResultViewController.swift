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
    } // closed viewDidLoad
    
    // MARK: - 바인드 뷰
    private func bindView() {
        // X버튼을 눌렀을 때 이벤트 감지 - 팝업 창을 표시하여 사용자에게 별점을 매기도록 유도
        recommendResultView.dismissButton.rx.tap
            .bind(onNext: { [weak self] _ in
                // MARK: - Data Layer
                let realmDB = RealmDB(realm: try! Realm())
                let network = LiquorNetwork(manager: LiquorNetworkManager())
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
        
    } // closed bindView
    
    // MARK: - 바인드 뷰 모델
    private func bindViewModel() {
        
        
    } // closed bindViewModel
    
    // MARK: - 주류 정보 섹션 스냅샷 적용
    private func applySnapshot() {
        // 스냅샷
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        
        // 주류 추천 결과
        let recommendLiquorItems = [Item.productItem(resData.data.recommendLiquor[0].liquor)]
        let productSection = Section.product
        snapshot.appendSections([productSection])
        snapshot.appendItems(recommendLiquorItems, toSection: productSection)
        
        // 어울리는 음식 추천 결과
        
        let foodItems = resData.data.food.map { Item.foodItem($0) }
        //foodItems.append(foodItem)
        let foodSection = Section.food("해당 음식과 잘 어울려요")
        snapshot.appendSections([foodSection])
        snapshot.appendItems(foodItems, toSection: foodSection)
        
        // 비슷한 제품 추천 결과
        let liquorItems = resData.data.similarLiquor.map { Item.similarItem($0.liquor) }
        let similarLiquorItems = liquorItems
        let similarSection = Section.similar("해당 제품과 비슷해요")
        snapshot.appendSections([similarSection])
        snapshot.appendItems(similarLiquorItems, toSection: similarSection)
        
        // 스냅샷 적용
        recommendResultView.dataSource?.apply(snapshot, animatingDifferences: true)
    } // closed applyProductSnapshot
    
} // closed DetailViewController
