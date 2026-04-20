function f = rosenbrock(x)

%
%   f = rosenbrock2007(x)
%
%   Input:
%       x - row vector or column vector
%
%   Output:
%       f - function value

    x = x(:);          % make sure x is a column vector
    D = length(x);
    f = 0;

    for i = 1:D-1
        f = f + 100*(x(i+1) - x(i)^2)^2 + (x(i) - 1)^2;
    end
end