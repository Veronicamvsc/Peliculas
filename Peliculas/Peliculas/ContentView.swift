//
//  ContentView.swift
//  Peliculas
//
//  Created by Veronica on 23/2/25.
//

import SwiftUI // 📌 Importamos SwiftUI, el framework para construir la interfaz de usuario.

struct ContentView: View { // 📌 Define una vista llamada `ContentView` que sigue el protocolo `View`.
    var body: some View { // ✅ Define la estructura visual de la vista.
        Text("Hello, world!") // ✅ Muestra un texto en pantalla con el mensaje "Hello, world!".
            .padding() // ✅ Agrega un espaciado alrededor del texto para que no esté pegado a los bordes.
    }
}

struct ContentView_Previews: PreviewProvider { // 📌 Estructura para previsualizar la vista en Xcode.
    static var previews: some View { // ✅ Método requerido para mostrar la vista en la herramienta de previsualización.
        ContentView() // ✅ Muestra `ContentView` en la vista previa.
    }
}

