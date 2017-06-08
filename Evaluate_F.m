function Solution = Evaluate_F(CurrentSolution)
lambda = CurrentSolution.lambda;

Matrizes;
miu= R*1e9/(8*1000);

Load= lambda./miu;
Load(isnan(Load))= 0;
MaximumLoad = max(max(Load));

Solution = MaximumLoad;
end

