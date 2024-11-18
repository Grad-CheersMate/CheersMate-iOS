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
    // 프로퍼티
    private let useCase: WeatherUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    // init
    public init(useCase: WeatherUseCaseProtocol) {
        self.useCase = useCase
    }
    // Input
    public struct Input {
        //let weatherButtonTapped: Observable<Void>
    }
    // Output
    public struct Output {
        
    }
    // transform
    public func transform(input: Input) -> Output {
        
        return Output()
    }
    
} // closed HomeViewModel

