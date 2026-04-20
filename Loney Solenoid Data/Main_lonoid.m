clc;
clear;

% Problem Definition
dim = 3;  % [r, l, N]

lb = [0.01, 0.05, 50];
ub = [0.1,  0.5,  1000];

fobj = @loney_obj;

% QPSO Parameters
N = 30;
MaxIt = 200;

% Run QPSO
[Best_score, Best_pos, curve] = QPSO_Loney(N, MaxIt, lb, ub, dim, fobj);

% Display results
disp('Best Solution:')
disp(['Radius (m): ', num2str(Best_pos(1))])
disp(['Length (m): ', num2str(Best_pos(2))])
disp(['Turns: ', num2str(round(Best_pos(3)))])
disp(['Max Magnetic Field: ', num2str(-Best_score)])

% Plot convergence
figure;
plot(curve,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Fitness');
title('QPSO - Loney Solenoid Optimization');
grid on;