function x = Simplex(A, b, c)
% El método simplex resuelve problemas de programación
% lineal en su primera forma primal:
%
% maximizar c' * x,
% sujeto a Ax <= b, x >= 0,
% con b >= 0.
%
% *INPUT*
% A:    Matriz de m*n
% b:    Vector columna de m*1
% c:    Vector columna de n*1
%
% *OUTPUT*
% x:    Vector columna de n*1

% Valor pequeño para epsilon
epsilon = 10e-6;

% Determinar forma del sistema
[m,k] = size(A);
n = m + k;

% Pasar problema a segunda forma primal
% maximizar c' * x,
% sujeto a Ax <= b, x >= 0
% 
c = [c; repelem(0, m, 1)];
A = [A, eye(m)];

% Índices de la base considerada. La primera 
% base está formada por las últimas m columnas 
% de la matriz A en su segunda forma primal
index = (k+1):n;

% Loop infinito
while (1)
    % Creamos matriz B con la base
    B = A(:,index);
    
    % Resolvemos Bx = b
    x = B \ b;
    
    % Si no todas las entradas de x > 0
    % entonces el algoritmo falló
    if (~all(x > 0))
        fprintf("El algoritmo falló");
        x = repelem(inf, k)';
        break
    end
    
    % Creamos vector con los coeficientes de la 
    % función objetivo correspondientes a la base 
    e = c(index);
    
    % Resolvemos B'y = e
    y = B' \ e;
    
    % Hallamos índice s que no esté en la base
    % que minimiza c(s)' - y' * A(:,s)
    s = setdiff(1:n, index);
    v1 = c' - y' * A;
    maxVal = max(v1(s));
    s = find(v1 == maxVal);
    
    % Si el valor máximo de c(s) - y' * A(,:)
    % es menor que epsilon, hemos hallado la solución
    if (maxVal < epsilon)
        fprintf("Solución hallada");
        v = repelem(0, n)';
        v(index) = x;
        x = v(1:k);
        break
    end
    
    % Resolvemos Bz = A(:,s)
    z = B \ A(:,s);
    
    % Si todo z <= epsilon, salimos porque la función 
    % objetivo no está acotada en la región factible
    if (all(z <= epsilon))
        fprintf("La función objetivo no está acotada en la región factible.");
        x = repelem(inf, k)';
        break
    end
    
    % Hallamos índice r que minimiza x/z, donde z > 0
    positiveZ = z > 0;
    v2 = x ./ z;
    minZ = min(v2(positiveZ));
    r = find(v2 == minZ);
    
    % Reemplazamos elemento r de la base por s
    index(r) = s;
    
end

end