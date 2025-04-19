% Define the parameter alpha
alpha = 5;

% Time span for simulation
tspan = [0 2];  % 0 to 2 seconds

% Initial conditions:
% y(0) = 0
% y'(0) = alpha^2
y0 = [0; alpha^2];

% Define the system of first-order ODEs:
% Let y1 = y, y2 = y'
% Then dy1/dt = y2
%      dy2/dt = -2*alpha*y2 - alpha^2*y1

odefun = @(t, y) [y(2); -2*alpha*y(2) - alpha^2*y(1)];

% Solve the system using ode45
[t, Y] = ode45(odefun, tspan, y0);

% Plot the solution
figure;
plot(t, Y(:,1), 'b-', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('\alpha(t)');
title(['Solution of y'''' + 2\alpha y'' + \alpha^2 y = 0 with \alpha = ', num2str(alpha)]);
grid on;
