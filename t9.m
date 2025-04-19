% Parameters
A1 = 1;            % Amplitude of I1
A2 = 0.8;          % Amplitude of I2
omega1 = 2 * pi * 5;  % Frequency (rad/s) for I1, e.g., 5 Hz
omega2 = 2 * pi * 3;  % Frequency (rad/s) for I2, e.g., 3 Hz

% Time vector
t = 0:0.001:2;     % Time from 0 to 2 seconds in 1ms steps

% Sinusoidal Inputs
I1 = A1 * cos(omega1 * t);
I2 = A2 * cos(omega2 * t);

% Plotting
figure;
plot(t, I1, 'b', 'LineWidth', 1.5); hold on;
plot(t, I2, 'r', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Input Amplitude');
title('Sinusoidal Inputs I_1(t) and I_2(t)');
legend('I_1(t) = A_1 cos(\omega_1 t)', 'I_2(t) = A_2 cos(\omega_2 t)');
grid on;
