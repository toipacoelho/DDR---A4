function Solution = Evaluate_E(CurrentSolution)
lambda = CurrentSolution.lambda;
pairs = CurrentSolution.pairs;
routes = CurrentSolution.routes;

Matrizes;
miu= R*1e9/(8*1000);
NumberLinks= sum(sum(R>0));
d= L*1e3/2e8;
gama= sum(sum(lambda));
npairs = size(pairs,1);

Load= lambda./miu;
Load(isnan(Load))= 0;
MaximumLoad = max(max(Load));
AverageLoad = sum(sum(Load))/NumberLinks;

AverageDelay= (lambda./(miu-lambda)+lambda.*d);
AverageDelay(isnan(AverageDelay))= 0;
AverageDelay = 2*sum(sum(AverageDelay))/gama;
Delay_s= zeros(npairs,1);
for i=1:npairs
    origin= pairs(i,1);
    destination= pairs(i,2);
    r= routes(i,:);
    j= 1;
    while r(j)~= destination
        Delay_s(i)= Delay_s(i)+ 1/(miu(r(j),r(j+1))-...
            lambda(r(j),r(j+1))) + d(r(j),r(j+1));
        Delay_s(i)= Delay_s(i)+ 1/(miu(r(j+1),r(j))-...
            lambda(r(j+1),r(j))) + d(r(j+1),r(j));
        j= j+1;
    end
end
MaxAvDelay = max(Delay_s);

Solution.MaxAvDelay = MaxAvDelay;
Solution.MaximumLoad = MaximumLoad;
Solution.AverageLoad = AverageLoad;
Solution.AverageDelay = AverageDelay;
end

