files = [
    % "test1_straight_line_no_rotation"
    % "test2_straight_line_no_rotation"
    % "test1_straight_line_with_rotation"
    % "test2_straight_line_with_rotation"
    % "test1_diamond_shape"
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

for n = 1 : length(files)
    file_ext = files(n);
    file_name = "unreal_data_" + file_ext + ".mat";

    data = load(file_name).ans;

    % Ensure time starts at zero
    first_time = data(1,1);
    data(1,:) = data(1,:) - first_time;

    numCols = size(data, 2);

    input_file_name = "inputs/input_" + file_ext + ".txt";
    delete(input_file_name);

    fileID = fopen(input_file_name,'w');
    for j = 1:numCols
        fprintf(fileID, '%.5f, %.5f, %.5f, %.5f, %.5f, %.5f, %.5f, %.5f, %.5f, %.5f\n', data([1, 10:18], j));
    end
    fclose(fileID);

    input_file_name = "inputs/input_" + file_ext + "_trunc.txt";
    delete(input_file_name);

    fileID = fopen(input_file_name,'w');
    for j = 1:50:numCols
        fprintf(fileID, '%.5f, %.5f, %.5f, %.5f, %.5f, %.5f, %.5f, %.5f, %.5f, %.5f\n', data([1, 10:18], j));
    end
    fclose(fileID);

    toRemove = abs(data(2,:)) > 4 | abs(data(3,:)) > 4 | abs(data(4,:)) > 4;
    
    disp("removed values");
    for i = 1:length(toRemove)
      value = toRemove(i);

      if value == 1
        disp("removed " + i + ": " + data(2,i) + ", " + data(3,i) + ", " + data(4,i))
      end
    end
    
    data(:,toRemove) = [];

    % % Plot wheel velocity against time
    % figure;
    % plot(data(1,:), data(2,:)); hold on;
    % plot(data(1,:), data(3,:)); hold on;
    % plot(data(1,:), data(4,:)); hold off;
    % ylim([-3, 3]);
    % title(strrep(file_ext, "_", " ") + ' velocity against time');
    % legend(["wheel 1", "wheel 2", "wheel 3"]);
    % ylabel("velocity [rad/s]");
    % xlabel("time [s]");
    % saveas(gcf,"figures/" + file_ext + "_velocity_time",'epsc');

    % Plot position
    figure;
    plot(data(11,:), data(10,:)); hold on;
    title(strrep(file_ext, "_", " ") + ' position (setpoints)');
    if contains(file_ext, "diamond")
        ylim([-1, 6]);
        xlim([-3.5, 3.5]);
    else
        ylim([-0.5, 4.5]);
        xlim([-2.5, 2.5]);
    end
    xlabel("x position [m]");
    ylabel("y position [m]");
    % saveas(gcf,"figures/" + file_ext + "_position",'epsc');

    numCols = size(data, 2);
    position_calc = zeros(2,numCols);
    position_trans = zeros(2,numCols);

    radius = 0.0486;
    kin = radius/3*[
      sqrt(3) 0 -sqrt(3);
      1 -2 1;
      1/0.207 1/0.221 1/0.207
    ];

    vel = zeros(3,numCols);
    pos = zeros(3,numCols);
    for j = 2:numCols      
      vel(:,j) = kin * [data(2,j); data(3,j); data(4,j)];

      pos(:,j) = vel(:,j) * (data(1,j) - data(1,j-1)) + pos(:,j-1);
    end

    % Plot position test
    figure;
    plot(pos(2,:), pos(1,:)); hold on;
    title(strrep(file_ext, "_", " ") + ' position');
    if contains(file_ext, "diamond")
        ylim([-1, 6]);
        xlim([-3.5, 3.5]);
    else
        ylim([-0.5, 4.5]);
        xlim([-2.5, 2.5]);
    end
    xlabel("x position [m]");
    ylabel("y position [m]");
    % saveas(gcf,"figures/" + file_ext + "_position",'epsc');

    % % Plot position error
    % figure;
    % plot(data(1,:), data(10,:) - data(6,:)); hold on;
    % plot(data(1,:), data(11,:) - data(7,:)); hold on;
    % plot(data(1,:), data(12,:) - data(8,:)); hold on;
    % title(strrep(file_ext, "_", " ") + ' position error');
    % xlabel("time [s]");
    % ylabel("position error [m]");
    % legend(["x", "y", "\theta"]);
    % saveas(gcf,"figures/" + file_ext + "_position_error",'epsc');

    % close all
end











