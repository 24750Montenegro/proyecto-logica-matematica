% =====================================================================
%  Ejercicio 2 - Caminos en un grafo dirigido
% ---------------------------------------------------------------------
%  G = ({a,b,c,d}, {(a,b), (a,c), (a,d), (c,d)})
% =====================================================================

% arco(X, Y): hay una arista dirigida de X a Y
arco(a, b).
arco(a, c).
arco(a, d).
arco(c, d).

% camino(X, Y, C): C es la lista de vértices de un camino que va de X a Y
camino(X, X, [X]).
camino(X, Y, [X|Z]) :- arco(X, W), camino(W, Y, Z).

% Consulta pedida:
% ?- camino(X, d, Y).
%    X = d, Y = [d] ;
%    X = a, Y = [a, c, d] ;
%    X = a, Y = [a, d] ;
%    X = c, Y = [c, d].
