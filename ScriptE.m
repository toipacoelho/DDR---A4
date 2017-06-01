Matrizes;
GlobalBest= Inf;

n = 3;

for iter=1:n
    CurrentSolution= GreedyRandomized_E();
    CurrentObjective= Evaluate_E(CurrentSolution);
    repeat= true;
    while repeat
        NeighbourBest= Inf;
        for i=1:size(CurrentSolution,1)
            NeighbourSolution= BuildNeighbour_E(CurrentSolution,i);
            NeighbourObjective= Evaluate_E(NeighbourSolution);
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