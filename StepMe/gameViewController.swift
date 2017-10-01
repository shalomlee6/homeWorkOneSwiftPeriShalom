//
//  gameViewController.swift
//  StepMe
//
//  Created by shalom on 13/05/2017.
//  Copyright © 2017 shalom. All rights reserved.
//

import UIKit


private let reuseIdentifier = "Cell"
private let  numOfCells = 16

class gameViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var emptyFlag = 0
    var cockroachFlag = 1
    var strikeCount = 0
    var scoreCount = 0
    var randomIndex = -1
    var timer = Timer()
    var cockroachImg = UIImage(named: "cockroach")
    var alert:UIAlertController!
    
    
    
    
    @IBOutlet weak var strikeLable: UILabel!
    @IBOutlet weak var scoreLable: UILabel!
    @IBOutlet weak var gameMatrix: UICollectionView!
    
     override func viewDidLoad() {
        super.viewDidLoad()
        // self.collectionView?.backgroundColor = UIColor(patternImage: UIImage(named: "gameImg")!)
        schedulTimerTask()
        
    }
    
    func addWords(){
        
        
        
        
        
    }
    
    
    
    //Set Timer Task
    func schedulTimerTask(){
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(gameViewController.updateGame), userInfo: nil, repeats: true)
        
        
        
        
    }
    
    func updateGame(){
        

        
            //disable current cell with roach
            if randomIndex != -1{
                removeCockroach(randomCell: randomIndex)
            }
            randomIndex = Int(arc4random_uniform(12))
            // print(random)
            updateCell(randomCell: randomIndex)
        
        
        
        
        
    }
    
    func updateCell(randomCell : Int){
        
        let cell: gameCell = gameMatrix.cellForItem(at: IndexPath.init(row: randomCell, section: 0)) as! gameCell
        
        
        
        
        
        cell.isCockroach = true
        cell.cellImage.image = cockroachImg
        
        
    }

    func removeCockroach(randomCell : Int){
        
        let cell: gameCell = gameMatrix.cellForItem(at: IndexPath.init(row: randomCell, section: 0)) as! gameCell
        
        cell.isCockroach = false
        cell.cellImage.image = nil
        
        
        
    }
    
    //when i want something to happen whan the user tap a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        cockroachCheck(cellIndex: indexPath.row)
        
        
        
        
    }
    
    func cockroachCheck(cellIndex: Int){
        
        
        let cell: gameCell = gameMatrix.cellForItem(at: IndexPath.init(row: cellIndex, section: 0)) as! gameCell
        
        
        
        
        if cell.isCockroach{
            scoreCount += 1
            cell.isCockroach = false
            scoreLable.text = String("Score: \(scoreCount)")
            
            if scoreCount >= 30{
                timer.invalidate()
                // TODO: YOU WON@!
                
                let alert = UIAlertController(title: "You Won :)",message: "Total Score: \(scoreCount)",
                    preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK",style: .default,handler: {
                    (action) -> Void in
                    
                    
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                    
                }))
                
                
                self.present(alert, animated: true, completion: nil)
            }
        }else{
            strikeCount += 1
            strikeLable.text = String("Total Strikes: \(strikeCount)")
            if strikeCount >= 3{
                timer.invalidate()
                //TODO: YOU LOSE :(
                let alert = UIAlertController(title: "You Lose :(",message: "Total Strikes: \(strikeCount)",
                    preferredStyle: UIAlertControllerStyle.alert)

                alert.addAction(UIAlertAction(title: "OK",style: .default,handler: {
                    (action) -> Void in
                    
                
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
                    
                }))
                
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
        
        
    }
    
    //UnHighlight selected Cell
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numOfCells
    }
    
    //method to dequeue the cell and set it up
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: gameCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! gameCell

        //cell.cellImage.image = cockroachImg
        
        
        return cell
    }}
















