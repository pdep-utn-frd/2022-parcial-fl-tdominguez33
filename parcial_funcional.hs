data Jugador = Jugador {motivado :: Bool, habilidad :: Float} deriving (Show, Eq)

---- Punto 1 ----
practicaConPelota :: Jugador -> Jugador
practicaConPelota (Jugador motivado habilidad) =
    (Jugador (not(motivado)) habilidad)

correr :: Float -> Jugador -> Jugador
correr minutos (Jugador motivado habilidad) =
    (Jugador motivado (agregarHabilidad habilidad minutos))

agregarHabilidad :: Float -> Float -> Float
agregarHabilidad habilidad minutos = 
    habilidad * (1 + minutos/1000)

---- Punto 2 ----
data Video = UnVideo {aparecen :: [String], duracion :: Int} deriving Show

verVideos :: [Video] -> Jugador -> Jugador
verVideos listaVideos (Jugador motivado habilidad)
  | (duracionTotal listaVideos) > 1000 = (Jugador True (habilidad * multiplicadorHabilidad(cuantasVecesMaradona listaVideos)))
  | otherwise = (Jugador False (habilidad * multiplicadorHabilidad(cuantasVecesMaradona listaVideos)))


multiplicadorHabilidad :: Float -> Float
multiplicadorHabilidad cantidadMaradonas = 
    1 + (cantidadMaradonas / 100)

duracionTotal :: [Video] -> Int
duracionTotal = 
    (sum . (map obtenerMinutos))
    
obtenerMinutos :: Video -> Int
obtenerMinutos (UnVideo listaApariciones duracion) = duracion

cuantasVecesMaradona :: [Video] -> Float
cuantasVecesMaradona listaVideos = 
    fromIntegral ((length . (filter (apareceMaradona))) listaVideos)

apareceMaradona :: Video -> Bool
apareceMaradona (UnVideo listaApariciones duracion) = 
    elem "maradona" listaApariciones

-- Si la lista fuera infinita no seria un problema hasta la ejecuciòn del programa, esto es debido
-- a que Haskell utiliza evalucacion perezosa en lugar de evaluacion diferida como la mayoria de 
-- los lenguajes.
-- A la hora de ejecutarlo la funcion no terminaria de ejecutarse nunca puesto que en este caso estamos evaluando
-- elemento a elemento obligando a Haskell a tratar con todos los valores, lo cual, por la naturaleza de la lista,
-- jamas terminara.

---- Punto 3 ----
-- Jugar a un determinado juego afecta la habilidad de un jugador y su motivacion
data Juego = Juego {genero :: String} deriving Show

fifa = Juego {genero = "deportes"}
callOfDuty = Juego {genero = "disparos"}
candyCrush = Juego {genero = "movil"}

jugarPlay :: Juego -> Jugador -> Jugador
jugarPlay (Juego genero) (Jugador motivado habilidad)
    | genero == "deportes"  = (Jugador True (habilidad * 2))
    | genero == "disparos"  = (Jugador motivado (habilidad * 1.3))
    | genero == "movil"     = (Jugador False (habilidad * 0.5))
    | otherwise = (Jugador True habilidad)

---- Punto 4 ----
enQueCondiciones :: Jugador -> Float
enQueCondiciones (Jugador motivado habilidad)
    | motivado = (habilidad * 1.5)
    | otherwise = habilidad

---- Punto 5 ----
mejorOpcion :: (Jugador -> Jugador) -> (Jugador -> Jugador) -> Jugador -> Jugador
mejorOpcion ejercicio1 ejercicio2 jugador
    | (enQueCondiciones . ejercicio1) jugador > (enQueCondiciones . ejercicio2) jugador = ejercicio1 jugador
    | otherwise = ejercicio2 jugador


-- Ejemplo 1 --
verListaDeVideos = verVideos listaVideos
-- mejorOpcion practicaConPelota verListaDeVideos messi

-- Respuesta:
-- Jugador {motivado = False, habilidad = 101.0}

-- Ejemplo 2 --
practicaPelotaYPlay = ((jugarPlay callOfDuty) . practicaConPelota)
-- mejorOpcion practicaPelotaYPlay practicaConPelota messi

-- Respuesta:
-- Jugador {motivado = False, habilidad = 130.0}

---- Elementos de Prueba ----
messi = Jugador {motivado = True, habilidad = 100.0}
manoDeDios = UnVideo {aparecen = ["maradona"], duracion = 5}
mundial2010 = UnVideo {aparecen = ["messi", "shakira"], duracion = 40}
listaVideos = [manoDeDios, mundial2010]