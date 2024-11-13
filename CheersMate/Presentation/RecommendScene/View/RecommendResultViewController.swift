//
//  DetailViewController.swift
//  CheersMate
//
//  Created by 재훈 on 11/12/24.
//

import UIKit
import RxSwift
import RxCocoa

final public class RecommendResultViewController: UIViewController {
    
    private let recommendResultView = RecommendResultView()
    private let disposeBag: DisposeBag = DisposeBag()
    private let resData: RecommendResponse
    
    // MARK: - 뷰 교체
    public override func loadView() {
        self.view = recommendResultView
    } // closed loadView
    
    public init(data: RecommendResponse) {
        self.resData = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        applySnapshot()
    } // closed viewDidLoad
    
    // MARK: - 바인드 뷰
    private func bindView() {
        
    } // closed bindView
    
    // MARK: - 주류 정보 섹션 스냅샷 적용
    private func applySnapshot() {
        // 스냅샷
        var snapshot = NSDiffableDataSourceSnapshot<Section,Item>()
        
        // 주류 추천 결과
        let recommendLiquorItems = [Item.productItem(resData.data.recommendLiquor.liquor)]
        let productSection = Section.product
        snapshot.appendSections([productSection])
        snapshot.appendItems(recommendLiquorItems, toSection: productSection)
        
        let foodItem = Item.foodItem(resData.data.food)
        // 어울리는 음식 추천 결과
        var foodItems = [
            Item.foodItem(Food(name: "닭다리살 스테이크",
                               imageUrl:"https://img.freepik.com/free-photo/fried-chicken-breast-with-vegetables_140725-4649.jpg?ga=GA1.1.969555387.1728058410&semt=ais_hybrid")),
            Item.foodItem(Food(name: "김치볶음밥 삼겹살 정식",
                               imageUrl:"https://img.freepik.com/free-photo/korean-food-fried-rice-with-kimchi-serve-with-fried-egg_1150-42929.jpg")),
            Item.foodItem(Food(name: "소세시 볶음 정식",
                               imageUrl:"https://d2v80xjmx68n4w.cloudfront.net/gigs/fPoZ31584321311.jpg")),
            Item.foodItem(Food(name: "된장찌개 삼겹살 정식",
                               imageUrl:"https://img.freepik.com/free-photo/bean-paste-soup-korean-style_1150-42945.jpg"))]
        
        foodItems.append(foodItem)
        let foodSection = Section.food("해당 음식과 잘 어울려요")
        snapshot.appendSections([foodSection])
        snapshot.appendItems(foodItems, toSection: foodSection)
        
        // 비슷한 제품 추천 결과
        let liquorItems = resData.data.similarLiquor.map { Item.similarItem($0.liquor) }
        let similarLiquorItems = liquorItems
        let similarSection = Section.similar("해당 제품과 비슷해요")
        snapshot.appendSections([similarSection])
        snapshot.appendItems(similarLiquorItems, toSection: similarSection)
        
        recommendResultView.dataSource?.apply(snapshot, animatingDifferences: true)
    } // closed applyProductSnapshot
    
} // closed DetailViewController
