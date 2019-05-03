//
//  GameAreaView.swift
//  TetrisReturns
//
//  Created by Daniil Orlov on 4/6/19.
//  Copyright © 2019 Daniil Orlov. All rights reserved.
//

import UIKit

@IBDesignable
class GameAreaView: UIView {
    
    class func generateGameArea(_ rows: Int, cols: Int) -> [[CellState]] {
        return Array(repeating: Array(repeating: .empty, count: cols),
                     count: rows)
    }
    
    enum CellState {
        case empty
        case filled(UIColor)
    }
    
    @IBInspectable
    var gridColor: UIColor? = UIColor.white
    
    @IBInspectable
    var rows: Int = 20 {
        didSet {
            
            if self.rows < 10 {
                self.rows = 10
                return
            }
            
            self.generateGameArea()
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var columns: Int = 10 {
        didSet {
            
            if self.rows < 5 {
                self.rows = 5
                return
            }
            
            self.generateGameArea()
            
            self.setNeedsDisplay()
        }
    }
    
    var cellSize: CGFloat {
        
        let cellWidth = self.bounds.size.width / CGFloat(self.columns)
        let cellHeight = self.bounds.size.height / CGFloat(self.rows)
        
        return min(cellWidth, cellHeight)
    }
    
    var canvas: CGRect {
        
        let canvasWidth = self.cellSize * CGFloat(self.columns)
        let canvasHeight = self.cellSize * CGFloat(self.rows)
        
        let x = (self.bounds.size.width - canvasWidth) / 2
        let y = (self.bounds.size.height - canvasHeight) / 2
        
        return CGRect(x: x, y: y, width: canvasWidth, height: canvasHeight)
    }
    
    @IBInspectable
    var gameAreaColor: UIColor = UIColor.black
    
    private(set) var gameArea: [[CellState]]
    
    private func generateGameArea() {
        self.gameArea = type(of: self).generateGameArea(self.rows, cols: self.columns)
    }
    
    func generateRandomGame() {
        self.generateGameArea()
        
        for i in (self.gameArea.count / 2)..<self.gameArea.count {
        
            for j in 0..<self.gameArea[i].count {
                
                if arc4random_uniform(2) == 1 {
                    
                    self.gameArea[i][j] = .filled(UIColor.yellow)
                }
            }
        }
        
        self.setNeedsDisplay()
    }
    
    // Initialization
    override init(frame: CGRect) {
        
        self.gameArea = type(of: self).generateGameArea(self.rows, cols: self.columns)
        
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        self.gameArea = type(of: self).generateGameArea(self.rows, cols: self.columns)
        
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Game area canvas
        let canvasPath = UIBezierPath(rect: self.canvas)
        self.gameAreaColor.setFill()
        canvasPath.fill()
        
        // "Debug" mode grid
        if self.gridColor != nil {
            
            let gridLines = UIBezierPath()
            
            for i in 1..<self.columns {
                
                let x = CGFloat(i) * self.cellSize
                
                gridLines.move(to: CGPoint(x: x + 0.5, y: self.canvas.minY))
                gridLines.addLine(to: CGPoint(x: x + 0.5, y: self.canvas.maxY))
            }
            
            for i in 1..<self.rows {
                let y = CGFloat(i) * self.cellSize
                
                gridLines.move(to: CGPoint(x: self.canvas.minX, y: y + 0.5))
                gridLines.addLine(to: CGPoint(x: self.canvas.maxX, y: y + 0.5))
            }
            
            self.gridColor?.setStroke()
            gridLines.stroke()
        }
        
        // Game area content
        
        for i in 0..<self.gameArea.count {
        
            let row = self.gameArea[i]
            
            for j in 0..<row.count {
                
                let cellState = row[j]
                
                switch cellState {
                case .filled(let color):
                        
                        let x = self.canvas.minX + CGFloat(j) * self.cellSize
                        let y = self.canvas.minY + CGFloat(i) * self.cellSize
                        
                        let rect = CGRect(x: x, y: y, width: self.cellSize, height: self.cellSize).insetBy(dx: 2, dy: 2)
                        let path = UIBezierPath(rect: rect)
                        
                        color.setFill()
                        path.fill()
                    
                default:
                    break
                }
                
            }
        }
    }
}
