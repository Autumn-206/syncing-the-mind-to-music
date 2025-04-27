function sensitivity_alpha35()
    % Time span
    tspan = [0 1];
    y0 = [1; 0];
    alpha = 35; % Set alpha = 35
    
    % Solve
    [t, y] = ode45(@(t,y) odefun(t,y,alpha), tspan, y0);
    
    % Plot
    figure;
    plot(t, y(:,1), 'r', 'LineWidth', 2);
    xlabel('Time (s)');
    ylabel('Response y(t)');
    title('System Response with \alpha = 35');
    grid on;
end

function dydt = odefun(t,y,alpha)
    alphat = alpha^2 * t * exp(-alpha*t);
    dydt = [y(2); -2*alphat*y(2) - (alphat^2)*y(1)];
end
