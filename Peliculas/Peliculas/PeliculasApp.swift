//
//  PeliculasApp.swift
//  Peliculas
//
//  Created by Veronica on 23/2/25.
//

import SwiftUI // 📌 Importamos SwiftUI, el framework principal para crear la interfaz de usuario.

@main // ✅ Indicamos que esta es la estructura principal de la aplicación.
struct PeliculasApp: App { // 📌 Define la estructura de la app, siguiendo el protocolo `App` en SwiftUI.
    
    var body: some Scene { // 📌 Define la escena principal de la aplicación.
        WindowGroup { // ✅ Crea una ventana principal donde se mostrará la interfaz.
            MovieListView() // ✅ Indica que `MovieListView` será la primera vista de la app.
        }
    }
}

