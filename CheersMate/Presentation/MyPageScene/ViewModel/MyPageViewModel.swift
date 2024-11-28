//
//  MyPageViewModel.swift
//  CheersMate
//
//  Created by 재훈 on 11/25/24.
//

import Foundation
import RxSwift

// MyPageViewModelProtocol
public protocol MyPageViewModelProtocol {
    func transform(input: MyPageViewModel.Input) -> MyPageViewModel.Output
}

// MyPageViewModel
public final class MyPageViewModel: MyPageViewModelProtocol {
    private let disposeBag: DisposeBag = DisposeBag()

    
    // Input
    public struct Input {

    }
    
    // Output
    public struct Output {

        
    }
    
    // transform
    public func transform(input: Input) -> Output {
        
        
        return Output()
    }
    
} // closed Class

