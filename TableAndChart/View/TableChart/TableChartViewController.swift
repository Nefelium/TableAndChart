//
//  TableChartViewController.swift
//  TableAndChart
//
//  Created by Mikhail on 08.10.2022.
//

import UIKit

class TableChartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter: TableChartPresenter?
    
    private let sectionCount = 2
    private let sectionHeaderHeight: CGFloat = 70
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
    }
    
    private func registerCells() {
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
        tableView.register(UINib(nibName: "CoordinateCell", bundle: nil), forCellReuseIdentifier: "CoordinateCell")
        tableView.register(UINib(nibName: "ChartCell", bundle: nil), forCellReuseIdentifier: "ChartCell")
    }

}

extension TableChartViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return presenter?.coordinates.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return configureCoordinateCell(for: indexPath)
        } else {
            return configureChartCell(for: indexPath)
        }
    }
    
    private func configureCoordinateCell(for indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CoordinateCell",
                                                    for: indexPath) as? CoordinateCell {
            guard let coordinates = presenter?.coordinates.sorted(by: { $0.x < $1.x }) else {
                return UITableViewCell() }
            cell.setCoordinates(x: coordinates[indexPath.row].x,
                                y: coordinates[indexPath.row].y)
            return cell
        }
        return UITableViewCell()
    }
    
    private func configureChartCell(for indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCell",
                                                    for: indexPath) as? ChartCell {
            guard let coordinates = presenter?.coordinates.sorted(by: { $0.x < $1.x }) else {
                return UITableViewCell() }
            cell.setData(coordinates)
            return cell
        }
        return UITableViewCell()
    }
}

extension TableChartViewController {
    func set(presenter: TableChartPresenter) {
        self.presenter = presenter
    }
}

extension TableChartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return configureTitleCell(with: "Таблица координат")
        } else {
            return configureTitleCell(with: "График")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
    
    private func configureTitleCell(with title: String) -> UIView {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell") as? TitleCell {
            cell.setTitle(title)
            return cell
        }
        return UITableViewCell()
    }
}
