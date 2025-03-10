import Foundation
import Combine // 🟢 Importa Combine para manejar programación reactiva y suscripciones.

class MovieViewModel: ObservableObject { // 🔵 Clase que actúa como ViewModel en el patrón MVVM.
    @Published var movies: [Movie] = [] // 🟢 Lista de películas obtenidas desde la API.
    @Published var searchText: String = "" // 🔵 Texto ingresado en la barra de búsqueda.

    private let apiService = APIService() // 🟢 Instancia del servicio que obtiene datos de la API.
    private var cancellables = Set<AnyCancellable>() // 🔵 Conjunto de suscripciones para manejar Combine.

    init() {
        fetchMovies() // 🟢 Llama a la función para obtener las películas al iniciar.

        // ✅ Filtrado de películas en tiempo real cuando cambia el texto de búsqueda
        $searchText // 🔵 Escucha cambios en `searchText`
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main) // 🟢 Espera 500 ms antes de ejecutar la búsqueda (para evitar llamadas innecesarias mientras el usuario escribe).
            .sink { [weak self] searchText in // 🔵 `sink` recibe el nuevo valor de `searchText`.
                self?.filterMovies(with: searchText) // 🟢 Llama a `filterMovies` para actualizar la lista.
            }
            .store(in: &cancellables) // 🔵 Guarda la suscripción para evitar fugas de memoria.
    }
    
    // ✅ Función para obtener las películas más valoradas desde la API
    func fetchMovies() {
        apiService.fetchTopRatedMovies { [weak self] result in // 🔵 Llama al servicio API.
            switch result {
            case .success(let movies):
                self?.movies = movies // 🟢 Actualiza la lista con las películas obtenidas.
            case .failure(let error):
                print("Error fetching movies: \(error)") // 🔴 Muestra un error en consola si falla la llamada a la API.
            }
        }
    }

    // ✅ Función para filtrar películas según el texto ingresado
    func filterMovies(with text: String) {
        if text.isEmpty { // 🔵 Si el campo de búsqueda está vacío...
            fetchMovies() // 🟢 Recarga todas las películas desde la API.
        } else {
            movies = movies.filter { $0.title.lowercased().contains(text.lowercased()) }
            // 🟢 Filtra las películas que contengan el texto en su título (sin importar mayúsculas o minúsculas).
        }
    }
}
