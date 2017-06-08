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
