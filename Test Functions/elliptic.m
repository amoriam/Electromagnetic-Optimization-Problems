function f = elliptic(x)
%   High Conditioned Elliptic function 
%
%   f = elliptic(x)
%
%   Input:
%       x - row vector or column vector
%
%   Output:
%       f - function value

    x = x(:);              % convert to column vector
    D = length(x);
    f = 0;

    if D == 1
        f = x(1)^2;
        return;
    end

    for i = 1:D
        f = f + (10^6)^((i-1)/(D-1)) * x(i)^2;
    end
end