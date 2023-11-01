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
    var rotationCountX : Int = 45
    var rotationCountY : Int = 100
    
    @IBOutlet weak var pedirCartaButton: UIButton!
    @IBOutlet weak var plantarseButton: UIButton!
    @IBOutlet weak var nuevaPartidaButton: UIButton!
    
    
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
        
        viewsCartas.append(imagenView)

        UIView.animate(withDuration: 1) {
            imagenView.frame = CGRect(x:self.rotationCountX, y:self.rotationCountY, width: 100, height: 150)
            imagenView.transform = CGAffineTransform(rotationAngle: CGFloat(0));
        }
        self.rotationCountX += 40 // Update el counter
        
        // si hay mas de 6 cartas en una linea las acomoda abajo
        if viewsCartas.count % 6 == 0 {
            self.rotationCountX = 45
            self.rotationCountY += 100
        }
        // TODO: Check edge case en que salen todas las cartas de 10, 11 y 12
    }
    
    func eliminarCartas() {
        for v in self.viewsCartas {
            v.removeFromSuperview()
        }
        // ya no tenemos imágenes de cartas en pantalla, ponemos el array a vacío
        self.viewsCartas=[]
        
        // reinicia counters
        self.rotationCountX = 45
        self.rotationCountY = 100
    }
    
    func manejadorAlertas() {
        var titleAlerta = ""
        var messageAlerta = ""
        let estado: EstadoJuego = juego.estado
        
        switch estado {
        case .ganaJugador:
            titleAlerta = "Fin del juego"
            messageAlerta = "¡¡Has ganado!!"
        case .sepasaJugador:
            titleAlerta = "Fin del juego"
            messageAlerta = "¡¡Te has pasado!!"
        case .pierdeJugador:
            titleAlerta = "Fin del juego"
            messageAlerta = "¡¡Has perdido!!"
        case .empate:
            titleAlerta = "Fin del juego"
            messageAlerta = "¡¡Has empatado!!"
        case .noIniciado, .turnoJugador:
            return
        }
        
        let alert = UIAlertController(
            title: titleAlerta,
            message: messageAlerta,
            preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(
            title: "OK",
            style: UIAlertAction.Style.default){ (action) in
                // handle response here.
                self.eliminarCartas()
                self.pedirCartaButton.isEnabled = false
                self.plantarseButton.isEnabled = false
            }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func pedirCarta(_ sender: UIButton) {
        let estado = juego.jugadorPideCarta()
        print(estado)

        // Dibujar carta
        if let carta = juego.manoJugador.cartas.last {
            dibujarCarta(carta: carta)
        }
        
        manejadorAlertas()
    }
    
    @IBAction func plantarse(_ sender: UIButton) {
        let estado = juego.jugadorSePlanta()
        print(estado)
        
        manejadorAlertas()
    }

    @IBAction func nuevaPartida(_ sender: UIButton) {
        juego = Juego()
        juego.turnoMaquina()
        print(juego.estado)
        
        self.pedirCartaButton.isEnabled = true
        self.plantarseButton.isEnabled = true
        
        if !juego.baraja.cartas.isEmpty {
            eliminarCartas()
        }
    }
    
}

