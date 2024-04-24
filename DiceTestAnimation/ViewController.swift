import UIKit

class ViewController: UIViewController {

    
    let leftDiceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "Кубик_1")
        return imageView
    }()
    
    let rightDiceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(named: "Кубик_2")
        return imageView
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .green.withAlphaComponent(0.7)
        button.layer.cornerRadius = 10
        button.frame = CGRect(x: 50,
                              y: view.frame.height * 0.85,
                              width: view.frame.width - 100,
                              height: 60)
        button.setTitle("Animation Dice", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(tapActionButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        view.addSubview(actionButton)
        
        leftDiceImageView.frame = CGRect(x: view.frame.midX - 60, y: actionButton.frame.minY - 100, width: 50, height: 50)
        leftDiceImageView.image = UIImage(named: "Кубик_1")
        view.addSubview(leftDiceImageView)
        
        rightDiceImageView.frame = CGRect(x: view.frame.midX + 10, y: actionButton.frame.minY - 100, width: 50, height: 50)
        rightDiceImageView.image = UIImage(named: "Кубик_2")
        view.addSubview(rightDiceImageView)
        
    }
    
    @objc func tapActionButton() {
        startAnimatuinDices(with: leftDiceImageView, rightDiceImageView)
    }

    /// Анимация броска кубика
    func startAnimatuinDices(with diceLeft: UIImageView, _ diceRight: UIImageView) {
        let positionXLeftDice = view.frame.midX - 60
        let positionYLeftDice = actionButton.frame.minY - 100
        diceLeft.transform = .identity
        
        let positionXRightDice = view.frame.midX + 10
        let positionYRightDice = actionButton.frame.minY - 100
        diceRight.transform = .identity
        
        DispatchQueue.main.async {
            self.animationJumpDice(with: diceLeft, positionX: positionXLeftDice, positionY: positionYLeftDice, diceValue: 2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55) {
            self.animationJumpDice(with: diceRight, positionX: positionXRightDice, positionY: positionYRightDice, diceValue: 1)
        }
    }
    
    func animationJumpDice(with dice: UIImageView, positionX: CGFloat, positionY: CGFloat, diceValue: Int) {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0) {
            dice.frame = CGRect(x: positionX, y: positionY + 15, width: 50, height: 35)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                dice.frame = CGRect(x: positionX, y: positionY, width: 50, height: 50)
            }
            
            UIView.animate(withDuration: 0.2) {
                dice.frame = CGRect(x: positionX, y: positionY - 70, width: 50, height: 50)
            } completion: { _ in
                UIView.animate(withDuration: 0.3, delay: 0.1) {
                    dice.transform =  CGAffineTransform(rotationAngle: .pi)
                } completion: { _ in
                    UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0) {
                        dice.frame = CGRect(x: positionX, y: positionY + 5, width: 50, height: 45)
                    } completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            dice.frame = CGRect(x: positionX, y: positionY, width: 50, height: 50)
                        }
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    dice.image = UIImage(named: "Кубик_\(diceValue)")
                }
            }
        }
    }

}

