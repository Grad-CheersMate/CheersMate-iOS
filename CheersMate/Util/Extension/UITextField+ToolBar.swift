//
//  UITextField+ToolBar.swift
//  CheersMate
//
//  Created by 재훈 on 10/24/24.
//

import UIKit

extension UITextField {
    // 텍스트 필드에 툴바를 추가
    func addDoneToolbar(target: Any, action: Selector?, doneButtonTitle: String = "완료") {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: doneButtonTitle, style: .done, target: target, action: action)
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    // 텍스트 필드의 텍스트 왼쪽에 간격주기
    func leftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}

