% =====================================================================
%  Ejercicio 1 - Árbol genealógico
% ---------------------------------------------------------------------
%  Convención de lectura: rel(X, Y) significa "X es <rel> de Y".
%  Ejemplo: padre("Juan Francisco Montenegro Muralles",
%                 "Juan Francisco Montenegro Aguirre")
%           ->  Juan Francisco Montenegro Muralles es padre de
%               Juan Francisco Montenegro Aguirre.
%
%  Las personas se escriben como cadenas con su nombre completo; el
%  símbolo ✞ indica que la persona ya falleció.
% =====================================================================

% Para dibujar el árbol en SWISH (ver arbol_familia/1 al final)
:- use_rendering(graphviz).

% ---------------------------------------------------------------------
%  Hechos: progenitor(Progenitor, Hijo)
% ---------------------------------------------------------------------

% Abuelos paternos y sus hijos (mi papá y mis tíos)
progenitor("José Antonio Montenegro Iralda ✞", "Juan Francisco Montenegro Muralles").
progenitor("María Ana Concepción Muralles Morales ✞", "Juan Francisco Montenegro Muralles").
progenitor("José Antonio Montenegro Iralda ✞", "Enriqueta de Jesús Montenegro Muralles").
progenitor("María Ana Concepción Muralles Morales ✞", "Enriqueta de Jesús Montenegro Muralles").
progenitor("José Antonio Montenegro Iralda ✞", "Edgar Rubén Montenegro Muralles ✞").
progenitor("María Ana Concepción Muralles Morales ✞", "Edgar Rubén Montenegro Muralles ✞").
progenitor("José Antonio Montenegro Iralda ✞", "Baudilio Alfredo Montenegro Muralles ✞").
progenitor("María Ana Concepción Muralles Morales ✞", "Baudilio Alfredo Montenegro Muralles ✞").
progenitor("José Antonio Montenegro Iralda ✞", "Berta Delia Montenegro Muralles ✞").
progenitor("María Ana Concepción Muralles Morales ✞", "Berta Delia Montenegro Muralles ✞").

% Abuelos maternos y sus hijos (mi mamá y mis tíos)
progenitor("Rosendo Aguirre Montenegro ✞", "Blanca Estela Aguirre Jerónimo").
progenitor("Pedrina Margarita Jerónimo Tista ✞", "Blanca Estela Aguirre Jerónimo").
progenitor("Rosendo Aguirre Montenegro ✞", "Zoila Marina Aguirre Jerónimo ✞").
progenitor("Pedrina Margarita Jerónimo Tista ✞", "Zoila Marina Aguirre Jerónimo ✞").
progenitor("Rosendo Aguirre Montenegro ✞", "German Cruz Aguirre Jerónimo").
progenitor("Pedrina Margarita Jerónimo Tista ✞", "German Cruz Aguirre Jerónimo").
progenitor("Rosendo Aguirre Montenegro ✞", "Ruperto Arnoldo Aguirre Jerónimo").
progenitor("Pedrina Margarita Jerónimo Tista ✞", "Ruperto Arnoldo Aguirre Jerónimo").

% Mis padres y sus hijos (yo y mis hermanos; Juan José es medio hermano
% por parte de papá)
progenitor("Juan Francisco Montenegro Muralles", "Juan Francisco Montenegro Aguirre").
progenitor("Blanca Estela Aguirre Jerónimo", "Juan Francisco Montenegro Aguirre").
progenitor("Juan Francisco Montenegro Muralles", "José Francisco Montenegro Aguirre").
progenitor("Blanca Estela Aguirre Jerónimo", "José Francisco Montenegro Aguirre").
progenitor("Juan Francisco Montenegro Muralles", "Andrés Alejandro Montenegro Aguirre").
progenitor("Blanca Estela Aguirre Jerónimo", "Andrés Alejandro Montenegro Aguirre").
progenitor("Juan Francisco Montenegro Muralles", "Juan José Montenegro Morales").

% Mis tíos y sus hijos (mis primos)
progenitor("Zoila Marina Aguirre Jerónimo ✞", "Nataly _ Aguirre").
progenitor("Zoila Marina Aguirre Jerónimo ✞", "Luis Pedro _ Aguirre").
progenitor("Zoila Marina Aguirre Jerónimo ✞", "Angél Fajardo Aguirre").
progenitor("Zoila Marina Aguirre Jerónimo ✞", "Victor Fajardo Aguirre").
progenitor("Zoila Marina Aguirre Jerónimo ✞", "Luis Fajardo Aguirre ✞").
progenitor("Zoila Marina Aguirre Jerónimo ✞", "Abhner Hernandéz").
progenitor("Ruperto Arnoldo Aguirre Jerónimo", "Juan Arnoldo Aguirre").
progenitor("Ruperto Arnoldo Aguirre Jerónimo", "César Aguirre").

