//
//  ClasesBase.swift
//  SieteyMedia
//
//  Created by Dianelys Saldaña on 10/28/23.
//
import Foundation
import UIKit

// Ejercicios adicionales de Swift Básico (1.5 puntos)
// Baraja Espanola: https://www.salonhogar.net/Enciclopedia/Baraja_espanola/Indice.htm


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

class Baraja {
    var cartas: [Carta] = []

    init() {
        for palo in Palo.allCases {
            for valor in 1...7 {
                if let carta = Carta(valor: valor, palo: palo) {
                    cartas.append(carta)
                }
            }
            for valor in 10...12 {
                if let carta = Carta(valor: valor, palo: palo) {
                    cartas.append(carta)
                }
            }
        }
    }

    func barajar() {
        cartas.shuffle()
    }

    func repartirCarta() -> Carta? {
        return cartas.popLast()
    }
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


// Programa principal
// Como "programa principal" para probar las clases anteriores puedes ejecutar este código. Si todo es correcto deberían aparecer en pantalla las tres cartas añadidas a la mano

//var mano = Mano()
//
//var carta1 = Carta(valor: 1, palo: .oros)!
//var carta2 = Carta(valor: 10, palo: .espadas)!
//var carta3 = Carta(valor: 7, palo: .copas)!
//
//mano.addCarta(carta: carta1)
//mano.addCarta(carta: carta2)
//mano.addCarta(carta: carta3)
//print("Hay \(mano.tamano) cartas")
//
//for num in 0..<mano.tamano {
//    if let carta = mano.getCarta(pos:num) {
//        print(carta.descripcion())
//    }
//}
