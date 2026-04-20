function [BestCost, curve] = ABC3(fobj, nPop, MaxIt, nVar, VarMin, VarMax)

FoodNumber = nPop/2;
limit = 50;

% Initialization
Foods = VarMin + rand(FoodNumber,nVar).*(VarMax-VarMin);
cost  = zeros(FoodNumber,1);
trial = zeros(FoodNumber,1);

for i = 1:FoodNumber
    cost(i) = fobj(Foods(i,:));
end

curve = zeros(MaxIt,1);

for it = 1:MaxIt
    
    % -------- Employed Bees --------
    for i = 1:FoodNumber
        
        k = ceil(rand*FoodNumber);
        while k == i
            k = ceil(rand*FoodNumber);
        end
        
        phi = rand(1,nVar)*2 - 1;
        v = Foods(i,:) + phi.*(Foods(i,:) - Foods(k,:));
        
        v = max(v,VarMin);
        v = min(v,VarMax);
        
        newCost = fobj(v);
        
        if newCost < cost(i)
            Foods(i,:) = v;
            cost(i) = newCost;
            trial(i) = 0;
        else
            trial(i) = trial(i) + 1;
        end
    end
    
    % -------- Scout Bees --------
    for i = 1:FoodNumber
        if trial(i) > limit
            Foods(i,:) = VarMin + rand(1,nVar).*(VarMax-VarMin);
            cost(i) = fobj(Foods(i,:));
            trial(i) = 0;
        end
    end
    
    curve(it) = min(cost);
end

BestCost = min(cost);

end
