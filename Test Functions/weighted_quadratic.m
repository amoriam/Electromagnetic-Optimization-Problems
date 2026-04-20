function f = weighted_quadratic(x)
% WEIGHTED_QUADRATIC
% Computes:
% f(x) = 10^6 * x(1)^2 + sum_{i=2}^D x(i)^2
%
% Input:
%   x - row vector or column vector
%
% Output:
%   f - function value

    x = x(:);   % convert to column vector
    D = length(x);

    f = 10^6 * x(1)^2;

    for i = 2:D
        f = f + x(i)^2;
    end
end