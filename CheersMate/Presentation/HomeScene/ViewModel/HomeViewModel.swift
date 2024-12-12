//
//  HomeViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 11/16/24.
//

import RxSwift
import RxCocoa

public protocol HomeViewModelProtocol {
    func transform(input: HomeViewModel.Input) -> HomeViewModel.Output
}

final public class HomeViewModel: HomeViewModelProtocol {
    
    private let useCase: CategoryUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    private let bestLiquorsRelay = BehaviorRelay<[Liquor]>(value: []) // 베스트 주류
    private let errorRealy = BehaviorRelay<Error?>(value: nil) // 에러
    
    // init
    public init(useCase: CategoryUseCase) {
        self.useCase = useCase
        fetchBestLiquors()
    }
    
    // Input
    public struct Input {
        
    }
    
    // Output
    public struct Output {
        let bestLiquors: Observable<[Liquor]>
    }
    
    // transform
    public func transform(input: Input) -> Output {
        
        
        return Output(bestLiquors: bestLiquorsRelay.asObservable())
    }
    
} // closed HomeViewModel

extension HomeViewModel {
    private func fetchBestLiquors() {
        useCase.fetchBestLiquors()
            .subscribe { [weak self] response in
                if response.result && response.httpCode == 200 {
                    self?.bestLiquorsRelay.accept(response.data)
                }
            } onFailure: { [weak self] error in
                self?.errorRealy.accept(error)
            }
            .disposed(by: disposeBag)
    }
}
