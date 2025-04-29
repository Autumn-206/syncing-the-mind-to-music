% Dissonant Music - Coupled Neurons using ode45

% Parameters
tau1 = 2; tau2 = 2.5; 
A1 = 1; A2 = 1; 
epsilon = 0.1;
w1 = 2*pi*440;  % Frequency of A4 (440 Hz)
w2 = 2*pi*612;  % Dissonant frequency (not a simple ratio with 440 Hz)

% Time span
tspan = [0 0.01];  % Short time interval due to high frequency

% Initial conditions
init = [0 0];  % x1(0) = 0, x2(0) = 0

% Define system of ODEs
odefun = @(t, x) [
    -x(1)/tau1 + A1*cos(w1*t) + epsilon*(x(2) - x(1));
    -x(2)/tau2 + A2*cos(w2*t) + epsilon*(x(1) - x(2))
];

% Solve numerically using ode45
[t, x] = ode45(odefun, tspan, init);

% Plot results
plot(t, x(:,1), 'LineWidth', 2)
hold on
plot(t, x(:,2), '--', 'LineWidth', 2)
xlabel('Time (s)')
ylabel('Neuron Activation')
title('Dissonant Neuron Response (440Hz vs 612Hz)')
legend('Neuron 1', 'Neuron 2')
grid on
hold off
