% Parameters
A1 = 1;
A2 = 1;
f1 = 220;                       % Base frequency
f2 = f1 * 3/2;                  % Perfect fifth interval
omega1 = 2 * pi * f1;
omega2 = 2 * pi * f2;

% Time setup
tspan = [0 0.05];               % Time window
t = linspace(tspan(1), tspan(2), 1000); % For analytical comparison

% Analytical Solutions
I1_analytic = A1 * cos(omega1 * t);
I2_analytic = A2 * cos(omega2 * t);

% ODEs for I1 and I2
ode1 = @(t, Y) [Y(2); -omega1^2 * Y(1)];
ode2 = @(t, Y) [Y(2); -omega2^2 * Y(1)];

% Initial Conditions
Y0_1 = [A1; 0];
Y0_2 = [A2; 0];

% ---- Solve with ODE45 ----
[t1_45, Y1_45] = ode45(ode1, tspan, Y0_1);
[t2_45, Y2_45] = ode45(ode2, tspan, Y0_2);

% ---- Solve with ODE23 ----
[t1_23, Y1_23] = ode23(ode1, tspan, Y0_1);
[t2_23, Y2_23] = ode23(ode2, tspan, Y0_2);

% ---- Solve with ODE15s (stiff solver) ----
[t1_15, Y1_15] = ode15s(ode1, tspan, Y0_1);
[t2_15, Y2_15] = ode15s(ode2, tspan, Y0_2);

% ---- Plotting I1(t) comparisons ----
figure;
subplot(2,1,1);
plot(t, I1_analytic, 'k--', 'LineWidth', 1.2); hold on;
plot(t1_45, Y1_45(:,1), 'r', 'LineWidth', 1);
plot(t1_23, Y1_23(:,1), 'g', 'LineWidth', 1);
plot(t1_15, Y1_15(:,1), 'b', 'LineWidth', 1);
title('Comparison for I_1(t) [220 Hz]');
xlabel('Time (s)'); ylabel('Amplitude');
legend('Analytical', 'ode45', 'ode23', 'ode15s');
grid on;

% ---- Plotting I2(t) comparisons ----
subplot(2,1,2);
plot(t, I2_analytic, 'k--', 'LineWidth', 1.2); hold on;
plot(t2_45, Y2_45(:,1), 'r', 'LineWidth', 1);
plot(t2_23, Y2_23(:,1), 'g', 'LineWidth', 1);
plot(t2_15, Y2_15(:,1), 'b', 'LineWidth', 1);
title('Comparison for I_2(t) [330 Hz - Perfect Fifth]');
xlabel('Time (s)'); ylabel('Amplitude');
legend('Analytical', 'ode45', 'ode23', 'ode15s');
grid on;