% Mis hermanos y sus hijos (mis sobrinos)
progenitor("Juan José Montenegro Morales", "José Alejandro Montenegro De Paz").
progenitor("Wendy Gabriela De Paz Muralles", "José Alejandro Montenegro De Paz").
progenitor("Juan José Montenegro Morales", "Sophia Valentina Montenegro De Paz").
progenitor("Wendy Gabriela De Paz Muralles", "Sophia Valentina Montenegro De Paz").
progenitor("José Francisco Montenegro Aguirre", "Kclarens Rubén Alfredo Montenegro Solís").
progenitor("Yuri Solís", "Kclarens Rubén Alfredo Montenegro Solís").
progenitor("José Francisco Montenegro Aguirre", "Dulce Brisa Montenegro Gramajo").
progenitor("Crista Gramajo", "Dulce Brisa Montenegro Gramajo").

% Mi primo Juan Arnoldo y sus hijas
progenitor("Juan Arnoldo Aguirre", "Dayan Aguirre").
progenitor("Juan Arnoldo Aguirre", "Sofía Aguirre").

% ---------------------------------------------------------------------
%  Hechos: hombre(X) y mujer(X)
% ---------------------------------------------------------------------

% Abuelos
hombre("José Antonio Montenegro Iralda ✞").
hombre("Rosendo Aguirre Montenegro ✞").
% Papá y tíos
hombre("Juan Francisco Montenegro Muralles").
hombre("Edgar Rubén Montenegro Muralles ✞").
hombre("Baudilio Alfredo Montenegro Muralles ✞").
hombre("German Cruz Aguirre Jerónimo").
hombre("Ruperto Arnoldo Aguirre Jerónimo").
% Yo, hermanos y primos
hombre("Juan Francisco Montenegro Aguirre").
hombre("José Francisco Montenegro Aguirre").
hombre("Andrés Alejandro Montenegro Aguirre").
hombre("Juan José Montenegro Morales").
hombre("Luis Pedro _ Aguirre").
hombre("Angél Fajardo Aguirre").
hombre("Victor Fajardo Aguirre").
hombre("Luis Fajardo Aguirre ✞").
hombre("Abhner Hernandéz").
hombre("Juan Arnoldo Aguirre").
hombre("César Aguirre").
% Sobrinos
hombre("José Alejandro Montenegro De Paz").
hombre("Kclarens Rubén Alfredo Montenegro Solís").

% Abuelas
mujer("María Ana Concepción Muralles Morales ✞").
mujer("Pedrina Margarita Jerónimo Tista ✞").
% Mamá y tías
mujer("Blanca Estela Aguirre Jerónimo").
mujer("Enriqueta de Jesús Montenegro Muralles").
mujer("Berta Delia Montenegro Muralles ✞").
mujer("Zoila Marina Aguirre Jerónimo ✞").
% Primas y cuñadas
mujer("Nataly _ Aguirre").
mujer("Wendy Gabriela De Paz Muralles").
mujer("Yuri Solís").
mujer("Crista Gramajo").
% Sobrinas
mujer("Sophia Valentina Montenegro De Paz").
mujer("Dulce Brisa Montenegro Gramajo").
mujer("Dayan Aguirre").
mujer("Sofía Aguirre").

% ---------------------------------------------------------------------
%  Reglas
% ---------------------------------------------------------------------

% X es padre / madre de Y
padre(X, Y) :- progenitor(X, Y), hombre(X).
madre(X, Y) :- progenitor(X, Y), mujer(X).

% X es hijo / hija de Y
hijo(X, Y) :- progenitor(Y, X), hombre(X).
hija(X, Y) :- progenitor(Y, X), mujer(X).

% X es abuelo / abuela de Y: progenitor de un progenitor de Y
abuelo(X, Y) :- padre(X, Z), progenitor(Z, Y).
abuela(X, Y) :- madre(X, Z), progenitor(Z, Y).

% Auxiliar: X e Y son hermanos si comparten al menos un progenitor
% (así se incluyen los medios hermanos). distinct/2 evita repetir la
% pareja cuando comparten padre y madre.
hermanos(X, Y) :-
    distinct(X-Y, ( progenitor(P, X), progenitor(P, Y), X \== Y )).

% X es hermano / hermana de Y
hermano(X, Y) :- hermanos(X, Y), hombre(X).
hermana(X, Y) :- hermanos(X, Y), mujer(X).

% X es tío / tía de Y: hermano(a) de un progenitor de Y
tio(X, Y) :- hermano(X, Z), progenitor(Z, Y).
tia(X, Y) :- hermana(X, Z), progenitor(Z, Y).

% X es sobrino / sobrina de Y: hijo(a) de un hermano(a) de Y
sobrino(X, Y) :- hijo(X, Z), hermanos(Z, Y).
sobrina(X, Y) :- hija(X, Z), hermanos(Z, Y).

% ---------------------------------------------------------------------
%  Dibujo del árbol en lenguaje DOT (Graphviz), a partir de los hechos.
%  En SWISH, con :- use_rendering(graphviz). al inicio del programa:
%    ?- arbol_familia(_Dot), Arbol = dot(_Dot).
% ---------------------------------------------------------------------

