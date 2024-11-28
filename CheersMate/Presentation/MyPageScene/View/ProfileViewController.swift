//
//  ProfileViewController.swift
//  CheersMate
//
//  Created by 재훈 on 11/28/24.
//

import UIKit
import RxSwift
import RxCocoa
import PhotosUI

public final class ProfileViewController: UIViewController {
    
    private let profileView = ProfileView()
    private let disposeBag = DisposeBag()
    
    // loadView
    public override func loadView() {
        self.view = profileView
    }
    
    // viewDidLoad
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setupNavi()
        bindView()
    }
    
    // 네비게이션 설정
    private func setupNavi() {
        self.title = "프로필"
    }
    
    private func bindView() {
        profileView.editProfileButton.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.presentImagePicker()
            })
            .disposed(by: disposeBag)
    }
    
    private func presentImagePicker() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images // 이미지만 선택 가능
        configuration.selectionLimit = 1 // 한 개의 이미지 선택

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
} // closed ProfileViewController

extension ProfileViewController: PHPickerViewControllerDelegate {
    public func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let itemProvider = results.first?.itemProvider else { return }

        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                if let uiImage = image as? UIImage {
                    DispatchQueue.main.async {
                        self?.profileView.profileImageView.image = uiImage
                    }
                }
            }
        }
    }
}
