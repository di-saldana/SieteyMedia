//: - Son lo que en aplicaciones *enterprise* se llaman colas de mensajes. Implementan el protocolo publicar/suscribir
//: - Cuando alquien quiere avisar al resto del sistema, "publica" una notificación asignándole un nombre, y opcionalmente un *payload* (datos asociados)
//: - El que quiere recibir la notificación indica el nombre de la que le interesa, y qué método o clausura ejecutar cuando se reciba
//: - El encargado de gestionar las notificaciones es el `NotificationCenter`. Hay uno por defecto, y se pueden crear más
//: - Al "notification center" es a quien le decimos que envíe las notificaciones o que queremos suscribirnos a alguna

import Foundation

extension Notification.Name {
    static let saludo = Notification.Name("saludo")
}





class Emisor {
    func enviar(subject:String, mensaje:String) {
        //Obtenemos el centro de notificaciones por defecto
        //Las notificaciones tienen un nombre, un objeto que las envía (si lo ponemos a nil no queda constancia de quién) y datos adicionales, un diccionario con los datos que queramos
        let nc = NotificationCenter.default
        nc.post(name: Notification.Name(subject), object: nil, userInfo: ["valor":1, "mensaje":mensaje])
    }
}

 
class Receptor {
    func suscribirse(subject: String) {
        let nc = NotificationCenter.default
        //primer parámetro: quién va a recibir la notificación -> nosotros (self)
        //selector: al recibir la notificación se llama al método "recibir"
        //name: nombre de la notificación que nos interesa
        //object: objeto del que nos interesa recibir notificaciones. nil == cualquiera
        nc.addObserver(self, selector:#selector(self.recibir), name:Notification.Name(subject), object: nil)
        
    }
    
    @objc func recibir(notificacion:Notification) {
        print("¡¡notificación recibida!!")
        if let userInfo = notificacion.userInfo {
            let mensaje = userInfo["mensaje"] as! String
            print("Me dicen: \(mensaje)")
        }
    }
}

var e = Emisor()
var r = Receptor()
r.suscribirse(subject: "saludo")
e.enviar(subject: "saludo", mensaje:"holaaaa")




