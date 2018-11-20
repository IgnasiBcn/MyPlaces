//
//  FirstViewController.swift
//  MyPlaces
//
//  Created by iMac on 2/10/18.
//  Copyright © 2018 Ignasi Pérez. All rights reserved.
//

import UIKit

class FirstViewController :
    UITableViewController,
    ManagerPlacesObserver {
    
    var sharedManagerLocation: ManagerLocation = ManagerLocation.shared()
    
    @IBOutlet weak var btnAdd: UIBarButtonItem!
    
    //let m_provider: ManagerPlaces = ManagerPlaces.shared()
    
    
    //  *******************************************************************
    //  MARK: - Overrided methods
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let view: UITableView = (self.view as? UITableView)!;
        view.delegate = self
        view.dataSource = self
        
        addMyselfAsObserver()
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //  *******************************************************************
    //  MARK: - TABLE Protocol
    //
    //  FirstViewController inherits UITableViewController which conforms
    //  the protocols UITableViewDataSource and UITableViewDelegate.
    //
    //
    //  Protocol UITableViewDataSource
    //
    /// Tells the data source to return the number of rows in a given section of a table view.
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int
    {
        return ManagerPlaces.shared().getCount()
    }
    
    
    //  Protocol UITableViewDataSource
    //
    /// Asks the data source to return the number of sections in the table view.
    /// The default value is 1.
    override func numberOfSections(
        in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    //  Protocol UITableViewDelegate
    //
    ///  Tells the delegate that the specified row is now selected.
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath) {
        
        // Instantiates and returns the view controller with the specified identifier.
        let dc: DetailController =
            UIStoryboard(name: "Main",bundle:nil).instantiateViewController(
                    withIdentifier: "DetailController") as! DetailController
        
        
        let place: Place = ManagerPlaces.shared().getItemAt(position: indexPath.row)
        dc.place = place
        present(dc, animated: true, completion: nil)
        
    }
    
    
    //  Protocol UITableViewDelegate
    //
    /// Asks the delegate for the height to use for a row in a specified location.
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        // Devolver la altura de la fila situada en una posición determinada
        return 100
    }
    
    
    //  Protocol UITableViewDataSource
    //
    /// Asks the data source for a cell to insert in a particular location of the table view.
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell()
        
        let wt: CGFloat = tableView.bounds.size.width
            
            
        // Add subviews to cell
        // UILabel and UIImageView
        
        let label = UILabel(frame: CGRect(x:10, y:4, width: wt, height:20))
        label.font = UIFont(name: "Arial", size: 18)!
        label.numberOfLines = 4
        
        let index = indexPath.row
        let strName = ManagerPlaces.shared().getItemAt(position: index).name
        label.text = strName
        label.sizeToFit()
        cell.contentView.addSubview(label)
            
//        let imageIcon: UIImageView = UIImageView(image: UIImage(named:"sun.png"))
//        imageIcon.frame = CGRect(x:10, y:50, width:50, height:50)
//        cell.contentView.addSubview(imageIcon)
        let place: Place = ManagerPlaces.shared().getItemAt(position: indexPath.row)
        let imageIcon: UIImageView = UIImageView(
            image: UIImage(contentsOfFile: ManagerPlaces.shared().getPathImage(p: place)))
        imageIcon.frame = CGRect(x:10, y:30, width: 50, height: 50)
        cell.contentView.addSubview(imageIcon)

        return cell
    }
  
    

    //  *******************************************************************
    //  MARK: - OBSERVER Design Pattern
    //
    //
    //  PLA2 - 5.6
    //
    /// An instance of FirstViewController subscribes itself to the list of observers
    //
    func addMyselfAsObserver() {
        
        print("____ FirstViewController addMyselfAsObserver()")
        ManagerPlaces.shared().addObserver(object: self)
        
    }
    
    
    //  PLA2 - 5.5
    //
    //  Protocol ManagerPlacesObserver
    //
    /// Because an instance of the FirstViewController class is subscribed,
    /// when the publisher discloses a change the subscriber acts according to his responsibilities.
    /// In this case FirstViewcontroller is responsible for reloading the view
    //
    func onPlacesChange() {
        
        print("____ FirstViewController onPlacesChange()")
        let view: UITableView = (self.view as? UITableView)!
        view.reloadData()
        
    }
}
