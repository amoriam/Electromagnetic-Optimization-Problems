
clc; 
clear; 
close all;



SQPSO_results   = [0.0362, 0.147, 0.249];    
IGSA_results  = [0.0482, 0.561, 1.1539];    
QPSO_results = [3.67, 5.20, 6.46];    
DQPSO_results = [3.38, 4.29, 5.10];          
MQPSO_results = [3.57, 5.12, 6.46]; 
ACOR_results = [0.22, 1.38, 2.44];
%% Combine all results into a matrix (columns = algorithms)
all_results = [SQPSO_results;
               IGSA_results;
               QPSO_results;
               DQPSO_results;
               MQPSO_results;
               ACOR_results]';

%% Labels for boxplot
labels = {'SQPSO', 'IGSA', 'QPSO', 'DQPSO', 'MQPSO','ACOR'};

%% ----------------------- Draw Boxplot -----------------------
figure;
boxplot(all_results, 'Labels', labels, 'Whisker', 1.5);

title('Performance Comparison of different Algorithms', 'FontSize', 14,b);
xlabel('Algorithms', 'FontSize', 14,b);
ylabel('Best Objective Function Value ', 'FontSize', 1,b);
grid on;

%% ----------------------- Optional: Colored Boxes ------------------------
colors = [0.2 0.2 0.9;   % Blue
          0.1 0.7 0.3;   % Green
          0.9 0.6 0.1;   % Orange
          0.85 0.2 0.2]; % Red

h = findobj(gca, 'Tag', 'Box');
for j = 1:length(h)
    patch(get(h(j), 'XData'), get(h(j), 'YData'), colors(end-j+1,:), ...
          'FaceAlpha', 0.35); 
end
