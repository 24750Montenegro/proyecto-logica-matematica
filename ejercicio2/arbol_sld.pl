% =====================================================================
%  Ejercicio 2 - Árbol de búsqueda (árbol SLD) de camino(X, d, Y)
% ---------------------------------------------------------------------
%  Meta-intérprete que reproduce la resolución SLD de Prolog (regla de
%  selección: la meta de más a la izquierda; búsqueda: las cláusulas en
%  orden) y construye el árbol de búsqueda completo, incluidas las ramas
%  que fallan. El árbol se devuelve en lenguaje DOT para dibujarlo con
%  Graphviz, como hace la herramienta SLDDraw.
%
%  El programa se pasa como texto para conservar los nombres de sus
%  variables; en cada paso las variables de la cláusula usada se
%  renombran con el número de nivel (X1, W1, Z3, ...).
%
%  Uso:
%    ?- programa_camino(P), arbol_sld(P, "camino(X, d, Y)", Dot).
%  En SWISH, para ver el dibujo (con :- use_rendering(graphviz). al
%  inicio del programa y la casilla "table results" desmarcada):
%    ?- programa_camino(_P), arbol_sld(_P, "camino(X, d, Y)", _Dot),
%       Arbol = dot(_Dot).
% =====================================================================

% Mismo programa que camino.pl, cláusula por cláusula (C1 ... C6)
programa_camino([
    "arco(a, b)",
    "arco(a, c)",
    "arco(a, d)",
    "arco(c, d)",
    "camino(X, X, [X])",
    "camino(X, Y, [X|Z]) :- arco(X, W), camino(W, Y, Z)"
]).

% Límite de seguridad para programas con ramas infinitas
profundidad_maxima(30).

% arbol_sld(+Programa, +Consulta, -Dot)
arbol_sld(Textos, Consulta, Dot) :-
    leer_programa(Textos, Programa),
    term_string(Meta, Consulta, [variable_names(Nombres)]),
    conj_a_lista(Meta, Metas),
    arbol(Metas, Nombres, Nombres, Programa, 0, Arbol),
    with_output_to(string(Dot), escribir_dot(Arbol, Textos, Consulta)).

% ---------------------------------------------------------------------
%  Lectura del programa
% ---------------------------------------------------------------------

leer_programa(Textos, Programa) :-
    findall(clausula(Id, Cabeza, Cuerpo, Vars),
            ( nth1(Id, Textos, Texto),
              term_string(Clausula, Texto, [variable_names(Vars)]),
              cabeza_cuerpo(Clausula, Cabeza, Cuerpo) ),
            Programa).

cabeza_cuerpo((Cabeza :- Cuerpo), Cabeza, Metas) :- !,
    conj_a_lista(Cuerpo, Metas).
cabeza_cuerpo(Cabeza, Cabeza, []).

conj_a_lista(true, []) :- !.
conj_a_lista((A, B), Metas) :- !,
    conj_a_lista(A, MA),
    conj_a_lista(B, MB),
    append(MA, MB, Metas).
conj_a_lista(A, [A]).

% ---------------------------------------------------------------------
%  Construcción del árbol
%    Arbol ::= meta(Resolvente, Ramas)  nodo con metas pendientes
%            | exito(Respuesta)         cláusula vacía
%            | limite(Resolvente)       profundidad máxima alcanzada
%    Rama  ::= rama(NumClausula, Unificador, Arbol)
%  Un nodo meta sin ramas es un nodo de fallo.
% ---------------------------------------------------------------------

arbol([], Consulta, Nombres, _, _, exito(Respuesta)) :- !,
    respuesta(Consulta, Nombres, Respuesta).
arbol(Metas, _, Nombres, _, Nivel, limite(Resolvente)) :-
    profundidad_maxima(Max),
    Nivel >= Max, !,
    resolvente(Metas, Nombres, Resolvente).
arbol([Meta|Resto], Consulta, Nombres, Programa, Nivel, meta(Resolvente, Ramas)) :-
    resolvente([Meta|Resto], Nombres, Resolvente),
    Nivel1 is Nivel + 1,
    libres(Nombres, Libres),
    findall(rama(Id, Theta, Hijo),
            ( member(clausula(Id, Cabeza0, Cuerpo0, Vars0), Programa),
              copy_term(c(Cabeza0, Cuerpo0, Vars0), c(Cabeza, Cuerpo, Vars)),
              renombrar(Vars, Nivel1, Nuevas),
              append(Libres, Nuevas, Antes),
              unify_with_occurs_check(Meta, Cabeza),
              unificador(Antes, Theta),
              append(Cuerpo, Resto, Metas1),
              append(Nombres, Nuevas, Nombres1),
              arbol(Metas1, Consulta, Nombres1, Programa, Nivel1, Hijo) ),
            Ramas).

renombrar([], _, []).
renombrar([Nombre=V|Vs], Nivel, [Nuevo=V|Ns]) :-
    atom_concat(Nombre, Nivel, Nuevo),
    renombrar(Vs, Nivel, Ns).

% libres(+Nombres, -Libres): variables todavía libres, una vez cada una;
% si dos nombres comparten la variable se conserva el más antiguo.
libres(Nombres, Libres) :-
    libres(Nombres, [], Libres).

