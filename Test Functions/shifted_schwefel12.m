function f = shifted_schwefel12(x, o, f_bias)
%  Shifted Schwefel's Problem 
%
%   f = shifted_schwefel12(x, o, f_bias)
%
%   Input:
%       x      - decision vector (row or column)
%       o      - shift vector (row or column)
%       f_bias - bias constant
%
%   Output:
%       f      - function value
%
%   Formula:
%       z = x - o
%       f = sum_{i=1}^D ( sum_{j=1}^i z(j) )^2 + f_bias

    x = x(:);
    o = o(:);
    z = x - o;

    D = length(z);
    f = 0;

    for i = 1:D
        s = 0;
        for j = 1:i
            s = s + z(j);
        end
        f = f + s^2;
    end

    f = f + f_bias;
end