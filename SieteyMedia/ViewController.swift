//
//  ViewController.swift
//  SieteyMedia
//
//  Created by Dianelys Saldaña on 10/28/23.
//

import UIKit

class ViewController: UIViewController {
    
    var juego : Juego!
    var viewsCartas : [UIImageView] = []
    
    // Counter para ir rotando posición de carta dibujada en x
    var rotationCount : Int = 40

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor =  UIColor.blue
    }
    
    func dibujarCarta(carta: Carta) {
        let valor = String(carta.valor)
        let palo = carta.palo.rawValue
        let img = valor + palo

        let imagen = UIImage(named: img)
        let imagenView = UIImageView(image: imagen)
        imagenView.frame = CGRect(x:-200,y:-200,width: 200, height: 300)
        //La rotamos, para que al "repartirla" haga un efecto de giro
        imagenView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))

        self.view.addSubview(imagenView)

        UIView.animate(withDuration: 1) {
            imagenView.frame = CGRect(x:self.rotationCount, y:100, width: 100, height: 150)
            imagenView.transform = CGAffineTransform(rotationAngle: CGFloat(0));
        }
        self.rotationCount += 40 // Update de counter
    }
    
    @IBAction func pedirCarta(_ sender: UIButton) {
        let estado = juego.jugadorPideCarta()
        print(estado)

        // Dibujar carta
        if let carta = juego.manoJugador.cartas.last {
            dibujarCarta(carta: carta)
        }
    }
    
    @IBAction func plantarse(_ sender: UIButton) {
        let estado = juego.jugadorSePlanta()
        print(estado)
    }

    @IBAction func nuevaPartida(_ sender: UIButton) {
        juego = Juego()
        juego.turnoMaquina()
        print(juego.estado)
    }
    
}

