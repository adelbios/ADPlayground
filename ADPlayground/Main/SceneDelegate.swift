//
//  SceneDelegate.swift
//  ADPlayground
//
//  Created by Adel Radwan on 19/11/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = AppNavigationController(rootViewController: HomeController())
        self.window?.makeKeyAndVisible()
    }



}


class AppNavigationController: UINavigationController {
    
    var image: UIImage {
        return UIImage(systemName: "arrowshape.turn.up.forward")!
    }
    
    override var childForStatusBarStyle: UIViewController?{
        return topViewController
    }
    
    private let appearance = UINavigationBarAppearance()
    
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        applyNavStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func applyNavStyle(){
        let backButtonAppearance = UIBarButtonItemAppearance(style: .plain)
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = AppColor.white.value
        appearance.titleTextAttributes = [
            .font: Fonts.cairo.bold.font(size: 20),
            .foregroundColor: AppColor.blue.value
        ]
        appearance.shadowColor = AppColor.lightGray.value
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: AppColor.clear.value]
        appearance.setBackIndicatorImage(image, transitionMaskImage: image)
        appearance.backButtonAppearance = backButtonAppearance
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = AppColor.black.value
    }
    
    
}
