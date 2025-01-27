% Parameters
amax = 1.8; % Maximum acceleration (m/s^2)
vmax = 3.6; % Maximum velocity (m/s)
d = 10; % Total displacement (m)

% Compute times
t_acc = vmax / amax; % Time to reach max velocity
d_acc = 0.5 * amax * t_acc^2; % Distance during acceleration
if 2 * d_acc > d
    % Adjust for case where max velocity is not reached
    t_acc = sqrt(d / amax);
    t_flat = 0;
    vmax = amax * t_acc;
else
    d_flat = d - 2 * d_acc; % Distance at constant velocity
    t_flat = d_flat / vmax; % Time at constant velocity
end
t_total = 2 * t_acc + t_flat; % Total time

% Time vectors
dt = 0.01; % Time step
t = 0:dt:t_total;

% Initialize profiles
position = zeros(size(t));
velocity = zeros(size(t));
acceleration = zeros(size(t));

% Populate profiles
for i = 1:length(t)
    if t(i) < t_acc
        % Acceleration phase
        acceleration(i) = amax;
        velocity(i) = amax * t(i);
        position(i) = 0.5 * amax * t(i)^2;
    elseif t(i) < t_acc + t_flat
        % Constant velocity phase
        acceleration(i) = 0;
        velocity(i) = vmax;
        position(i) = d_acc + vmax * (t(i) - t_acc);
    else
        % Deceleration phase
        t_dec = t(i) - t_acc - t_flat;
        acceleration(i) = -amax;
        velocity(i) = vmax - amax * t_dec;
        position(i) = d_acc + d_flat + vmax * t_dec - 0.5 * amax * t_dec^2;
    end
end


% Plot results
figure;

subplot(3, 1, 1);
plot(t, position, 'b', 'LineWidth', 1.5);
legend('Position Profile [m]', "Location", "best");
grid on;
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, 'fontsize', 14);
set(gca,'fontname','Linux Libertine');

subplot(3, 1, 2);
plot(t, velocity, 'r', 'LineWidth', 1.5);
legend('Velocity Profile [m/s]', "Location", "best");
grid on;
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, 'fontsize', 14);
set(gca,'fontname','Linux Libertine');

subplot(3, 1, 3);
plot(t, acceleration, 'g', 'LineWidth', 1.5);
legend('Acceleration Profile [m/s^2]', "Location", "best");
xlabel('Time [s]');
grid on;
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, 'fontsize', 14);
set(gca,'fontname','Linux Libertine');

% sgtitle('Trapezoidal Velocity Profile');
saveas(gcf,"velocity_profiles",'svg');
