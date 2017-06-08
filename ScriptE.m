% Lowest Delay
clear all; clc; format long;

n = [3, 10, 30, 300, 3000];


fprintf('\nLowest Delay\n');
fprintf('    n\tGlobalBest\n');

for k = 1:length(n)
    %Global search
    GlobalBest = Inf;
    for j = 1:n(k)
        CurrentSolution = GreedyRandomized_E();
        CurrentObjective = Evaluate_E(CurrentSolution);
        repeat = true;

        %Local search
        while repeat
            NeighbourBest = Inf;

            %Calculating best neightboor
            for i=1:size(CurrentSolution,1)
                NeighbourSolution = BuildNeighbour_E(CurrentSolution,i);
                NeighbourObjective = Evaluate_E(NeighbourSolution);
                if NeighbourObjective < NeighbourBest
                    NeighbourBest = NeighbourObjective;
                    NeighbourBestSolution = NeighbourSolution;
                end
            end

            %Is current better than best set it as new best
            if NeighbourBest < CurrentObjective
                CurrentObjective = NeighbourBest;
                CurrentSolution = NeighbourBestSolution;
            %If cant find a better solution dont repeat
            else
                repeat = false;
            end
        end

        %If current better than best set it as the new best
        if CurrentObjective < GlobalBest
            GlobalBestSolution = CurrentSolution;
            GlobalBest = CurrentObjective;
        end
    end
    
    fprintf('%5d\t%0.6f\n', n(k), GlobalBest);
end

pairs = GlobalBestSolution.pairs;
routes = GlobalBestSolution.routes;
lambda = GlobalBestSolution.lambda;

Matrizes;
miu= R*1e9/(8*1000);
NumberLinks= sum(sum(R>0));
lambda_s= T*1e6/(8*1000);
gama= sum(sum(lambda_s));
d= L*1e3/2e8;

npairs= size(pairs,1);

Load= lambda./miu;
Load(isnan(Load))= 0;
MaximumLoad= max(max(Load))
AverageLoad= sum(sum(Load))/NumberLinks

AverageDelay= (lambda./(miu-lambda)+lambda.*d);
AverageDelay(isnan(AverageDelay))= 0;
AverageDelay= 2*sum(sum(AverageDelay))/gama
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
MaxAvDelay= max(Delay_s)

subplot(1,2,1)
printDelay_s= sortrows(Delay_s,-1);
plot(printDelay_s)
axis([1 npairs 0 1.1*MaxAvDelay])
title('Flow Delays')
subplot(1,2,2)
printLoad= sortrows(Load(:),-1);
printLoad= printLoad(1:NumberLinks);
plot(printLoad)
axis([1 NumberLinks 0 1])
title('Link Loads')
