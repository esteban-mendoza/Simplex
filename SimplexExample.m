% Todos estos ejemplos funcionan
c = [2, 3]'

A = [5, 3;
    3, 6]

b = [15, 18]'


c = [2, 4, 3]'

A = [4, 2, 3;
    3, 2, 1;
    1, 1, 2]

b = [15, 7, 6]'


c = [2, 3, 4]'

A = [3, 2, 1;
    2, 5, 3]

b = [10, 15]'


c = [3, 4, 5]'

A = [2, 1, 0;
    0, 2, 1;
    1, 0, 2]

b = [10, 20, 30]'


% En este ejemplo el algoritmo falla porque no se cumple que b >= 0
c = [-2, 2, -3, -1]'

A = [-1, 1, 1, 4;
    1, -1, 1, -1;
    -1, 1, -1, 1]

b = [-2, 15, -15]'

% Ejemplo:
Simplex(A, b, c)