
import UIKit
import PlaygroundSupport

//inicializar la parte gráfica para el plaground
//ESTO NO HAY QUE HACERLO EN UNA APP NORMAL
let vc = UIViewController()
PlaygroundPage.current.liveView = vc
vc.view.backgroundColor =  UIColor.green


//Esta parte la puedes tomar como ejemplo para el ejercicio
let imagen = UIImage(named: "1copas")
let imagenView = UIImageView(image: imagen)
imagenView.frame = CGRect(x:-200,y:-200,width: 200, height: 300)
//La rotamos, para que al "repartirla" haga un efecto de giro
imagenView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))

//si estamos en un viewcontroller de una app, NO sería "vc" sino "self"
vc.view.addSubview(imagenView)

UIView.animate(withDuration: 1) {
    imagenView.frame = CGRect(x:200,y:100, width: 100, height: 150)
    imagenView.transform = CGAffineTransform(rotationAngle: CGFloat(0));
}

