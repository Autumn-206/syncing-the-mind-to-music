% Dissonant Intervals (e.g., Minor Second ~16:15)
A1 = 1;
A2 = 1;
f1 = 220;                  % Base frequency in Hz (e.g., A3)
f2 = f1 * 16/15;           % Minor second above A3 ~ 234.7 Hz
omega1 = 2 * pi * f1;
omega2 = 2 * pi * f2;

% Time Vector
t = 0:0.0001:0.05;

% Sinusoidal Inputs
I1 = A1 * cos(omega1 * t);
I2 = A2 * cos(omega2 * t);

% Plot
figure;
plot(t, I1, 'b', 'LineWidth', 1.2); hold on;
plot(t, I2, 'r', 'LineWidth', 1.2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Dissonant Interval: Minor Second (16:15)');
legend('I_1(t)', 'I_2(t)');
grid on;
