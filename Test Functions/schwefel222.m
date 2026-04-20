function f = schwefel222(x)
% SCHWEFEL222 function 
%
%   f = schwefel222_2007(x)
%
%   Input:
%       x - row vector or column vector
%
%   Output:
%       f - function value

    x = x(:);              % convert to column vector
    D = length(x);

    sum_part = 0;
    prod_part = 1;

    for k = 1:D
        sum_part = sum_part + abs(x(k));
        prod_part = prod_part * abs(x(k));
    end

    f = sum_part + prod_part;
end