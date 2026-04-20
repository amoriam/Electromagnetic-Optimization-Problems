function [Best, curve] = MQPSO2(fobj, N, MaxIt, D, LB, UB)

X = LB + (UB-LB).*rand(N,D);
pbest = X;
pbest_val = zeros(N,1);

for i = 1:N
    pbest_val(i) = fobj(X(i,:));
end

[Best, idx] = min(pbest_val);
gbest = X(idx,:);

curve = zeros(MaxIt,1);

for t = 1:MaxIt
    mbest = mean(pbest);
    beta = 1.0 - 0.7*(t/MaxIt);  % adaptive contraction-expansion

    for i = 1:N
        u = rand(1,D);
        p = (pbest(i,:) + gbest) / 2;
        X(i,:) = p + beta * abs(mbest - X(i,:)) .* log(1 ./ u);

        X(i,:) = max(min(X(i,:),UB),LB);

        fit = fobj(X(i,:));
        if fit < pbest_val(i)
            pbest(i,:) = X(i,:);
            pbest_val(i) = fit;
        end
    end

    [Best, idx] = min(pbest_val);
    gbest = pbest(idx,:);
    curve(t) = Best;
end
end
