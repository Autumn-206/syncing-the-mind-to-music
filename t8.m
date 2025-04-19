% Solve the second-order ODE for alpha function using three solvers

% Parameters
alpha_val = 1;
A = alpha_val^2;
tspan = [0 10];
y0 = [0; A];  % y(0) = 0, dy/dt(0) = A

% Define the ODE system as dy = [y2; -2*alpha*y2 - alpha^2*y1]
odefun = @(t, y) [y(2); -2*alpha_val*y(2) - alpha_val^2*y(1)];

% Solve with ode45
[t1, y1] = ode45(odefun, tspan, y0);

% Solve with ode23
[t2, y2] = ode23(odefun, tspan, y0);

% Solve with ode113
[t3, y3] = ode113(odefun, tspan, y0);

% Analytical solution for reference
t_exact = linspace(0, 10, 1000);
y_exact = A * t_exact .* exp(-alpha_val * t_exact);

% Plotting
figure;

plot(t1, y1(:,1), 'b-', 'LineWidth', 2); hold on;
plot(t2, y2(:,1), 'g--', 'LineWidth', 2);
plot(t3, y3(:,1), 'r-.', 'LineWidth', 2);
plot(t_exact, y_exact, 'k:', 'LineWidth', 2);

legend('ode45', 'ode23', 'ode113', 'Analytical');
xlabel('Time t');
ylabel('\alpha(t)');
title('Solving \alpha(t) using ODE solvers');
grid on;