arbol_familia(Dot) :-
    with_output_to(string(Dot), escribir_familia).

escribir_familia :-
    format("digraph familia {~n"),
    format("  graph [label=\"Árbol genealógico\", labelloc=t, fontname=\"Helvetica-Bold\", fontsize=20, nodesep=0.35, ranksep=0.6, splines=polyline];~n"),
    format("  node  [shape=box, style=\"rounded,filled\", fontname=\"Helvetica\", fontsize=12, width=1, penwidth=1.4];~n"),
    format("  edge  [dir=none, color=\"#555555\", penwidth=1.2];~n"),
    forall(hombre(X), escribir_persona(X, "#dbe9f9", "#2b6cb0")),
    forall(mujer(X), escribir_persona(X, "#fbe3ec", "#c2185b")),
    findall(P, ( padre(P, H), madre(_, H) ), Lista),
    list_to_set(Lista, Padres),
    forall(member(P, Padres), escribir_parejas(P)),
    findall(X, unico_progenitor(X, _), Lista1),
    list_to_set(Lista1, Solos),
    forall(member(X, Solos), escribir_solo(X)),
    format("  subgraph cluster_leyenda { label=\"Leyenda\"; fontname=\"Helvetica\"; fontsize=11; style=\"rounded,dashed\"; color=\"#999999\";~n"),
    format("    leyenda_hombre [label=\"Hombre\", fillcolor=\"#dbe9f9\", color=\"#2b6cb0\", fontsize=10];~n"),
    format("    leyenda_mujer [label=\"Mujer\", fillcolor=\"#fbe3ec\", color=\"#c2185b\", fontsize=10];~n"),
    format("    leyenda_fallecido [label=\"✞ = fallecido(a)\", shape=plaintext, style=\"\", fontsize=10];~n"),
    format("    leyenda_hombre -> leyenda_mujer -> leyenda_fallecido [style=invis];~n  }~n"),
    format("}~n").

escribir_persona(X, Relleno, Borde) :-
    etiqueta(X, Etiqueta),
    format("  \"~w\" [label=\"~w\", fillcolor=\"~w\", color=\"~w\"];~n",
           [X, Etiqueta, Relleno, Borde]).

% Etiqueta en dos líneas: los nombres arriba y los dos apellidos abajo
etiqueta(X, Etiqueta) :-
    split_string(X, " ", "", Palabras),
    agrupar(Palabras, Partes),
    (   append(Nombres, [Apellido1, Apellido2], Partes), Nombres \== []
    ->  atomic_list_concat(Nombres, ' ', Arriba),
        format(string(Etiqueta), "~w\\n~w ~w", [Arriba, Apellido1, Apellido2])
    ;   Etiqueta = X
    ).

% "De Paz" cuenta como un solo apellido y la cruz ✞ va con el último
agrupar([], []).
agrupar(["De", P|Ps], [A|As]) :- !,
    atomic_list_concat(["De", P], ' ', A),
    agrupar(Ps, As).
agrupar([P, "✞"], [A]) :- !,
    atomic_list_concat([P, "✞"], ' ', A).
agrupar([P|Ps], [P|As]) :-
    agrupar(Ps, As).

% Cada padre va con su(s) pareja(s) dentro de un cluster invisible, lo
% que obliga a Graphviz a dibujarlos uno al lado del otro
escribir_parejas(P) :-
    findall(M, ( padre(P, H), madre(M, H) ), Lista),
    list_to_set(Lista, Madres),
    format("  subgraph \"cluster_~w\" { style=invis;~n", [P]),
    format("    { rank=same; \"~w\";", [P]),
    forall(member(M, Madres), format(" \"~w\";", [M])),
    format(" }~n"),
    forall(member(M, Madres),
           format("    \"u_~w_~w\" [label=\"\", shape=point, width=0.08, color=\"#555555\"];~n", [P, M])),
    format("  }~n"),
    forall(member(M, Madres), escribir_pareja(P, M)).

% Cada pareja baja a un punto de unión del que salen sus hijos
escribir_pareja(P, M) :-
    format("  \"~w\" -> \"u_~w_~w\" [weight=4];~n", [P, P, M]),
    format("  \"~w\" -> \"u_~w_~w\" [weight=4];~n", [M, P, M]),
    forall(( padre(P, H), madre(M, H) ),
           format("  \"u_~w_~w\" -> \"~w\";~n", [P, M, H])).

% X es el único progenitor conocido de H
unico_progenitor(X, H) :-
    progenitor(X, H),
    \+ ( progenitor(Y, H), Y \== X ).

% Los hijos de un solo progenitor también bajan por un punto de unión,
% para que queden en la misma fila que el resto de su generación
escribir_solo(X) :-
    format("  \"u_~w\" [label=\"\", shape=point, width=0.08, color=\"#555555\"];~n", [X]),
    format("  \"~w\" -> \"u_~w\" [weight=4];~n", [X, X]),
    forall(unico_progenitor(X, H),
           format("  \"u_~w\" -> \"~w\";~n", [X, H])).
