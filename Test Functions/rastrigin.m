function f = rastrigin(x)
% Rastrigin function 
%
%   f = rastrigin(x)
%
%   Input:
%       x - row vector or column vector
%
%   Output:
%       f - function value

    x = x(:);      % convert to column vector
    D = length(x);
    f = 0;

    for k = 1:D
        f = f + (x(k)^2 - 10*cos(2*pi*x(k)) + 10);
    end
end