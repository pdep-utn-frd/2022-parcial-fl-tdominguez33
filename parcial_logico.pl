% jugador(nombre, habilidad, estadoDeAnimo)
jugador(messi, 100, muyMotivado).
jugador(neymar, 300, muyMotivado).

%video(minutos, titulo, personajePrincipal)
video(120, golesDeLaHistoria, maradona).
video(10, mundial2010, messi).

% vioVideo(jugador, tituloDelVideo)
vioVideo(messi, mundial2010).

%%%% Punto 1 %%%%
ayudaVerVideo(Jugador, Video) :-
    jugador(Jugador, _, pocoMotivado),
    video(Duracion, Video, _),
    Duracion > 100.

ayudaVerVideo(Jugador, Video) :-
    jugador(Jugador, _, _),
    video(_, Video, maradona).

ayudaVerVideo(Jugador, Video) :-
    jugador(Jugador, Habilidad, Motivacion),
    video(_, Video, _),
    Habilidad > 200,
    Motivacion \= sinMotivacion.

%%%% Punto 2 %%%%
ayudoVerTodosVideos(Jugador) :-
    forall(vioVideo(Jugador, Video), ayudaVerVideo(Jugador, Video)).

%%%% Punto 3 %%%%
ayudaATodos(Video) :-
    forall(jugador(Jugador, _, _), ayudaVerVideo(Jugador, Video)).

%%%% Punto 4 %%%%
recomendaciones(Jugador, Video) :-
    ayudaVerVideo(Jugador, Video),
    not(vioVideo(Jugador, Video)).

%%%% Punto 5 %%%%
% Todos los predicados son completamente inversibles, esto quiere decir que se pueden utilizar variables
% en todos los parametros de los distintos predicados.
% Esto es asì principalmente porqueno se utilizan comparaciones de mayor o menor, is, entre otros
% elementos que afectan a la inversibilidad de los predicados.
% Todas las variables estan ligadas a la hora de ejecutar el predicado.