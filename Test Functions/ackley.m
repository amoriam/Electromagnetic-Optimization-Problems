function f = ackley(x)
% Ackley function 
%
%   f = ackley(x)
%
%   Input:
%       x - row vector or column vector
%
%   Output:
%       f - function value
%
%   Standard parameters:
%       a = 20
%       b = 0.2
%       c = 2*pi

    x = x(:);          % convert to column vector
    D = length(x);

    a = 20;
    b = 0.2;
    c = 2*pi;

    sum1 = 0;
    sum2 = 0;

    for k = 1:D
        sum1 = sum1 + x(k)^2;
        sum2 = sum2 + cos(c * x(k));
    end

    f = -a * exp(-b * sqrt(sum1 / D)) ...
        - exp(sum2 / D) ...
        + a + exp(1);
end