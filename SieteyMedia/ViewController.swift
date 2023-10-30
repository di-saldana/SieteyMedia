//
//  ViewController.swift
//  SieteyMedia
//
//  Created by Dianelys Saldaña on 10/28/23.
//

import UIKit

class ViewController: UIViewController {
    
    var juego : Juego!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func pedirCarta(_ sender: UIButton) {
        let estado = juego.jugadorPideCarta()
        print(estado)
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

