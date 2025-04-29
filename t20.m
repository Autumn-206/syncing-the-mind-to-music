% Define the time span
tspan = [0 10];

% Define the set of alpha values to explore
alpha_values = [0.5, 1, 2, 3];

% Create a figure
figure;
hold on;

% Loop through different alpha values
for i = 1:length(alpha_values)
    alpha = alpha_values(i);
    
    % Define initial conditions
    y0 = [0; alpha^2];  % [y(0), y'(0)]
    
    % Define the system as a first-order ODE system
    % Let y1 = y, y2 = dy/dt => dy1/dt = y2, dy2/dt = -2*alpha*y2 - alpha^2*y1
    odeFunc = @(t, Y) [Y(2); -2*alpha*Y(2) - alpha^2*Y(1)];
    
    % Solve using ode45
    [t, Y] = ode45(odeFunc, tspan, y0);
    
    % Plot the solution
    plot(t, Y(:,1), 'DisplayName', ['\alpha = ', num2str(alpha)]);
end

% Customize the plot
xlabel('Time (t)');
ylabel('y(t) - Synaptic Response');
title('Synaptic Response Using Alpha Function (ODE Solution)');
legend show;
grid on;
hold off;
