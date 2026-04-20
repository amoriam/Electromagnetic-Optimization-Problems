function [BestSol, BestCost, curve] = PSO2(fobj, nPop, MaxIt, nVar, VarMin, VarMax)

% PSO Parameters
w  = 0.7;       % Inertia weight
wdamp = 0.99;   % Damping ratio
c1 = 1.5;       % Cognitive coefficient
c2 = 1.5;       % Social coefficient

% Velocity limits
VelMax = 0.2*(VarMax - VarMin);
VelMin = -VelMax;

% Particle structure
empty_particle.Position = [];
empty_particle.Velocity = [];
empty_particle.Cost = [];
empty_particle.Best.Position = [];
empty_particle.Best.Cost = [];

particle = repmat(empty_particle, nPop, 1);

% Global Best
GlobalBest.Cost = inf;

% Initialization
for i = 1:nPop
    
    particle(i).Position = unifrnd(VarMin, VarMax, [1 nVar]);
    particle(i).Velocity = zeros(1, nVar);
    
    particle(i).Cost = fobj(particle(i).Position);
    
    particle(i).Best.Position = particle(i).Position;
    particle(i).Best.Cost = particle(i).Cost;
    
    if particle(i).Best.Cost < GlobalBest.Cost
        GlobalBest = particle(i).Best;
    end
end

curve = zeros(MaxIt,1);

% PSO Main Loop
for it = 1:MaxIt
    for i = 1:nPop
        
        % Update Velocity
        particle(i).Velocity = ...
            w*particle(i).Velocity ...
            + c1*rand(1,nVar).*(particle(i).Best.Position - particle(i).Position) ...
            + c2*rand(1,nVar).*(GlobalBest.Position - particle(i).Position);
        
        % Apply Velocity Limits
        particle(i).Velocity = max(particle(i).Velocity, VelMin);
        particle(i).Velocity = min(particle(i).Velocity, VelMax);
        
        % Update Position
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        
        % Apply Position Limits
        particle(i).Position = max(particle(i).Position, VarMin);
        particle(i).Position = min(particle(i).Position, VarMax);
        
        % Evaluation
        particle(i).Cost = fobj(particle(i).Position);
        
        % Update Personal Best
        if particle(i).Cost < particle(i).Best.Cost
            particle(i).Best.Position = particle(i).Position;
            particle(i).Best.Cost = particle(i).Cost;
            
            % Update Global Best
            if particle(i).Best.Cost < GlobalBest.Cost
                GlobalBest = particle(i).Best;
            end
        end
    end
    
    curve(it) = GlobalBest.Cost;
    w = w * wdamp;
    
    disp(['Iteration ' num2str(it) ...
          ': Best Cost = ' num2str(GlobalBest.Cost)]);
end

BestSol = GlobalBest.Position;
BestCost = GlobalBest.Cost;

end
