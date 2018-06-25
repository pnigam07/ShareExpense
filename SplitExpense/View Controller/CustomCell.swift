//
//  CustomCell.swift
//  SplitExpense
//
//  Created by pankaj on 6/23/18.
//  Copyright © 2018 Nigam. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell,UITableViewDataSource,UITableViewDelegate {

    var dataArr:[String] = []
    var subMenuTable:UITableView?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: reuseIdentifier)
        setUpTable()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setUpTable()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpTable()
    }

    func setUpTable(){
        subMenuTable = UITableView(frame: CGRect.zero, style:UITableViewStyle.plain)
        subMenuTable?.delegate = self
        subMenuTable?.dataSource = self
        self.addSubview(subMenuTable!)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    //    subMenuTable?.frame = CGRect(x: 0.2, y: 0.3, width: bounds.size.wid, height: <#T##CGFloat#>)
        subMenuTable?.frame = CGRect(x:0.2, y:0.3, width: self.bounds.size.width-5, height:self.bounds.size.height-5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cellID")

        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cellID")
        }

        cell?.textLabel?.text = dataArr[indexPath.row]

        return cell!
    }
}
