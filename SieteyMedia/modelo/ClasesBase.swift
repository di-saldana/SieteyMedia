//
//  ClasesBase.swift
//  SieteyMedia
//
//  Created by Dianelys Saldaña on 10/28/23.
//
import Foundation
import UIKit


// Enumerado Palo (0.25 puntos)
// Un enum para representar los cuatro palos de la baraja. Recuerda que son bastos, copas, espadas y oros. Haz que sea internamente un String (: String), así su propiedad .rawValue será una cadena y podrás mostrar el nombre del palo

enum Palo: String, CaseIterable {
    case bastos, copas, espadas, oros
}

enum EstadoJuego {
    //pierdeJugador sería que pierde porque la máquina está más cerca del 7.5
    //sepasaJugador sería que pierde porque se ha pasado
    case noIniciado, turnoJugador, ganaJugador, sepasaJugador, pierdeJugador, empate
}


// Clase Carta (0.5 puntos)

// Propiedades: valor entero y palo, de tipo Palo
// Métodos:
    // Inicializador: se le pasa un valor y un palo. Podría fallar si el valor que se le pasa no es correcto (recordad que el 8 y el 9 no se usan y que evidentemente no valen cartas menores que 1 ni mayores que 12). Por tanto necesitamos un failable initializer.
    // Descripcion: debe devolver un String con el nombre de la carta: el 1 de oros, el 10 de bastos,...

class Carta {
    let valor: Int
    let palo: Palo
    
    // Failable initializer
    init?(valor: Int, palo: Palo) {
        if (1...12).contains(valor) && valor != 8 && valor != 9 {
            self.valor = valor
            self.palo = palo
        } else {
            return nil
        }
    }
    
    func descripcion() -> String {
        return "El \(valor) de \(palo)"
    }
}


// Clase Mano (0.75 puntos)
// Un conjunto de cartas

// Propiedades almacenadas: cartas, un array de Carta
// Propiedades computadas: tamaño, la longitud del array (su propiedad count)
// Métodos:
    // El inicializador de la clase debe inicializar cartas como un array vacío (también lo podéis hacer al definir la propiedad)
    // addCarta: se le pasa una carta y la añade a la mano
    // getCarta: se le pasa una posición (empezando por 0) y devuelve la carta como un opcional. Si la posición es menor que 0 o mayor o igual que el tamaño, debería devolver nil

class Mano {
    var cartas: [Carta]
    
    var tamano: Int {
        return cartas.count
    }
    
    init() {
        self.cartas = [Carta]()
    }
    
    func addCarta(carta: Carta) {
        cartas.append(carta)
    }
    
    func getCarta(pos: Int) -> Carta? {
        if pos < 0 || pos >= tamano {
            return nil
        }
        return cartas[pos]
    }
}


// Clase Baraja
// Representa a todas las cartas de la baraja. Del 1 al 12 de los cuatro palos, menos 8 y 9.

class Baraja {
    var cartas: [Carta] = []

    init() {
        for palo in [Palo.bastos, Palo.espadas, Palo.copas, Palo.oros] {
            for valor in 1...12 {
                if valor != 8 && valor != 9 {  //El 8 y el 9 no se suelen usar
                    //Aquí crearíais la nueva carta y la añadiríais al array "cartas"
                    let carta = Carta(valor: valor, palo: palo)!
                    cartas.append(carta)
                }
            }
        }
    }

    func repartirCarta() -> Carta? {
        return cartas.popLast()
    }
    
    func barajar() {
        cartas.shuffle()
    }

}
