import UIKit

class DimensionsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  var stat: StatData?
  var dimensions = [StatDimension]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = self.stat?.label
    
    self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tapCancel))
    
    self.tableView.dataSource = self
    self.tableView.delegate = self
    
    if let stat = stat {
      self.dimensions = stat.id.compactMap { stat.dimension[$0] }
    }
  }
  
  @objc func tapCancel() {
    self.dismiss(animated: true)
  }
  
}

extension DimensionsViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dimensions.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .value1, reuseIdentifier: "cell")
    cell.accessoryType = .disclosureIndicator
    
    let dimension = self.dimensions[indexPath.row]
    cell.textLabel!.text = dimension.label
    if let size = self.stat?.size[indexPath.row] {
      cell.detailTextLabel!.text = "(\(size))"
    }
    
    return cell
  }
}

extension DimensionsViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    let vc = DimensionOptionsViewController()
    vc.dimension = self.dimensions[indexPath.row]
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
