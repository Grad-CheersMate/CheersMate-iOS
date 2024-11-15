//
//  RecommendEvaluateViewController.swift
//  CheersMate
//
//  Created by 재훈 on 11/15/24.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

final public class RecommendEvaluateViewController: UIViewController {
    // MARK: - 프로퍼티 설정
    private let recommendEvaluateView = RecommendEvaluateView()
    private let disposeBag = DisposeBag()
    private let viewModel: RecommendEvaluateViewModelProtocol
    
    // MARK: - 오버라이드 함수 설정
    public override func loadView() {
        self.view = recommendEvaluateView
    } // closed loadView
    
    public init(viewModel: RecommendEvaluateViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        bindViewModel()
    } // closed viewDidLoad
    
    // MARK: - 바인드 뷰
    private func bindView() {

    } // closed bindView
    
    // MARK: - 바인드 뷰 모델
    private func bindViewModel() {
        let input = RecommendEvaluateViewModel.Input(
            submitButtonTapped: recommendEvaluateView.submitButton.rx.tap.asObservable(),
            evaluateRating: recommendEvaluateView.cosmosView.rx.ratingDidChange)
        
        let output = viewModel.transform(input: input)
        
        output.rating
            .bind(onNext: { [weak self] rating in
                self?.recommendEvaluateView.configureCosmosInfoLabel(rating: rating)
                })
            .disposed(by: disposeBag)
        
        output.presentingDismiss
            .bind(onNext: { [weak self] text in
                print(text)
                self?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        
    } // closed bindViewModel
    
    
    

    
} // closed RecommendEvaluateViewController
