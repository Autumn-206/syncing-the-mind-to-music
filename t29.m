% Define time span and parameters
tspan = [0 10];
alpha = 2;
y0 = [0; alpha^2];

% Define the system
odeFunc = @(t, Y) [Y(2); -2*alpha*Y(2) - alpha^2*Y(1)];

% Reference solution with ode45
[t_ref, Y_ref] = ode45(odeFunc, tspan, y0);
y_ref_interp = @(tq) interp1(t_ref, Y_ref(:,1), tq);  % For comparison

% Solve with another solver (example: ode23)
[t, Y] = ode23tb(odeFunc, tspan, y0);

% Interpolate reference solution at ode23 time points
y_ref_at_t = y_ref_interp(t);

% Compute RMSE
rmse = sqrt(mean((Y(:,1) - y_ref_at_t).^2));

% Display RMSE
fprintf('RMSE between ode23tb and ode45: %.6f\n', rmse);

% Plot
figure;
plot(t_ref, Y_ref(:,1), 'k--', 'DisplayName', 'ode45 (Reference)');
hold on;
plot(t, Y(:,1), 'r', 'DisplayName', 'ode23tb');
legend;
xlabel('Time (t)');
ylabel('y(t)');
title('Comparison: ode23tb vs ode45');
grid on;
