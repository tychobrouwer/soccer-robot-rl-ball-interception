files = [
    "test1_straight_line_no_rotation"
    "test2_straight_line_no_rotation"
    "test1_straight_line_with_rotation"
    "test2_straight_line_with_rotation"
    "test1_diamond_shape"
    "test2_diamond_shape"
];

% data order is
% 1: time
% 2: encoder 1
% 3: encoder 2
% 4: encoder 3
% 5: 0
% 6: position X             [m]
% 7: position Y             [m]
% 8: rotation               [rad]
% 9: 0
% 10: set position X        [m]
% 11: set position Y        [m]
% 12: set rotation          [rad]
% 13: set velocity X        [m/s]
% 14: set velocity Y        [m/s]
% 15: set drotation         [rad/s]
% 16: set acceleration X    [m/s^2]
% 17: set acceleration Y    [m/s^2]
% 18: set ddrotation        [rad/s^2]
% 19: DAC 1
% 20: DAC 2
% 21: DAC 3

figure;

for n = 1 : length(files)
  file_ext = files(n);
  file_name = "unreal_data_" + file_ext + ".mat";

  data = load(file_name).ans;

  % Ensure time starts at zero
  first_time = data(1,1);
  data(1,:) = data(1,:) - first_time;

  toRemove = abs(data(2,:)) > 4 | abs(data(3,:)) > 4 | abs(data(4,:)) > 4;
  
  disp("removed values");
  for i = 1:length(toRemove)
    value = toRemove(i);

    if value == 1
      disp("removed " + i + ": " + data(2,i) + ", " + data(3,i) + ", " + data(4,i))
    end
  end
  
  data(:,toRemove) = [];

  % Plot setpoint vel + acc against encoder
  scatter3(data(12:14,:), data(15:17,:), data(2:4,:), 1); hold on;
  % title('simulation results position (' + category_hiphen + ')');
  % if contains(category, "diamond")
  %   ylim([-1, 6]);
  %   xlim([-3.5, 3.5]);
  % else
  %   ylim([-0.5, 4.5]);
  %   xlim([-2.5, 2.5]);
  % end
  % xlabel("x position [m]");
  % ylabel("y position [m]");
  % saveas(gcf,"figures/sim_" + category + "_position",'epsc');
  
  % close all
end

hold off;









