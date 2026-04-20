clc;
clear;
close all;

%% Problem Definition
nVar   = 30;          % Dimension
VarMin = -10;         % Lower bound
VarMax = 10;          % Upper bound
fobj   = @rosenbrock;     % Objective function

%% PSO Parameters
nPop  = 50;           % Population size
MaxIt = 1000;          % Max iterations

%% Statistical Runs
Nrun = 1000;            % Number of independent runs

BestCost_Run = zeros(Nrun,1);   % Store best cost of each run
Curve_All    = zeros(MaxIt,Nrun);

%% Run PSO Multiple Times
for r = 1:Nrun
    
    disp(['Run ' num2str(r) ' / ' num2str(Nrun)]);
    
   [BestCost, curve] = ABC3(fobj, nPop, MaxIt, nVar, VarMin, VarMax);

    
    BestCost_Run(r) = BestCost;
    Curve_All(:,r)  = curve;
end

%% Statistical Results
Best_Min  = min(BestCost_Run);
Best_Mean = mean(BestCost_Run);
Best_Max  = max(BestCost_Run);
Best_Std  = std(BestCost_Run);

disp('====================================');
disp('Statistical Results ');
disp(['Min  = ' num2str(Best_Min)]);
disp(['Mean = ' num2str(Best_Mean)]);
disp(['Max  = ' num2str(Best_Max)]);
disp(['Std  = ' num2str(Best_Std)]);
disp('====================================');

%% Plot Convergence Curve of Best Run
[BestValue, bestRunIndex] = min(BestCost_Run);

figure;
semilogy(Curve_All(:,bestRunIndex),'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');
title('PSO Best Convergence Curve (Sphere)');
grid on;
