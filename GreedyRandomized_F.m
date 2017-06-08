function solution = GreedyRandomized_F()
% Randomizes pair order

Matrizes;
miu = R*1e9/(8*1000);
NumberLinks = sum(sum(R>0));
lambda_s = T*1e6/(8*1000);
gama = sum(sum(lambda_s));
d = L*1e3/2e8;

pairs = [];
for origin = 1:16
    for destination = (origin + 1):17
        if T(origin, destination) + T(destination, origin)>0
            pairs = [pairs; origin destination];
        end
    end
end

% npairs = column length
npairs = size(pairs,1);
% random permutation of the nodes from 1 to npairs.
b = randperm(npairs);
for i = 1:npairs
    % reorder by the random permutation
    aux(i,:) = pairs(b(i),:);
end
pairs = aux;

lambda = zeros(17);
routes = zeros(npairs,17);

% same as solution C
for i = 1:npairs
    origin = pairs(i,1);
    destination = pairs(i,2);
    Load= lambda./miu;
    r = ShortestPathSym(Load.^2,origin,destination);
    
    routes(i,:)= r;
    j= 1;
    
    while r(j) ~= destination
        lambda(r(j),r(j+1)) = lambda(r(j),r(j+1)) + lambda_s(origin,destination);
        lambda(r(j+1),r(j)) = lambda(r(j+1),r(j)) + lambda_s(destination,origin);
        j= j+1;
    end
end

solution.pairs = pairs;
solution.routes = routes;
solution.lambda = lambda;
end