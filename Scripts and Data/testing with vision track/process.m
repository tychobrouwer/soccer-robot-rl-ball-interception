for i=1:4
  T = readtable("Take " + i + ".csv", 'NumHeaderLines', 6);

  % Remove nan rows from data
  toDelete = isnan(T.X);
  T(toDelete,:) = [];

  % Plot position
  figure;
  plot(T.X_1, T.Z_1)
  ylim([-3.2, 3.2])
  xlim([-0.2, 5.2])
  title("Take " + i + " position");
  xlabel("x position")
  ylabel("y position")
  saveas(gcf,"figures/take-" + i + "-position",'epsc')

  % Store previous x, y, and t for velocity calculation
  x_prev = T.X_1(1);
  y_prev = T.Z_1(1);
  t_prev = T.Time_Seconds_(1);

  % Output x speed, y speed, and delta t
  x_speed = zeros(height(T) - 1, 1);
  y_speed = zeros(height(T) - 1, 1);
  delta_t = zeros(height(T) - 1, 1);

  % Iterate from 2 to last row
  for row = 2:height(T)
    % Delta t calculation
    delta_t(row-1) = T.Time_Seconds_(row) - T.Time_Seconds_(row - 1);
    
    % Slope calculation for x and y
    x_speed(row-1) = (T.X_1(row) - x_prev) / delta_t(row-1);
    y_speed(row-1) = (T.Z_1(row) - y_prev) / delta_t(row-1);

    % Save current for next previous
    x_prev = T.X_1(row);
    y_prev = T.Z_1(row);
  end

  % Perform moving mean filter to clear up data
  x_speed = movmean(x_speed, 30);
  y_speed = movmean(y_speed, 30);

  % Plot velocity
  figure;
  plot(T.Time_Seconds_(1:end-1), x_speed)
  hold on
  plot(T.Time_Seconds_(1:end-1), y_speed)
  hold off
  ylim([-3.2, 3.2])
  title("Take " + i + " velocity");
  xlabel("x velocity")
  ylabel("y velocity")
  saveas(gcf,"figures/take-" + i + "-velocity",'epsc')
end











