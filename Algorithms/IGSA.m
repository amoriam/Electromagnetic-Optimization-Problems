function [Best_score, Best_pos, curve] = IGSA(N, MaxIt, lb, ub, dim, fobj)

% Initialization
X = rand(N, dim).*(ub-lb) + lb;
V = zeros(N, dim);
fitness = zeros(N,1);

Best_score = inf;
Best_pos = zeros(1,dim);
curve = zeros(1,MaxIt);

G0 = 100;        % Initial gravitational constant
alpha = 20;      % Decay coefficient

for t = 1:MaxIt
    
    % Evaluate fitness
    for i = 1:N
        fitness(i) = fobj(X(i,:));
        
        if fitness(i) < Best_score
            Best_score = fitness(i);
            Best_pos = X(i,:);
        end
    end
    
    % Normalize masses (Improved version)
    worst = max(fitness);
    best  = min(fitness);
    
    if best == worst
        M = ones(N,1);
    else
        M = (fitness - worst) ./ (best - worst);
    end
    
    M = M ./ sum(M);   % Normalize
    
    % Update gravitational constant (Improved exponential decay)
    G = G0 * exp(-alpha * t / MaxIt);
    
    % Compute acceleration
    A = zeros(N, dim);
    
    for i = 1:N
        for j = 1:N
            if i ~= j
                R = norm(X(i,:) - X(j,:)) + eps;
                
                % Improved force (randomization added)
                rand_coeff = rand;
                F = rand_coeff * G * (M(i)*M(j)) * (X(j,:) - X(i,:)) / R;
                
                A(i,:) = A(i,:) + F;
            end
        end
    end
    
    % Update velocity and position
    for i = 1:N
        V(i,:) = rand .* V(i,:) + A(i,:);
        X(i,:) = X(i,:) + V(i,:);
        
        % Boundary control
        for d = 1:dim
            if X(i,d) > ub
                X(i,d) = ub;
            elseif X(i,d) < lb
                X(i,d) = lb;
            end
        end
    end
    
    curve(t) = Best_score;
end
end