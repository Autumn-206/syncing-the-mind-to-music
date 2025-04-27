function sensitivity_alpha275()
    % Time span
    tspan = [0 1];
    y0 = [1; 0];
    alpha = 27.5; % Set alpha = 27.5 (correct)
    
    % Solve
    [t, y] = ode45(@(t,y) odefun(t,y,alpha), tspan, y0);
    
    % Plot
    figure;
    plot(t, y(:,1), 'm', 'LineWidth', 2); % magenta color for clarity
    xlabel('Time (s)');
    ylabel('Response y(t)');
    title('System Response with \alpha = 27.5');
    grid on;
end

function dydt = odefun(t,y,alpha)
    alphat = alpha^2 * t * exp(-alpha*t); % alpha(t) definition
    dydt = [y(2); -2*alphat*y(2) - (alphat^2)*y(1)];
end
