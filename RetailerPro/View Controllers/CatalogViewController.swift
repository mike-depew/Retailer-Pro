//  CatalogViewController.swift
//  RetailerPro by Mike Depew

import UIKit
import Alamofire
import AlamofireImage

class CatalogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var products: [Product] = [] // Array to store fetched products
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  tableView.estimatedRowHeight = 180
            
            // Set the row height (adjust as needed)
       //     tableView.rowHeight = UITableView.automaticDimension
            
        // Register custom UITableViewCell if needed
        // tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchProducts()
    }
    
    // Function to fetch products from the API
    func fetchProducts() {
        AF.request("https://fakestoreapi.com/products").responseDecodable(of: [Product].self) { response in
            switch response.result {
            case .success(let products):
                self.products = products
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    
    
    // MARK: - Table View Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134 // Set the desired row height here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        let product = products[indexPath.row]
        cell.configure(with: product)
    //    cell.textLabel?.text = product.title
       // cell.detailTextLabel?.text = "\(product.price) USD"
        // Configure cell as needed
        return cell
    }
    
    // MARK: - Table View Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = products[indexPath.row]
        showProductDetail(for: selectedProduct)
    }

    // Add the showProductDetail method to your CatalogViewController
    func showProductDetail(for product: Product) {
        guard let productDetailVC = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController else {
            return
        }
        
        // Set the product property of the ProductDetailViewController
        productDetailVC.product = product
        
        // Set the delegate to self (CatalogViewController)
        productDetailVC.delegate = self
        
        // Present the ProductDetailViewController
        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}

// Extend CatalogViewController to conform to ProductDetailDelegate
extension CatalogViewController: ProductDetailDelegate {
    func didSelectProduct(_ product: Product) {
        // Handle product selection in CatalogViewController
        // For example, you can perform any necessary actions when a product is selected.
        // You can also update the UI or perform any other logic here.
    }
}
