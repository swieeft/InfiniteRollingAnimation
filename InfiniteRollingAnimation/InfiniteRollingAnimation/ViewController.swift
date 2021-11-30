//
//  ViewController.swift
//  InfiniteRollingAnimation
//
//  Created by swieeft on 2021/11/29.
//

import UIKit

class ViewController: UIViewController {

    // 이미지 뷰를 추가 해줄 contentsView
    // 이미지뷰를 frame 기반으로 넣다보니 safeArea를 이용하려면 contentsView를 먼저 넣어주는게 편함
    var contentsView: UIView!
    
    // 이미지 2개를 이어줄 2개의 이미지 뷰
    var skyImageView1: UIImageView!
    var skyImageView2: UIImageView!
    
    var imageView3: UIImageView!
    var imageView4: UIImageView!
    
    var sampleImageView1: UIImageView!
    var sampleImageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setContentsView()
        setSkyImageView()
//        setSampleImageView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startSkyAnimation()
//        startSampleAnimation()
    }
    
    func setContentsView() {
        contentsView = UIView()
        contentsView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contentsView)
        
        // top, bottom은 safeArea 기준으로 잡아줌
        contentsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        contentsView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        contentsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        contentsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
    }
    
    func setSkyImageView() {
        let image = UIImage(named: "sky")!
        
        // 첫번째 이미지 뷰 - x 좌표를 0으로 잡아서 화면 왼쪽 끝에서 시작 되도록 설정
        skyImageView1 = UIImageView(image: image)
        skyImageView1.frame = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        skyImageView1.contentMode = .scaleAspectFill
        contentsView.addSubview(skyImageView1)
        
        // 두번째 이미지 뷰 - x 좌표를 첫번째 이미지 뷰 넓이 만큼 주어서 첫번째 이미지 뷰 뒤에 붙도록 함
        skyImageView2 = UIImageView(image: image)
        skyImageView2.frame = CGRect(x: skyImageView1.frame.width, y: 0, width: image.size.width, height: image.size.height)
        skyImageView2.contentMode = .scaleAspectFill
        contentsView.addSubview(skyImageView2)
        
        imageView3 = UIImageView(image: UIImage(named: "plane"))
        imageView3.frame = CGRect(x: 55, y: image.size.height - 145, width: 100, height: 100)
        imageView3.contentMode = .scaleAspectFill
        contentsView.addSubview(imageView3)

        imageView4 = UIImageView(image: UIImage(named: "superman"))
        imageView4.frame = CGRect(x: UIScreen.main.bounds.width, y: 50, width: 70, height: 70)
        imageView4.contentMode = .scaleAspectFill
        contentsView.addSubview(imageView4)
    }
    
    func setSampleImageView() {
        let sample1 = UIImage(named: "sample1")!
        sampleImageView1 = UIImageView(image: sample1)
        sampleImageView1.frame = CGRect(x: 0, y: 0, width: sample1.size.width, height: sample1.size.height)
        sampleImageView1.contentMode = .scaleAspectFill
        contentsView.addSubview(sampleImageView1)
        
        sampleImageView2 = UIImageView(image: sample1)
        sampleImageView2.frame = CGRect(x: sample1.size.width, y: 0, width: sample1.size.width, height: sample1.size.height)
        sampleImageView2.contentMode = .scaleAspectFill
        contentsView.addSubview(sampleImageView2)
    }
    
    func startSkyAnimation() {
        // UIView.animate를 이용한 방법
//        UIView.animate(withDuration: 10, delay: 0, options: [.repeat, .curveLinear]) {
//            // 이미지 뷰의 x 좌표를 이미지 뷰 width 만큼 이동
//            self.skyImageView1.frame = self.skyImageView1.frame.offsetBy(dx: -self.skyImageView1.frame.width, dy: 0)
//            self.skyImageView2.frame = self.skyImageView2.frame.offsetBy(dx: -self.skyImageView2.frame.width, dy: 0)
//        }
        
        // Core Animation을 이용한 방법
        let animation1 = CABasicAnimation(keyPath: "position.x")
        animation1.byValue = -skyImageView1.frame.width
        animation1.duration = 10
        animation1.repeatCount = .infinity
        animation1.timingFunction = CAMediaTimingFunction(name: .linear)
        skyImageView1.layer.add(animation1, forKey: "positionX")

        let animation2 = CABasicAnimation(keyPath: "position.x")
        animation2.byValue = -skyImageView2.frame.width
        animation2.duration = 10
        animation2.repeatCount = .infinity
        animation2.timingFunction = CAMediaTimingFunction(name: .linear)
        skyImageView2.layer.add(animation2, forKey: "positionX")
        
        let animation3 = CABasicAnimation(keyPath: "position.y")
        animation3.byValue = -30
        animation3.duration = 3
        animation3.repeatCount = .infinity
        animation3.autoreverses = true
        animation3.timingFunction = CAMediaTimingFunction(name: .linear)
        imageView3.layer.add(animation3, forKey: "positionY")

        let animation4 = CABasicAnimation(keyPath: "position.x")
        animation4.byValue = -UIScreen.main.bounds.width - 70
        animation4.duration = 10
        animation4.repeatCount = .infinity
        animation4.timingFunction = CAMediaTimingFunction(name: .linear)
        imageView4.layer.add(animation4, forKey: "positionX3")
    }
    
    func startSampleAnimation() {
        
        let animation1 = CABasicAnimation(keyPath: "position.x")
        animation1.byValue = -sampleImageView1.frame.width
        animation1.duration = 10
        animation1.repeatCount = .infinity
        animation1.timingFunction = CAMediaTimingFunction(name: .linear)
        sampleImageView1.layer.add(animation1, forKey: "positionX")
        
        let animation2 = CABasicAnimation(keyPath: "position.x")
        animation2.byValue = -sampleImageView2.frame.width
        animation2.duration = 10
        animation2.repeatCount = .infinity
        animation2.timingFunction = CAMediaTimingFunction(name: .linear)
        sampleImageView2.layer.add(animation2, forKey: "positionX")
    }
}

