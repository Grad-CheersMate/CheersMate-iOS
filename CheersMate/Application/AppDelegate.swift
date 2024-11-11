//
//  AppDelegate.swift
//  CheersMate
//
//  Created by 재훈 on 10/15/24.
//

import UIKit
import CoreData
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeRealmData()
        sleep(1)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Realm 초기화
    private func initializeRealmData() {
        let realm = try! Realm()
        
        // 기존에 있던 모든 데이터 삭제 진행
        try! realm.write {
            realm.deleteAll()
        }
        
        // 초기 데이터 추가
        try! realm.write {
            realm.add([
                // 감정
                SelectionObject(imageName: "smile", desc: "기쁨", type: .emotion),
                SelectionObject(imageName: "sad", desc: "슬픔", type: .emotion),
                SelectionObject(imageName: "angry", desc: "화남", type: .emotion),
                SelectionObject(imageName: "calm", desc: "차분", type: .emotion),
                // 동반자
                SelectionObject(imageName: "solo", desc: "혼자", type: .companion),
                SelectionObject(imageName: "friend", desc: "친구", type: .companion),
                SelectionObject(imageName: "couple", desc: "연인", type: .companion),
                SelectionObject(imageName: "family", desc: "가족", type: .companion),
                SelectionObject(imageName: "peoples", desc: "기타", type: .companion),
                // 주류 타입
                SelectionObject(imageName: "beer", desc: "맥주", type: .liquorType),
                SelectionObject(imageName: "soju", desc: "소주", type: .liquorType),
                SelectionObject(imageName: "wine", desc: "와인", type: .liquorType),
                SelectionObject(imageName: "riceWine", desc: "막걸리", type: .liquorType),
                SelectionObject(imageName: "whiske", desc: "위스키", type: .liquorType),
                SelectionObject(imageName: "sake", desc: "전통주", type: .liquorType),
                // 선호 도수
                SelectionObject(imageName: "one", desc: "0% ~ 5%\n(맥주, 막걸리 등)", type: .liquorLevel),
                SelectionObject(imageName: "two", desc: "6% ~ 15%\n(와인, 전통주 등)", type: .liquorLevel),
                SelectionObject(imageName: "three", desc: "16% ~ 25%\n(소주, 칵테일 베이스 등)", type: .liquorLevel),
                SelectionObject(imageName: "four", desc: "26% ~ 40%\n(위스키, 보드카 등)", type: .liquorLevel),
                SelectionObject(imageName: "five", desc: "40% ~ \n(기타 증류주 등)", type: .liquorLevel)])
        } // closed realm.write
        
    } // closed initializeRealmData
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "CheersMate")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

