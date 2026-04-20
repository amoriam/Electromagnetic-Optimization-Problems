function f = griewank(x)
%  Griewank function 
%
%   f = griewank2007(x)
%
%   Input:
%       x - row vector or column vector
%
%   Output:
%       f - function value

    x = x(:);              % make sure x is a column vector
    D = length(x);

    sum_part = 0;
    prod_part = 1;

    for k = 1:D
        sum_part = sum_part + x(k)^2;
        prod_part = prod_part * cos(x(k) / sqrt(k));
    end

    f = sum_part / 4000 - prod_part + 1;
end