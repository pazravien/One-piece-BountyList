//
//  BountyViewController.swift
//  BountyList
//
//  Created by 윤재웅 on 2020/05/20.
//  Copyright © 2020 pazravien. All rights reserved.
//

// MVVM

// Model
// - BountyInfo
//  > BountyInfo 만들자

// View
// - ListCell
//  > ListCell 필요한 정보를 ViewModel한태서 받아야겠다
//  > LIstCell은 VIewModel로 부터 받은 정보로 뷰 업데이트 하기

// ViewMoodel
// - BountyViewModel
//  > BountyViewModel을 만들고, 뷰레이어에서 필요한 메서드 만들기
//  > 모델 가지고 있기,, BountyInfo 등

import UIKit

class BountyViewController: UIViewController{
    
    let viewModel = BountyViewModel()

    // 세그웨이를 시작할때 준비하는 메소드
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController 데이터를 준다
        if segue.identifier == "showDetail"{
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int{
                
                let bountyInfo = viewModel.bountyInfo(at: index)
                vc?.viewModel.update(model: bountyInfo)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
// MARK: - UICollectionViewDataSource
extension BountyViewController: UICollectionViewDataSource {
    //UICollectionViewDataSource
    // 몇개를 보여줄까요?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfBountyInfoList
    }
    
    // 셀은 어떻게 표현할까요?
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else {
            return UICollectionViewCell()
        }
        
        let bountyInfo = viewModel.bountyInfo(at: indexPath.item)
        cell.update(info: bountyInfo)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension BountyViewController: UICollectionViewDelegate{

    //UICollectionViewDelegate
    // 셀이 클릭되었을때 어쩔까요?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          performSegue(withIdentifier: "showDetail", sender: indexPath.item)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BountyViewController: UICollectionViewDelegateFlowLayout{
    //UICollectionViewDelegateFlowLayout
    // 셀 사이즈를 계산할거다 (목표 : 다양한 디바이스에서 일관적인 디자인을 보여주기 위해)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let textAreaHeight: CGFloat = 65
        
        let width:CGFloat = (collectionView.bounds.width - itemSpacing)/2
        let height:CGFloat = width * 10/7 + textAreaHeight
        
        return CGSize(width: width, height: height)
    }
}

// MARK: - Cell class
class GridCell: UICollectionViewCell{
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    func update(info: BountyInfo)  {
        imgView.image = info.image
        nameLabel.text = info.name
        bountyLabel.text = "\(info.bounty)"
    }

}
