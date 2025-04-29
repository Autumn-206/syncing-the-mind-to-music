% Parameters
tspan = [0 10];
alpha_values = [0.5, 1, 2, 3];
numPoints = 200;
times = linspace(tspan(1), tspan(2), numPoints);

% Preallocate frames
framesPerCurve = numPoints;
totalFrames = framesPerCurve * length(alpha_values);
F(totalFrames) = struct('cdata', [], 'colormap', []);
frameIdx = 1;

% Prepare figure
figure;
hold on;
xlabel('Time (t)');
ylabel('y(t) - Synaptic Response');
title('Sequential Synaptic Response Animation (Cumulative)');
grid on;
xlim(tspan);
ylim([-0.2, 1.2]);
colors = lines(length(alpha_values));
legendEntries = cell(1, length(alpha_values));

% Solve ODEs in advance
solutions = cell(length(alpha_values), 1);
for i = 1:length(alpha_values)
    alpha = alpha_values(i);
    y0 = [0; alpha^2];
    odeFunc = @(t, Y) [Y(2); -2*alpha*Y(2) - alpha^2*Y(1)];
    [~, Y] = ode45(odeFunc, times, y0);
    solutions{i} = Y(:,1);
end

% Initialize static plot handles
hPlots = gobjects(length(alpha_values), 1);

% Animation: one curve at a time, others stay full
for i = 1:length(alpha_values)
    % Plot previous curves fully (static)
    for j = 1:i-1
        if ~isgraphics(hPlots(j))
            hPlots(j) = plot(times, solutions{j}, 'Color', colors(j,:), ...
                             'LineWidth', 2, 'DisplayName', ['\alpha = ' num2str(alpha_values(j))]);
        end
    end
    
    % Animate current curve
    hCurrent = plot(NaN, NaN, 'Color', colors(i,:), ...
                    'LineWidth', 2, 'DisplayName', ['\alpha = ' num2str(alpha_values(i))]);

    for k = 1:framesPerCurve
        set(hCurrent, 'XData', times(1:k), 'YData', solutions{i}(1:k));
        drawnow;
        F(frameIdx) = getframe(gcf);
        frameIdx = frameIdx + 1;
    end
    
    % Finalize current curve as static
    hPlots(i) = hCurrent;
end

% Show legend once all are plotted
legend show;

% Play movie
figure;
movie(F, 1, 30);  % Play once at 30 FPS
% Create a video writer object
v = VideoWriter('Synaptic_Response_Animation', 'MPEG-4');  % .mp4 format
v.FrameRate = 30;  % Playback speed (30 fps recommended)
open(v);

% Write each frame to the video
for i = 1:length(F)
    writeVideo(v, F(i));
end

% Close the video file
close(v);

disp('Video saved as Synaptic_Response_Animation.mp4');