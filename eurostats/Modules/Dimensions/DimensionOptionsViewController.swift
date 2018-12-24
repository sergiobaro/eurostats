import UIKit

class DimensionOptionsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var dimension: StatDimension?
  var categories = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = dimension?.label
    
    self.tableView.dataSource = self
    
    if let categories = dimension?.category {
      self.categories = Array(categories.label.keys).sorted()
    }
  }
}

extension DimensionOptionsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.categories.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .value2, reuseIdentifier: "cell")
    
    let code = self.categories[indexPath.row]
    cell.textLabel!.text = code
    cell.detailTextLabel!.text = self.dimension?.category.label[code]
    
    return cell
  }
}
