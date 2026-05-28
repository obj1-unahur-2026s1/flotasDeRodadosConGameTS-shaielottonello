class Corsa {
    var color 
    method capacidad() = 4
    method velocidad() = 150
    method peso() = 1300
    method pintarDe(unColor) {color = unColor}
    method color() = color
}

class Kwid {
    var tieneTanqueAdicional 
    method agregarTanqueAdicional(){tieneTanqueAdicional = true}
    method quitarTanqueAdicional(){tieneTanqueAdicional = false}
    method color() = "azul"
    method capacidad() = if (tieneTanqueAdicional) 3 else 4
    method velocidad() = if (tieneTanqueAdicional) 110 else 120
    method peso() = 1200 + if (tieneTanqueAdicional) 150 else 0

}

object trafic {
    var interior = comodo
    var motor = bataton

    method cambiarInterior(unInterior) {interior=unInterior}
    method cambiarMotor(unMotor) {motor=unMotor}
    method peso() = 4000 + interior.peso() + motor.peso()
    method capacidad() = interior.capacidad()
    method color() = "blanco"
    method velocidad() = motor.velocidad()
}

object comodo {
    method capacidad() = 5
    method peso() = 700
}

object popular {
    method capacidad() = 12
    method peso() = 1000
}

object bataton {
    method velocidad() = 80
    method peso() = 500
}

object pulenta {
    method velocidad() = 130
    method peso() = 800
}

class AutoEspecial {
    const velocidad
    const peso
    const capacidad 
    var color
    method velocidad() = velocidad
    method peso() = peso
    method capacidad() = capacidad
    method pintarDe(unColor) {color = unColor}
    method color() = color
}

class Dependencia {
    const flota = []
    const empleados
    const pedidos = #{}


    method flota() = flota
    method empleados() = empleados
    method agregarPedido(unPedido) {pedidos.add(unPedido)}
    method quitarPedido(unPedido) {pedidos.remove(unPedido)}
    method totalPasajerosDePedidos() {
        return pedidos.sum({p=>p.cantidadDePasajeros()})
    }

    method agregar(unRodado) {flota.add(unRodado)}
    method quitar(unRodado) {flota.remove(unRodado)}
    method pesoTotalFlota() = flota.sum({r=> r.peso()})
    method estaBienEquipada() {
        return flota.size() > 2 and self.todosVanA(100)
    }
    method todosVanA(unaVelocidad) = flota.all({r => r.velocidad() >= 100})
    method capacidadTotalEnColor(color) {
        return self.flotaDeColor(color).sum({r => r.capacidad()})
    }
    method flotaDeColor(color) = flota.filter({r=> r.color() == color})
    method colorDelRodadoMasRapido() {
        return self.rodadoMasRapido().color()
    }
    method rodadoMasRapido() = flota.max({r => r.velocidad()})
    method capacidadFaltante() {
        return (empleados - self.capacidadFlota()).max(0)
    }
    method capacidadFlota() = flota.sum({r=> r.capacidad()})
    method esGrande() = empleados >= 40 && flota.size() >= 5

    method quePedidosNoPuedenSerSatisfechosPorNingunAuto() {
        return pedidos.filter({p=>!self.algunAutoSatisface(p)})
    }

    method algunAutoSatisface(unPedido) {
        return flota.any({a => unPedido.puedeSatisfacerlo(a)})
    }


}

class Pedido {
    const distancia 
    var tiempoMaximo
    var cantidadPasajeros
    const coloresIncompatibles = #{}
    method cantidadPasajeros() = cantidadPasajeros
    method cambiarCantidadPasajeros(nuevaCantidad) {cantidadPasajeros = nuevaCantidad}
    method velocidadRequerida() {
        return distancia.div(tiempoMaximo)
    }
    method puedeSatisfacerlo(unAuto) {
        return 
        unAuto.velocidad() >= self.velocidadRequerida() + 10
        and unAuto.capacidad() >= cantidadPasajeros
        and !coloresIncompatibles.contains(unAuto.color())
    }
    method agregarColoresIncompatibles(unColor) = coloresIncompatibles.add(unColor)
    //falta acelerar y relajar
}
