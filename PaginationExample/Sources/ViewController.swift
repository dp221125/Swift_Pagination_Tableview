//
//  ViewController.swift
//  Remove
//
//  Created by Seokho on 2020/03/09.
//  Copyright © 2020 Seokho. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var array: [Int] = {
        
        var arr: [Int] = .init()
        for index in 1 ... 20 {
            arr.append(index)
        }
        
        return arr
    }()
    
    var latestSize: Int = 20
    
    override func loadView() {
        let view = UITableView()
        view.backgroundColor = .systemBackground
        self.view = view

        view.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        view.delegate = self
        view.dataSource = self
    }
    
    @objc
    func reloadTable() {
        let view = self.view as! UITableView
        view.reloadData()
    }

    
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
        
        cell.textLabel?.text = "\(array[indexPath.row])번 째"
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let size = array.count
        
        if indexPath.row == size  - 1 {
            
            if size < Int.max {
                
                latestSize = size + 20

                for index in size + 1 ... latestSize {
                    array.append(index)
                }
                self.perform(#selector(reloadTable), with: nil, afterDelay: 1.0)
            }
        }
    }
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
