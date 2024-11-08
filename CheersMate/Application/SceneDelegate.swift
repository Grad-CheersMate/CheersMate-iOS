//
//  SceneDelegate.swift
//  CheersMate
//
//  Created by 재훈 on 10/15/24.
//

// MARK: - VC: 뷰 컨트롤러, NVC: 네비게이션 뷰 컨트롤러, VM: 뷰 모델, UC: 유스케이스, RP: 리포지토리, Net: 네트워크


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        // MARK: - Data Layer
        let userNet = UserNetwork(manager: UserNetworkManager())
        let userRP = UserRepository(network: userNet)
        // MARK: - Domain Layer
        let userUC = UserUseCase(repository: userRP)
        let loginVM = LoginViewModel(useCase: userUC)
        // MARK: - Presentation Layer
        let loginVC = LoginViewController(viewModel: loginVM)
        let loginNVC = UINavigationController(rootViewController: loginVC)
        loginNVC.setupBarAppearance()
        
        window?.rootViewController = loginNVC
        window?.makeKeyAndVisible()
    }
    // MARK: - 로그인 버튼이 클릭됐을 때 메인 홈 화면으로 루트 뷰 교체
    func changeRootViewController() {
        guard let window = self.window else { return }
        // 탭 바
        let tabBarController = CustomTabBarController()
        // 루트 뷰 교체
        window.rootViewController = tabBarController
        UIView.transition(with: window, duration: 0.2, options: .transitionCrossDissolve, animations: nil)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

