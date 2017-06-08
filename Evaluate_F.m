function Solution = Evaluate_E(CurrentSolution)
lambda = CurrentSolution.lambda;
Matrizes;
miu= R*1e9/(8*1000);
d= L*1e3/2e8;
lambda_s= T*1e6/(8*1000);
gama= sum(sum(lambda_s));


AverageDelay= (lambda./(miu-lambda)+lambda.*d);
AverageDelay(isnan(AverageDelay))= 0;
AverageDelay = 2*sum(sum(AverageDelay))/gama;


Solution = AverageDelay;
end

