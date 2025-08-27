clear all
clc
close all
% Parameters
c = 1.0;          % Wave speed
a = 0.0;          % Spatial domain start
b = 1.0;          % Spatial domain end
T = 1.0;          % Temporal domain end
dx = 0.01;        % Spatial step size
dt = 0.001;       % Time step size
parametric_bc = @(t) sin(pi *t) + sin(2*pi*t) + sin(3*pi*t) + sin(5*pi*t) + sin(7*pi*t) + sin(11*pi*t) + sin(13*pi*t);  % Parametric boundary condition
parametric_bc2 = @(x,t) cos(x*t);
% Discretization
x = a:dx:b;
t = 0:dt:T;
Nx = length(x);
Nt = length(t);

% Initialize u and boundary condition vectors
y = zeros(Nx, Nt);
y(:, 1) = sin(pi * x) + sin(2*pi*x) + sin(3*pi*x) + sin(5*pi*x) + sin(7*pi*x) + sin(11*pi*x) + sin(13*pi*x);

% Time-stepping loop
for n = 1:Nt-1
    % Apply parametric boundary condition
    y(1, n+1) = parametric_bc(t(n+1));
    % u(Nt, n+1) = parametric_bc2(t(n+1));
    % Update interior points using centered difference scheme
    for i = 2:Nx-1
        y(i, n+2) = 2*y(i, n+1) - y(i, n) + (c*dt/dx)^2 * (y(i+1, n+1) - 2*y(i, n+1) + y(i-1, n+1));
    end
end


