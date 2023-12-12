//
//  AppViewController.swift
//  Football Chants
//
//  Created by Bambang Tri Rahmat Doni on 12/12/23.
//

import SwiftUI
import UIKit

class AppViewController: UIViewController {
    
    // MARK: View Components
    private lazy var collectionContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        
        return vw
    }()
    
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let vw = UICollectionViewFlowLayout()
        vw.itemSize = CGSize(width: self.view.bounds.width, height: 50)
        vw.minimumInteritemSpacing = 0
        vw.sectionInset = UIEdgeInsets.zero
        vw.minimumLineSpacing = 1
        
        return vw
    }()
    
    private lazy var collectionView: UICollectionView = {
        let vw = UICollectionView(frame: .zero, collectionViewLayout: self.collectionLayout)
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vw.register(
            TeamCollectionViewCell.self,
            forCellWithReuseIdentifier: TeamCollectionViewCell.cellIdentifier
        )
        vw.dataSource = self
        vw.delegate = self
        
        return vw
    }()
    
    override func loadView() {
        super.loadView()
        self.navigationItem.title = "Football Chants"
        self.view.backgroundColor = .lightGray
        
        self.view.addSubview(self.collectionContainer)
        self.collectionContainer.addSubview(self.collectionView)
        
        NSLayoutConstraint.activate([
            self.collectionContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.collectionContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            self.collectionContainer.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.collectionContainer.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension AppViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TeamCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? TeamCollectionViewCell else { return .init() }

        cell.backgroundColor = .red
        cell.changeNameLabel(to: "Cell Number: \(indexPath)")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.collectionView.deselectItem(at: indexPath, animated: true)
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
