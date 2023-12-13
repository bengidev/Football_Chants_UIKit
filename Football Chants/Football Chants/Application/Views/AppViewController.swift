//
//  AppViewController.swift
//  Football Chants
//
//  Created by Bambang Tri Rahmat Doni on 12/12/23.
//

import SwiftUI
import UIKit

final class AppViewController: UIViewController {
    private let uiView: UIView = TeamView()
    
    override func loadView() {
        super.loadView()
        
        self.navigationItem.title = "Football Chants"
        self.view.backgroundColor = .lightGray
        
        self.view = self.uiView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

#if DEBUG
@available(iOS 13, *)
struct AppViewController_Previews: PreviewProvider {
    static var previews: some View {
        NavigationControllerPreview(barStyle: .largeTitle) {
            AppViewController()
        }
        .edgesIgnoringSafeArea(.all)
    }
}
#endif

