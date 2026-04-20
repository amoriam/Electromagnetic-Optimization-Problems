clc
clear
close all

% Problem parameters
D = 30;
LB = -100;
UB = 100;
N = 50;
MaxIt = 1000;

% Run algorithms (NO ~ SYMBOL)
[Best_IGSA,   curve_IGSA]   = PSO(@sphere2, N, MaxIt, D, LB, UB);
[Best_QPSO,  curve_QPSO]  = QPSO2(@sphere2, N, MaxIt, D, LB, UB);
[Best_MQPSO, curve_MQPSO] = MQPSO2(@sphere2, N, MaxIt, D, LB, UB);
[Best_ABC3,   curve_ABC3]   = ABC3(@sphere2, N, MaxIt, D, LB, UB);
[Best_MQPSO2,    curve_MQPSO2]    = GA(@sphere2, N, MaxIt, D, LB, UB);
[Best_SQPSO2,    curve_SQPSO2]    = DE(@sphere2, N, MaxIt, D, LB, UB);

% Convergence plot
figure
semilogy(curve_IGSA,'c','LineWidth',2)
hold on
semilogy(curve_QPSO,'b','LineWidth',2)
semilogy(curve_MQPSO,'k','LineWidth',2)
semilogy(curve_ABC3,'g','LineWidth',2)
semilogy(curve_MQPSO2,'m','LineWidth',2)
semilogy(curve_SQPSO2,'r','LineWidth',2)

legend('IGSA','QPSO','MQPSO','ABC-FS','QPSO-N','SQPSO')
xlabel('Number of Iteration')
ylabel('Best Objective function values')
title('Convergence Comparison ')
grid off
