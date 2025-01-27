clear;

v_a_mag_mult = [0.58];
figure;
hold on;

for i = 1:length(v_a_mag_mult)
  v_max = 3.6;
  a_max = 1.8;
  
  % Parameters
  r_o0 = [-2, 1]; % Initial position of the object
  r_a0 = [0, 0];   % Initial position of the agent
  v_o = [2, -0.5];    % Velocity direction of the object
  v_o_mag = 2;    % Magnitude of the object's velocity
  v_a_mag = v_a_mag_mult(i) * v_max;
  threshold = 0.1;
  
  % Time settings
  t_max = 20; % Maximum time for simulation
  dt = 0.01; % Time step
  time = 0:dt:t_max; % Time vector
  
  t_acc = v_max / a_max; % Time to reach maximum velocity (acceleration phase)
  
  r_a(1, :) = r_a0;   % Starting position of the agent
  r_o(1, :) = r_o0;   % Starting position of the object
  v_current = 0;
  distances = [];   % Starting position of the object
  
  for i = 2:length(time)
    % Calculate intercept point
    d = norm(r_o(i-1, :) - r_a(i-1, :)); % Distance between agent and object
    t_intercept = d / v_a_mag; % Time to intercept
    r_intercept = r_o(i-1, :) + v_o_mag * v_o/norm(v_o) * t_intercept; % Predicted intercept point
  
    direction = r_intercept - r_a(i-1, :);
    direction = direction / norm(direction); % Normalize direction
  
    % Calculate the remaining distance to the intercept point
    remaining_distance = norm(r_intercept - r_a(i-1, :));
    
    % Check if the agent needs to decelerate
    if remaining_distance <= (v_current^2) / (2 * a_max)
        % Start decelerating to reach the intercept point
        v_current = min(v_max, sqrt(v_current^2 - 2 * a_max * remaining_distance));
    elseif time(i) <= t_acc
        % Acceleration phase
        v_current = min(v_max, a_max * time(i)); % Velocity increases with acceleration
    else
        % Deceleration phase
        v_current = v_max - min(v_max, a_max * (time(i) - (t_acc + t_intercept))); % Adjust deceleration
    end

    v_current
  
    % Update agent's position
    r_a(i, :) = r_a(i-1, :) + v_current * direction * dt;
    r_o(i, :) = r_o0 + v_o_mag * v_o/norm(v_o) * time(i);
  
    distances(i) = norm(r_a(i, :) - r_o(i, :));
    if distances(i) < threshold
        break; % Exit the loop if the agent is within the threshold of the intercept point
    end
  end
  
  % Plot the trajectories
  plot(r_o(:, 1), r_o(:, 2), 'b-', 'LineWidth', 2); % Object trajectory
  plot(r_a(:, 1), r_a(:, 2), 'r-', 'LineWidth', 2); % Agent trajectory
  plot(r_intercept(1), r_intercept(2), 'go', 'MarkerFaceColor', 'g'); % Intercept point
  legend('Object Trajectory', 'Agent Trajectory', 'Intercept Point');
  xlabel('X Position');
  ylabel('Y Position');
  title('Optimal Interception of a Moving Object');
  grid on;
  axis equal;
end

hold off;








