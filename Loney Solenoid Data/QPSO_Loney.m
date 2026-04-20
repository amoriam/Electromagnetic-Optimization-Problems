function [Best_score, Best_pos, curve] = QPSO_Loney(N, MaxIt, lb, ub, dim, fobj)

% Initialization
X = rand(N,dim);
for i=1:N
    for d=1:dim
        X(i,d) = lb(d) + X(i,d)*(ub(d)-lb(d));
    end
end

Pbest = X;
fitness = zeros(N,1);

for i=1:N
    fitness(i) = fobj(X(i,:));
end

Pbest_val = fitness;
[Best_score, idx] = min(Pbest_val);
Gbest = Pbest(idx,:);

curve = zeros(1,MaxIt);

% QPSO Parameters
beta_max = 1.0;
beta_min = 0.5;

for t = 1:MaxIt
    
    % Adaptive beta
    beta = beta_max - (beta_max - beta_min)*(t/MaxIt);
    
    % Compute mbest
    mbest = zeros(1,dim);
    for j=1:dim
        mbest(j) = mean(Pbest(:,j));
    end
    
    for i = 1:N
        
        % Attractor
        phi = rand;
        p = phi * Pbest(i,:) + (1 - phi) * Gbest;
        
        % QPSO position update
        u = rand(1,dim);
        for d = 1:dim
            if rand < 0.5
                X(i,d) = p(d) + beta * abs(mbest(d)-X(i,d)) * log(1/u(d));
            else
                X(i,d) = p(d) - beta * abs(mbest(d)-X(i,d)) * log(1/u(d));
            end
        end
        
        % Boundary handling
        for d=1:dim
            if X(i,d) > ub(d)
                X(i,d) = ub(d);
            elseif X(i,d) < lb(d)
                X(i,d) = lb(d);
            end
        end
        
        % Evaluation
        fitness(i) = fobj(X(i,:));
        
        % Update Pbest
        if fitness(i) < Pbest_val(i)
            Pbest(i,:) = X(i,:);
            Pbest_val(i) = fitness(i);
        end
        
        % Update Gbest
        if Pbest_val(i) < Best_score
            Best_score = Pbest_val(i);
            Gbest = Pbest(i,:);
        end
    end
    
    curve(t) = Best_score;
end

Best_pos = Gbest;

end