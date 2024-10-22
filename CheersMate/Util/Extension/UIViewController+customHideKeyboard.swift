//
//  UIViewController+customHideKeyboard.swift
//  CheersMate
//
//  Created by 재훈 on 10/20/24.
//

// MARK: - 키보드가 등장했을 때 화면을 터치하면 키보드 내리기
import UIKit

extension UIViewController {
    // 탭 제스처에 키보드 감지
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
