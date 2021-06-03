import UIKit

class ECarIntroViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var indexSend: Int!
    
    @IBOutlet var collectionV: UICollectionView!
    let nameList = ["쏘울", "니로", "아이오닉","코나", "SM3", "볼트", "i3", "리프", "모델S" ,"모델3"]
    let urlList = [
        "https://evc.kepco.co.kr:4445/publish/images/sub/car14.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car13.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car05.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car12.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car06.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car11.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car07.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car03.png",
        "https://evc.kepco.co.kr:4445/publish/images/sub/car08.png" ,
        "https://evc.kepco.co.kr:4445/publish/images/sub/car15.png"]
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nameList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? ECarIntroCollectionViewCell else {
            return UICollectionViewCell()
        }
        let url = URL(string: urlList[indexPath.row])
        let data = try? Data(contentsOf: url!)
        cell.imgView.image = UIImage(data: data!)
        //let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
        //cell.imgView.image = img
        cell.nameLabel.text = nameList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexSend = indexPath.row
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        indexSend = indexPath.row
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToECarIntroDetail" {
            if let cell = sender as? UICollectionViewCell {
                let indexpath = collectionV.indexPath(for: cell)

                if let ecarIntroDetailViewController = segue.destination as?
                    ECarIntroDetailViewController {
                    ecarIntroDetailViewController.index = indexpath?.row
                }
        }
    }
 
}
}

class ECarIntroCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
}
