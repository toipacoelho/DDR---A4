function solution = BuildNeighbour_E(CurrentSolution, i)
lambda = CurrentSolution.lambda;
pairs = CurrentSolution.pairs;
routes = CurrentSolution.routes;

Matrizes;
miu = 10^9 / 8000;
d = L / (3 * 10^5);
fim = size(routes, 1);

for j = 1 : fim
    if (j ~= i)        
        z = 1;
        aux = routes(j, 3:19);
        while z < 17
            if(aux(z+1) == 0) 
                break; 
            end;
            lambda(aux(z), aux(z+1)) = lambda(aux(z), aux(z+1)) + T(routes(j, 1), routes(j, 2));
            lambda(aux(z+1), aux(z)) = lambda(aux(z+1), aux(z)) + T(routes(j, 2), routes(j, 1));
            z = z + 1;
        end
    end
end

costs = 1./(miu-lambda) + d;
a = ShortestPathSym(costs, routes(i, 1), routes(i, 2));
solution(i,:) = [routes(i,1) routes(i, 2) a];


end

