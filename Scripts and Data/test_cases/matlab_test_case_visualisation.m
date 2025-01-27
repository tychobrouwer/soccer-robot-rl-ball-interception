% Define parameters
initial_distances = [100, 200, 300, 400, 500, 600];
initial_ball_directions = [-pi/8, -pi/4, -3*pi/8];
ball_velocities = [0, 100, 200];
ball_movement_directions = [pi/2, 3*pi/4, 8*pi/9];

% Initialize figure
figure;
hold on;
axis equal;
xlabel('X Position [cm]');
ylabel('Y Position [cm]');
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, 'fontsize', 20);
set(gca,'fontname','Linux Libertine');

plot(0, 0, '^', 'MarkerSize', 20, 'MarkerFaceColor', 'yellow', 'MarkerEdgeColor', 'black');

% Loop through all combinations of parameters
for dist = initial_distances
    for ball_dir = initial_ball_directions
        for vel = ball_velocities
            for move_dir = ball_movement_directions
                % Calculate initial ball position
                x0 = -dist * cos(ball_dir);
                y0 = dist * sin(-ball_dir);
                
                % Calculate velocity components
                vx = -0.4 * vel * cos(move_dir);
                vy = 0.4 * vel * sin(-move_dir);
                
                % Plot quiver
                quiver(x0, y0, vx, vy, 0, ...
                       'AutoScale', 'off', ...
                       'Color', 'b', ...
                       'LineWidth', 1, ...        % Increase line thickness
                       'MaxHeadSize', 2);      % Increase arrowhead size
            end
        end
    end
end

xlim([-700, 100])
ylim([-100, 600])

% Add grid and legend
grid on;
% legend({'Robot', 'Test Cases'}, 'Location', 'bestoutside');
