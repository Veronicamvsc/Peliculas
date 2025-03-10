//
//  Constants.swift
//  Peliculas
//
//  Created by Veronica on 23/2/25.
//

import Foundation // 📌 Importamos Foundation, ya que trabajamos con URLs y datos.

struct Constants { // 📌 Definimos una estructura para almacenar constantes globales.
    
    static let bearerToken = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJiMjRlNDRiOTNkMGFjNzRkM2RiMTcxYWZhZTI0ZWU1MCIsIm5iZiI6MTc0MDMzMjU3Ny43OTQsInN1YiI6IjY3YmI1ZTIxMzNkNzQ5Y2MzOWJlOWViMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GNeLKop_HILMYvT9c8lLlbiraq6kwj35y3F2tbEBsbo"
    // ✅ Bearer Token necesario para autenticación en la API de The Movie Database (TMDB).
    // ✅ Se usa en la cabecera HTTP `Authorization` para acceder a los datos de la API.
    // ⚠️ **Nota importante**: Nunca incluyas tokens directamente en el código fuente en producción.
    //    Se recomienda almacenarlos en variables de entorno o usar un servicio seguro.

    static let baseURL = "https://api.themoviedb.org/3"
    // ✅ URL base de la API de TMDB.
    // ✅ Todos los endpoints de la API se construyen a partir de esta base.
    // ✅ Ejemplo de una URL completa para obtener las películas más valoradas:
    //    "https://api.themoviedb.org/3/movie/top_rated?language=es-ES"
}
