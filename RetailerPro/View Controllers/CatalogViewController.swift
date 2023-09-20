//  CatalogViewController.swift
//  RetailerPro | by Mike Depew

import UIKit
import Alamofire
import AlamofireImage

class CatalogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var products: [Product] = []
    var selectedCategory: String?
    var filteredProducts: [Product] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
           filterProductsByCategory(index: sender.selectedSegmentIndex)
       }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.removeAllSegments()
        segmentedControl.insertSegment(withTitle: "Men's", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Women's", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "Electronics", at: 2, animated: false)
        segmentedControl.insertSegment(withTitle: "Jewelry", at: 3, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchProducts()
    }
    func fetchProducts() {
        AF.request("https://fakestoreapi.com/products").responseDecodable(of: [Product].self) { response in
            switch response.result {
            case .success(let products):
                self.products = products
                self.filteredProducts = products // Initialize filteredProducts with all products
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
    func filterProductsByCategory(index: Int) {
        let categoryNames = ["men's clothing", "women's clothing", "electronics", "jewelery"]
        let selectedCategory = categoryNames[index]

        // Filter products based on the selected category
        if selectedCategory.lowercased() == "all" {
            filteredProducts = products // Display all products
        } else {
            filteredProducts = products.filter { $0.category == selectedCategory }
        }
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134 // Set the desired row height here
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        let product = filteredProducts[indexPath.row]
        cell.configure(with: product)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProduct = products[indexPath.row]
        showProductDetail(for: selectedProduct)
    }
    func showProductDetail(for product: Product) {
        guard let productDetailVC = storyboard?.instantiateViewController(withIdentifier: "ProductDetailViewController") as? ProductDetailViewController else {
            return
        }
        productDetailVC.product = product

        productDetailVC.delegate = self

        navigationController?.pushViewController(productDetailVC, animated: true)
    }
}
extension CatalogViewController: ProductDetailDelegate {
    func didSelectProduct(_ product: Product) {
    }
}
