function f = shifted_sphere(x, o, f_bias)
% Shifted Sphere function 
%
%   f = shifted_sphere(x, o, f_bias)
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
%       f = sum(z.^2) + f_bias

    x = x(:);
    o = o(:);

    z = x - o;
    f = sum(z.^2) + f_bias;
end