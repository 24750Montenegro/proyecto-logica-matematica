% =====================================================================
%  Ejercicio 1 - Árbol genealógico
% ---------------------------------------------------------------------
%  Convención de lectura: rel(X, Y) significa "X es <rel> de Y".
%  Ejemplo: padre(carlos, daniel)  ->  carlos es padre de daniel.
%
%  Los nombres son de ejemplo: reemplazarlos por los de la familia real.
% =====================================================================

% ---------------------------------------------------------------------
%  Hechos: progenitor(Progenitor, Hijo)
% ---------------------------------------------------------------------

% Abuelos paternos -> sus hijos
progenitor(jose, carlos).
progenitor(maria, carlos).
progenitor(jose, ana).
progenitor(maria, ana).
progenitor(jose, luis).
progenitor(maria, luis).

% Abuelos maternos -> sus hijas
progenitor(pedro, elena).
progenitor(rosa, elena).
progenitor(pedro, marta).
progenitor(rosa, marta).

% Padres -> nietos
progenitor(carlos, daniel).
progenitor(elena, daniel).
progenitor(carlos, lucia).
progenitor(elena, lucia).
progenitor(carlos, diego).
progenitor(elena, diego).
progenitor(miguel, sofia).
progenitor(ana, sofia).
progenitor(miguel, pablo).
progenitor(ana, pablo).
progenitor(jorge, valeria).
progenitor(marta, valeria).

% ---------------------------------------------------------------------
%  Hechos: hombre(X) y mujer(X)
% ---------------------------------------------------------------------

hombre(jose).
hombre(pedro).
hombre(carlos).
hombre(luis).
hombre(miguel).
hombre(jorge).
hombre(daniel).
hombre(diego).
hombre(pablo).

mujer(maria).
mujer(rosa).
mujer(ana).
mujer(elena).
mujer(marta).
mujer(lucia).
mujer(sofia).
mujer(valeria).

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

% Auxiliar: X e Y son hermanos si tienen el mismo padre y la misma madre
hermanos(X, Y) :-
    padre(P, X), padre(P, Y),
    madre(M, X), madre(M, Y),
    X \== Y.

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
    findall(P-M, ( padre(P, H), madre(M, H) ), Lista),
    list_to_set(Lista, Parejas),
    forall(member(P-M, Parejas), escribir_pareja(P, M)),
    % hijos de los que solo se conoce un progenitor
    forall(( progenitor(X, H), \+ ( progenitor(Y, H), Y \== X ) ),
           format("  \"~w\" -> \"~w\";~n", [X, H])),
    format("  subgraph cluster_leyenda { label=\"Leyenda\"; fontname=\"Helvetica\"; fontsize=11; style=\"rounded,dashed\"; color=\"#999999\";~n"),
    format("    leyenda_hombre [label=\"Hombre\", fillcolor=\"#dbe9f9\", color=\"#2b6cb0\", fontsize=10];~n"),
    format("    leyenda_mujer [label=\"Mujer\", fillcolor=\"#fbe3ec\", color=\"#c2185b\", fontsize=10];~n"),
    format("    leyenda_hombre -> leyenda_mujer [style=invis];~n  }~n"),
    format("}~n").

escribir_persona(X, Relleno, Borde) :-
    sub_atom(X, 0, 1, _, Inicial),
    sub_atom(X, 1, _, 0, Resto),
    upcase_atom(Inicial, Mayuscula),
    format("  \"~w\" [label=\"~w~w\", fillcolor=\"~w\", color=\"~w\"];~n",
           [X, Mayuscula, Resto, Relleno, Borde]).

% Cada pareja baja a un punto de unión del que salen sus hijos
escribir_pareja(P, M) :-
    format("  { rank=same; \"~w\"; \"~w\"; }~n", [P, M]),
    format("  \"u_~w_~w\" [label=\"\", shape=point, width=0.08, color=\"#555555\"];~n", [P, M]),
    format("  \"~w\" -> \"u_~w_~w\" [weight=4];~n", [P, P, M]),
    format("  \"~w\" -> \"u_~w_~w\" [weight=4];~n", [M, P, M]),
    forall(( padre(P, H), madre(M, H) ),
           format("  \"u_~w_~w\" -> \"~w\";~n", [P, M, H])).
