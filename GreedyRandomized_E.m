function solution = GreedyRandomized_E()
pairs = [];
Matrizes;
miu= R*1e9/(8*1000);
lambda_s= T*1e6/(8*1000);
d= L*1e3/2e8;
lambda= zeros(17);

for i = 1:16
    for j=(i+1):17
        pairs = [pairs; i j];
    end
end
npairs= size(pairs,1);
routes= zeros(npairs,17);

b = randperm(npairs);
for i = 1:npairs
    aux(i,:) = pairs(b(i),:);
end
pairs = aux;
solution.pairs = pairs;

for i=1:npairs
    origin= pairs(i,1);
    destination= pairs(i,2);
    aux=1./(miu-lambda) + d;
    r= ShortestPathSym(aux,origin,destination);
    routes(i,:)= r;
    j= 1;
    while r(j)~= destination
        lambda(r(j),r(j+1))= lambda(r(j),r(j+1)) + ...
            lambda_s(origin,destination);
        lambda(r(j+1),r(j))= lambda(r(j+1),r(j)) + ...
            lambda_s(destination,origin);
        j= j+1;
    end
end

solution.routes = routes;
solution.lambda = lambda;
end