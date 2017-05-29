import UIKit

extension ShopsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShopCellId", for: indexPath) as! ShopCell

        cell.backgroundColor = UIColor.init(hue: 0.02, saturation: 0.12, brightness: 0.95, alpha: 1.00)
        
        cell.shop = self.fetchedResultsController.object(at: indexPath)
        
        return cell
    }
    
    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        referenceSizeForHeaderInSection section: Int) -> CGSize{
//        
//        return CGSize(width: 1, height: 1)
//        
//    }
    
    
}

