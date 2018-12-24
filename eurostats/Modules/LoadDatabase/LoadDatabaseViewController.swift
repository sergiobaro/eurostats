import UIKit

class LoadDatabaseViewController: UIViewController {
  
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var button: UIButton!
  @IBOutlet weak var spinner: UIActivityIndicatorView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.label.text = "Database Id:"
    
    self.button.setTitle("Load", for: .normal)
    self.button.addTarget(self, action: #selector(tapLoadButton), for: .touchUpInside)
    
    self.textField.text = "tran_sf_railac"
    self.textField.becomeFirstResponder()
    
    self.spinner.hidesWhenStopped = true
    self.spinner.stopAnimating()
  }
  
  @objc func tapLoadButton() {
    guard let databaseId = self.textField.text else {
      return
    }
    guard let url = URL(string: "https://ec.europa.eu/eurostat/wdds/rest/data/v2.1/json/en/" + databaseId) else {
      return
    }
    
    self.spinner.startAnimating()
    self.textField.resignFirstResponder()
    self.button.isEnabled = false
    
    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
      DispatchQueue.main.async {
        self.button.isEnabled = true
        self.spinner.stopAnimating()
        
        if let error = error {
          let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          self.present(alert, animated: true)
          return
        }
        
        guard let data = data else {
          return
        }
        do {
          let stat = try JSONDecoder().decode(StatData.self, from: data)
          let vc = DimensionsViewController()
          vc.stat = stat
          
          let nc = UINavigationController(rootViewController: vc)
          self.present(nc, animated: true)
        } catch {
          let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          self.present(alert, animated: true)
        }
      }
    }
    
    task.resume()
  }
}
