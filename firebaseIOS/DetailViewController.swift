

import UIKit
import FirebaseDatabase


class DetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var myTableView: UITableView!
    
    var data = [String():Array<String>()]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 10
        
        switch section {
        case 0:
            let x = data["เจ้าของฟาร์ม"]
            return x!.count
        case 1 :
            let x = data["รูปภาพฟาร์ม"]
            return x!.count
        case 2 :
            let x = data["รูปภาพวัว"]
            return x!.count
        default:
            return 0
        }
 
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1 :
            if(self.data["รูปภาพฟาร์ม"]!.count > 0){
                return "รูปภาพฟาร์ม"
            }else {
                return ""
            }
            
        case 2 :
            if(self.data["รูปภาพวัว"]!.count > 0){
                return "รูปภาพวัว"
            }else {
                return ""
            }
        default:
            return ""
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var myCell = tableView.dequeueReusableCell(withIdentifier: "detail_cell") as! UITableViewCell
        //myCell.textLabel?.text = myArray[indexPath.row]
        //myCell.textLabel?.text = farmer.key
        
        
        switch indexPath.section {
        case 0:
            let x = data["เจ้าของฟาร์ม"]
            myCell.textLabel?.text = x![indexPath.row]
        case 1 :
            let x = data["รูปภาพฟาร์ม"]
            myCell.textLabel?.text = x![indexPath.row]
        case 2 :
            let x = data["รูปภาพวัว"]
            myCell.textLabel?.text = x![indexPath.row]
        default:
            myCell.textLabel?.text = "ERROR"

        }
        
        
        myCell.contentView.backgroundColor = .clear
        
        
        
        return myCell
    }
    
   
    /*
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cornerRadius: CGFloat = 10
        cell.backgroundColor = .clear
        
        let layer = CAShapeLayer()
        let pathRef = CGMutablePath()
        let bounds = cell.bounds.insetBy(dx: 20, dy: 0)
        var addLine = false
        
        if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
        } else if indexPath.row == 0 {
            pathRef.move(to: .init(x: bounds.minX, y: bounds.maxY))
            pathRef.addArc(tangent1End: .init(x: bounds.minX, y: bounds.minY), tangent2End: .init(x: bounds.midX, y: bounds.minY), radius: cornerRadius)
            pathRef.addArc(tangent1End: .init(x: bounds.maxX, y: bounds.minY), tangent2End: .init(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            pathRef.addLine(to: .init(x: bounds.maxX, y: bounds.maxY))
            addLine = true
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            pathRef.move(to: .init(x: bounds.minX, y: bounds.minY))
            pathRef.addArc(tangent1End: .init(x: bounds.minX, y: bounds.maxY), tangent2End: .init(x: bounds.midX, y: bounds.maxY), radius: cornerRadius)
            pathRef.addArc(tangent1End: .init(x: bounds.maxX, y: bounds.maxY), tangent2End: .init(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
            pathRef.addLine(to: .init(x: bounds.maxX, y: bounds.minY))
        } else {
            pathRef.addRect(bounds)
            addLine = true
        }
        
        layer.path = pathRef
        layer.fillColor = UIColor(white: 1, alpha: 0.8).cgColor
        
        if (addLine == true) {
            let lineLayer = CALayer()
            let lineHeight = 1.0 / UIScreen.main.scale
            lineLayer.frame = CGRect(x: bounds.minX + 10, y: bounds.size.height - lineHeight, width: bounds.size.width - 10, height: lineHeight)
            lineLayer.backgroundColor = tableView.separatorColor?.cgColor
            layer.addSublayer(lineLayer)
        }
        
        let testView = UIView(frame: bounds)
        testView.layer.insertSublayer(layer, at: 0)
        testView.backgroundColor = .clear
        cell.backgroundView = testView
    }
    */
    
    var arr :[String] = ["TEST"]

    func configureView() {
        navigationItem.title = farmer.name
        
        load()
    }
    
    func load(){
        /*
        let ref = Database.database().reference().child("ข้อมูล")
        ref.observe(.value, with: {(snapshot) in
            var i = 0
            self.data["รายชื่อ"] = []
            
            for child in snapshot.children {
                let snap = child as? DataSnapshot
                let id = snap?.key as! String
                
                let refFarmer = ref.child(id).child("รายละเอียด").child("ชื่อฟาร์ม")
                refFarmer.observeSingleEvent(of: .value, with: {(snapshots) in
                    let value = snapshots.value as! String
                    let farmer :Farmer = Farmer(name: value, key: id)
                    
                    //self.farm.append(farmer)
                    //self.data["รายชื่อ"]?.append(farmer)
                    self.myTableView.reloadData()
                    //print(i)
                    if(i == snapshot.childrenCount - 1){
                        //print("TEST")
                        
                    }
                    i+=1
                    
                })
                
                
            }
            
            
        })*/
        
        let ref = Database.database().reference().child("ข้อมูล").child(farmer.key)
        
        ref.observe(.value, with: {(snapshot) in
            self.resetData()
            self.data["เจ้าของฟาร์ม"] = ["รูปภาพเจ้าของฟาร์ม"]
            
            
            let refA = ref.child("รูปภาพฟาร์ม")
            refA.observeSingleEvent(of: .value, with: { (snapA) in
                var i = 0
                for child in snapA.children {
                    let sn = child as? DataSnapshot
                    let id = sn?.key as! String
                    let refAA = refA.child(id).child("messageText")
                    refAA.observeSingleEvent(of: .value, with: { (snapAA) in
                        
                        let idn = snapAA.value as! String
                        
                        self.data["รูปภาพฟาร์ม"]?.append(idn)
                        
                        self.myTableView.reloadData()
                    })
                    i+=1
                }
            })
            
            let refB = ref.child("รูปภาพวัว")
            refB.observeSingleEvent(of: .value, with: { (snapB) in
                var i = 0
                for child in snapB.children {
                    let sn = child as? DataSnapshot
                    let id = sn?.key as! String
                    let refBB = refB.child(id).child("messageText")
                    refBB.observeSingleEvent(of: .value, with: { (snapBB) in
                        
                        let idn = snapBB.value as! String
                        
                        self.data["รูปภาพวัว"]?.append(idn)
                        
                        self.myTableView.reloadData()
                    })
                    i+=1
                }
            })
        
            
            
            
        
        })
        
        
    }
    
    func resetData(){
        self.data.removeAll()
        self.data["เจ้าของฟาร์ม"] = []
        self.data["รูปภาพฟาร์ม"] = []
        self.data["รูปภาพวัว"] = []
    }
    
    var farmer = Farmer(name: "",key :""){
        didSet {
            // Update the view.
            print(farmer.name)
            configureView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.largeTitleDisplayMode = .never
        resetData()
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
 
    

    

}
