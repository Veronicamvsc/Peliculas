import Foundation // 🔵 Importa Foundation, necesario para manejar URLs, JSON y red.

class APIService { // 🟢 Define la clase `APIService`, encargada de hacer llamadas a la API.

    // ✅ Función para obtener las películas más valoradas
    func fetchTopRatedMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        // 🔵 Construimos la URL de la API con el endpoint "top_rated"
        guard let url = URL(string: "\(Constants.baseURL)/movie/top_rated?language=es-ES") else {
            return // 🔴 Si la URL no es válida, se sale de la función sin hacer la petición.
        }

        // ✅ Configuración de la solicitud HTTP (Request)
        var request = URLRequest(url: url) // 🔵 Crea una solicitud con la URL.
        request.httpMethod = "GET" // 🟢 Especifica que es una solicitud GET (consulta de datos).

        // 🔵 Cabeceras necesarias para la API
        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // 🟢 Indica que el contenido será JSON.
        request.setValue(Constants.bearerToken, forHTTPHeaderField: "Authorization") // ✅ Agrega el Bearer Token para autenticación.

        // ✅ Inicia la solicitud de red con URLSession
        URLSession.shared.dataTask(with: request) { data, response, error in
            // 🔴 Manejo de error si falla la conexión
            if let error = error {
                completion(.failure(error)) // 🟢 Devuelve el error al llamar `completion`.
                return
            }
            
            // 🔴 Verifica si se recibió data válida
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                // 🟢 Si no hay datos, devuelve un error personalizado.
                return
            }
            
            do {
                // ✅ Decodifica la respuesta JSON en un objeto `MovieResponse`
                let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                
                // 🔵 Llama al completion en el hilo principal para actualizar la UI
                DispatchQueue.main.async {
                    completion(.success(movieResponse.results)) // 🟢 Devuelve la lista de películas.
                }
            } catch {
                completion(.failure(error)) // 🔴 Manejo de error si falla el parsing del JSON.
            }
        }.resume() // 🔵 Inicia la tarea de red.
    }
}

