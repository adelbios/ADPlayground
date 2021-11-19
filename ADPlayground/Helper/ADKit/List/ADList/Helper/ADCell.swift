import UIKit

//MARK: - CollectionView
class ADCell<CellType: ADCellConfigDelegate, DataType: Hashable>: ADBindable where CellType.DataType == DataType, CellType: UITableViewCell {
  
    static  override var cellId: String { return CellType.name }
    
    var hash: Int { return CellType.name.hashValue ^ item.hashValue }
    
    var item : DataType
    
    init(item:DataType) {
        self.item = item
    }
    
    override func configure(cell: UIView) {
        (cell as! CellType).configure(data: item)
    }
}

