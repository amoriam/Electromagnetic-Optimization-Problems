function f = shifted_rosenbrock(x, o, f_bias)

% Ensure x is a row vector
x = x(:)';  

D = length(x);

% Shift transformation
z = zeros(1, D);
for i = 1:D
    z(i) = x(i) - o(i) + 1;
end

% Compute Rosenbrock function
sum_val = 0;
for k = 1:(D-1)
    term1 = z(k+1) - z(k)^2;
    term2 = z(k) - 1;
    sum_val = sum_val + 100 * (term1^2) + (term2^2);
end

% Final value
f = sum_val + f_bias;

end