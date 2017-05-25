% pairs
% npairs
% b=randperm(npairs);
% for i=1:npairs
%     aux(i,:)pairs(b(i),:);
% end
% pairs=aux;

Matrizes;

GlobalBest= Inf;

n = 3;

for iter=1:n
    CurrentSolution= GreedyRandomized();
    CurrentObjective= Evaluate(CurrentSolution);
    repeat= true;
    while repeat
        NeighbourBest= Inf;
        for i=1:size(CurrentSolution,1)
            NeighbourSolution= BuildNeighbour(CurrentSolution,i);
            NeighbourObjective= Evaluate(NeighbourSolution);
            if NeighbourObjective < NeighbourBest
                NeighbourBest= NeighbourObjective;
                NeighbourBestSolution= NeighbourSolution;
            end
        end
        if NeighbourBest < CurrentObjective
            CurrentObjective= NeighbourBest;
            CurrentSolution= NeighbourBestSolution;
        else
            repeat= false;
        end
    end
    if CurrentObjective < GlobalBest
        GlobalBestSolution= CurrentSolution; 
        GlobalBest= CurrentObjective;
    end
end