//
//  AppViewController.swift
//  Football Chants
//
//  Created by Bambang Tri Rahmat Doni on 12/12/23.
//

import SnapKit
import SwiftUI
import UIKit

final class AppViewController: UIViewController {
    private let viewModel: TeamViewModel = .init()
    private let audioService: AudioPlayerService = .init()
    
    private lazy var uiView = TeamView()

    override func loadView() {
        super.loadView()

        self.navigationItem.title = "Football Chants"
        
        self.view = self.uiView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uiView.configureViewModel(self.viewModel)
    }

}

#if DEBUG
@available(iOS 13, *)
struct AppViewController_Previews: PreviewProvider {
    static var previews: some View {
        NavigationControllerPreview(barStyle: .largeTitle) {
            AppViewController()
        }
    }
}
#endif

