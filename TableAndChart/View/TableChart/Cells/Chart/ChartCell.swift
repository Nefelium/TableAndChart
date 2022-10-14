//
//  ChartCell.swift
//  TableAndChart
//
//  Created by Mikhail on 08.10.2022.
//

import UIKit
import Charts

class ChartCell: UITableViewCell {
    
    @IBOutlet weak var canvasView: UIView!
    @IBOutlet weak var modeSwitcher: UISegmentedControl!
    
    lazy var chartView: LineChartView = {
        let chartView = LineChartView()
        chartView.autoScaleMinMaxEnabled = true
        chartView.backgroundColor = UIColor(hexString: "61A0E6")
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .outsideChart
        
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.setLabelCount(6, force: false)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .white
        chartView.xAxis.labelPosition = .bottom
        
        chartView.animate(xAxisDuration: 2)
        return chartView
    }()
    
    private var tempCoordinates = [CoordinatesModel]()
    
    @IBAction func modeChanged(_ sender: Any) {
        switch modeSwitcher.selectedSegmentIndex
            {
            case 0:
            setData(tempCoordinates, mode: .linear)
            case 1:
            setData(tempCoordinates, mode: .cubicBezier)
            default:
                break
            }
    }
    
    @IBAction func saveChartToFile(_ sender: Any) {
        let chartImage = chartView.getChartImage(transparent: false) ?? UIImage()
        UIImageWriteToSavedPhotosAlbum(chartImage, nil, nil, nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        canvasView.addSubview(chartView)
        setupConstraints()
    }
    
    private func transformCoordinatesToData(_ coordinates: [CoordinatesModel]) -> [ChartDataEntry] {
        var data = [ChartDataEntry]()
        coordinates.forEach { point in
            data.append(ChartDataEntry(x: point.x, y: point.y))
        }
        return data
    }
    
    func setData(_ coordinates: [CoordinatesModel], mode: LineChartDataSet.Mode = .linear) {
        let set = LineChartDataSet(entries: transformCoordinatesToData(coordinates), label: "Coordinates")
        set.circleRadius = 2.0
        set.mode = mode
        controlMode(mode: mode)
        let data = LineChartData(dataSet: set)
        chartView.data = data
        tempCoordinates = coordinates
    }
    
    private func controlMode(mode: LineChartDataSet.Mode) {
        switch mode {
        case .linear:
            modeSwitcher.selectedSegmentIndex = 0
        case .cubicBezier:
            modeSwitcher.selectedSegmentIndex = 1
        default: break
        }
    }
    
    private func setupConstraints() {
        chartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chartView.topAnchor.constraint(equalTo: canvasView.topAnchor),
            chartView.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor),
            chartView.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor),
            chartView.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor)
        ])
    }
    
}