libres([], _, []).
libres([N=V|Ns], Vistas, Libres) :-
    (   var(V), \+ contiene(Vistas, V)
    ->  Libres = [N=V|Libres1],
        libres(Ns, [V|Vistas], Libres1)
    ;   libres(Ns, Vistas, Libres)
    ).

contiene(Vs, V) :- member(W, Vs), W == V, !.

% ---------------------------------------------------------------------
%  Etiquetas (texto con los nombres de las variables)
% ---------------------------------------------------------------------

texto(Termino, Vn, Texto) :-
    format(string(Texto), "~W",
           [Termino, [variable_names(Vn), quoted(true), spacing(next_argument)]]).

resolvente(Metas, Nombres, Texto) :-
    libres(Nombres, Vn),
    findall(T, ( member(M, Metas), texto(M, Vn, T) ), Ts),
    atomic_list_concat(Ts, ', ', Texto).

respuesta(Consulta, Nombres, Texto) :-
    libres(Nombres, Vn),
    findall(T, ( member(N=V, Consulta),
                 texto(V, Vn, VT),
                 format(string(T), "~w = ~w", [N, VT]) ),
            Ts),
    atomic_list_concat(Ts, ', ', Texto).

% unificador(+Antes, -Texto): unificador más general del paso, calculado
% sobre las variables que estaban libres antes de unificar.
unificador(Antes, Texto) :-
    libres(Antes, Vn),
    findall(L, ( append(Previas, [N=V|_], Antes),
                 ligadura(N, V, Previas, Vn, L) ),
            Ls),
    atomic_list_concat(Ls, ', ', Cuerpo),
    format(string(Texto), "{~w}", [Cuerpo]).

ligadura(N, V, _, Vn, L) :-
    nonvar(V), !,
    texto(V, Vn, T),
    format(string(L), "~w/~w", [N, T]).
ligadura(N, V, Previas, _, L) :-
    member(M=W, Previas), W == V, !,
    format(string(L), "~w/~w", [N, M]).

% ---------------------------------------------------------------------
%  Salida en DOT (Graphviz)
% ---------------------------------------------------------------------

escribir_dot(Arbol, Textos, Consulta) :-
    format("digraph arbol_sld {~n"),
    format("  graph [label=\"Árbol SLD de  ?- ~w.\", labelloc=t, fontname=\"Helvetica-Bold\", fontsize=18, nodesep=0.3, ranksep=0.5];~n", [Consulta]),
    format("  node  [shape=box, style=\"rounded,filled\", fontname=\"Courier New\", fontsize=12, color=\"#3b6ea8\", fillcolor=\"#eaf1fb\"];~n"),
    format("  edge  [fontname=\"Helvetica\", fontsize=10, color=\"#555555\", arrowsize=0.7];~n"),
    escribir_programa(Textos),
    escribir_nodo(Arbol, 0, 1-1, _),
    format("  { rank=same; programa; n0; }~n"),
    format("  programa -> n0 [style=invis];~n"),
    format("}~n").

escribir_programa(Textos) :-
    format("  programa [shape=note, style=filled, fillcolor=\"#fff8e1\", color=\"#b08900\", fontsize=11, label=\"Programa\\l\\l"),
    forall(nth1(I, Textos, T),
           ( escapar(T, E), format("C~w:  ~w.\\l", [I, E]) )),
    format("\"];~n").

% escribir_nodo(+Arbol, +Id, +Estado0, -Estado)
%   Estado = SiguienteId-SiguienteRespuesta (en orden de búsqueda)
escribir_nodo(meta(Resolvente, Ramas), Id, S0, S) :-
    escapar(Resolvente, E),
    format("  n~w [label=\"~w\"];~n", [Id, E]),
    (   Ramas == []
    ->  S0 = N0-R, N is N0 + 1, S = N-R,
        format("  n~w [label=\"fallo\", fontname=\"Helvetica-Bold\", fontcolor=\"#b71c1c\", color=\"#b71c1c\", fillcolor=\"#fdecea\"];~n", [N0]),
        format("  n~w -> n~w;~n", [Id, N0])
    ;   escribir_ramas(Ramas, Id, S0, S)
    ).
escribir_nodo(exito(Respuesta), Id, N-R0, N-R) :-
    R is R0 + 1,
    escapar(Respuesta, E),
    format("  n~w [label=\"\u25A1\\nrespuesta ~w:\\n~w\", color=\"#2e7d32\", fillcolor=\"#e3f4e4\"];~n", [Id, R0, E]).
escribir_nodo(limite(Resolvente), Id, S, S) :-
    escapar(Resolvente, E),
    format("  n~w [label=\"~w\\n...\", style=\"rounded,dashed\"];~n", [Id, E]).

escribir_ramas([], _, S, S).
escribir_ramas([rama(C, Theta, Hijo)|Rs], Padre, N0-R0, S) :-
    N1 is N0 + 1,
    escapar(Theta, E),
    format("  n~w -> n~w [label=\" C~w\\n ~w\"];~n", [Padre, N0, C, E]),
    escribir_nodo(Hijo, N0, N1-R0, S1),
    escribir_ramas(Rs, Padre, S1, S).

escapar(Texto, Escapado) :-
    atomic_list_concat(Partes, '"', Texto),
    atomic_list_concat(Partes, '\\"', Escapado).
