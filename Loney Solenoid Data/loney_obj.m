function f = loney_obj(x)

% Variables
r = x(1);  
l = x(2);  
N = round(x(3)); % integer turns

% Constants
mu0 = 4*pi*1e-7;
I = 2; % current (Ampere)

% Magnetic field
B = mu0 * (N * I) / l;

% ---- Constraints ----
penalty = 0;

% Wire length constraint
wire_len = 2*pi*r*N;
if wire_len > 100
    penalty = penalty + 1e3*(wire_len - 100);
end

% Geometry constraint
if l < 2*r
    penalty = penalty + 1e3*(2*r - l);
end

% Objective (minimize)
f = -B + penalty;

end