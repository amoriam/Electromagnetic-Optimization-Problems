function f = elliptic_function(x)

% Ensure row vector
x = x(:)';

D = length(x);

% --- Compute function ---
sum_val = 0;

for i = 2:D
    sum_val = sum_val + x(i)^2;
end

f = x(1)^2 + 1e6 * sum_val;

end