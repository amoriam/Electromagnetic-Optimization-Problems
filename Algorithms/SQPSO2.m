function [Best_score, Best_pos, curve] = SQPSO2(N, MaxIt, lb, ub, dim, fobj)

% Initialization
X = rand(N,dim).*(ub-lb) + lb;
Pbest = X;

fitness = zeros(N,1);
for i=1:N
    fitness(i) = fobj(X(i,:));
end

Pbest_val = fitness;
[Best_score, idx] = min(Pbest_val);
Gbest = Pbest(idx,:);

curve = zeros(1,MaxIt);

% Parameters
beta_max = 1.3;
beta_min = 0.35;

Pm = Gbest+rand(0,1);   % mutation probability

for t = 1:MaxIt
    
    % ---- Updated Beta Strategy (nonlinear decay) ----
    beta = beta_max + beta_min/(0.5*(Gbest+1.5));
    
    % ---- Compute mbest ----
    mbest = zeros(1,dim);
    for j=1:dim
        mbest(j) = mean(Pbest(:,j));
    end
    
    for i = 1:N
        
        % ---- Tournament Selection (size = 2) ----
        idx1 = randi(N);
        idx2 = randi(N);
        
        if Pbest_val(idx1) < Pbest_val(idx2)
            P_tour = Pbest(idx1,:);
        else
            P_tour = Pbest(idx2,:);
        end
        
        % ---- Attractor ----
        phi = rand;
        p = phi * P_tour + (1 - phi) * Gbest;
        
        % ---- QPSO Position Update ----
        u = rand(1,dim);
        for d = 1:dim
            if rand < 0.5
                X(i,d) = p(d) + beta * abs(mbest(d)-X(i,d)) * log(1/u(d));
            else
                X(i,d) = p(d) - beta * abs(mbest(d)-X(i,d)) * log(1/u(d));
            end
        end
        
        % ---- Mutation Operation ----
        if rand < Pm
            mut_dim = randi(dim);
            X(i,mut_dim) = lb + rand*(ub-lb);
        end
        
        % ---- Boundary Control ----
        for d = 1:dim
            if X(i,d) > ub
                X(i,d) = ub;
            elseif X(i,d) < lb
                X(i,d) = lb;
            end
        end
        
        % ---- Evaluation ----
        fitness(i) = fobj(X(i,:));
        
        % ---- Update Pbest ----
        if fitness(i) < Pbest_val(i)
            Pbest(i,:) = X(i,:);
            Pbest_val(i) = fitness(i);
        end
        
        % ---- Update Gbest ----
        if Pbest_val(i) < Best_score
            Best_score = Pbest_val(i);
            Gbest = Pbest(i,:);
        end
    end
    
    curve(t) = Best_score;
end

Best_pos = Gbest;

end