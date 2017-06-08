function NeighbourSolution = BuildNeighbour_F(solution, i)
Matrizes;
lambda=solution.lambda;
lambda_s = T * 1e6 / (8*1000);
miu = R * 1e9 / (8*1000);
d = L * 1e3 / 2e8;

% get current origin and destination
origin = solution.pairs(i,1);
destination = solution.pairs(i,2);

% reset lambda
r = solution.routes(i,:);
j = 1;
while r(j) ~= destination
    solution.lambda(r(j),r(j+1)) = solution.lambda(r(j),r(j+1)) - lambda_s(origin,destination);
    solution.lambda(r(j+1),r(j))= solution.lambda(r(j+1),r(j)) - lambda_s(destination,origin);
    j= j+1;
end

% route choice - by delay
Load= lambda./miu;
r = ShortestPathSym(Load.^2,origin,destination);

% recalculate solution lambda
solution.routes(i,:) = r;
j = 1;
while r(j) ~= destination
    solution.lambda(r(j),r(j+1)) = solution.lambda(r(j),r(j+1)) + lambda_s(origin,destination);
    solution.lambda(r(j+1),r(j))= solution.lambda(r(j+1),r(j)) + lambda_s(destination,origin);
    j= j+1;
end

NeighbourSolution.pairs = solution.pairs;
NeighbourSolution.routes = solution.routes;
NeighbourSolution.lambda = solution.lambda;
end