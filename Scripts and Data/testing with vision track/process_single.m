for i=1:1
  T = readtable("Take " + i + ".csv", 'NumHeaderLines', 6);

  start_index = 1;
  end_index = height(T);

  if i == 1
    start_index = 500;
    end_index = 5800;
  elseif  i == 2
    start_index = 500;
    end_index = 5800;
  elseif  i == 3
    start_index = 2000;
    end_index = 4500;
  elseif  i == 4
    start_index = 1000;
    end_index = 4500;
  end

  % Remove nan rows from data
  toDelete = isnan(T.X);
  T(toDelete,:) = [];

  % Plot position
  figure;
  plot(T.X_1(start_index:end_index), T.Z_1(start_index:end_index))
  ylim([-3.5, 3.5])
  xlim([-1, 6])
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
  plot(T.Time_Seconds_(start_index:end_index), x_speed(start_index:end_index))
  hold on
  plot(T.Time_Seconds_(start_index:end_index), y_speed(start_index:end_index))
  hold off
  ylim([-3.5, 3.5])
  title("Take " + i + " velocity");
  xlabel("x velocity")
  ylabel("y velocity")
  saveas(gcf,"figures/take-" + i + "-velocity",'epsc')
end











