function f = shifted_rastrigin(x)

% Ensure row vector
x = x(:)';

D = length(x);

% --- Define shift and bias internally ---
o = zeros(1, D);   % shift vector (modify if needed)
f_bias = 0;

% --- Shift transformation ---
z = zeros(1, D);
for i = 1:D
    z(i) = x(i) - o(i);
end

% --- Rastrigin computation ---
sum_val = 0;
for i = 1:D
    sum_val = sum_val + (z(i)^2 - 10*cos(2*pi*z(i)) + 10);
end

% --- Final value ---
f = sum_val + f_bias;

end