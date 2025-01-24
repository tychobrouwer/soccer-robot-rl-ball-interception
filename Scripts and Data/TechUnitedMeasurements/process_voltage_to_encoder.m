files = [
    % "test1_diamond_shape"
    % "test1_straight_line_no_rotation"
    "test1_straight_line_with_rotation"
    % "test2_diamond_shape"
    % "test2_straight_line_no_rotation"
    % "test2_straight_line_with_rotation"
];

% data order is
% 1: timedata
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

    toRemove = abs(data(2,:)) > 4 | abs(data(3,:)) > 4 | abs(data(4,:)) > 4;

    disp("removed values");
    for i = 1:length(toRemove)
      value = toRemove(i);

      if value == 1
        disp("removed " + i + ": " + data(2,i) + ", " + data(3,i) + ", " + data(4,i))
      end
    end

    data(:,toRemove) = [];

    % toRemoveDAC = data(18,:) == 0 | data(19,:) == 0 | data(20,:) == 0;
    % data(:,toRemoveDAC) = [];

    window_size = 100;

    % Initialize a matrix to store the results
    [nRows, nCols] = size(data);
    window_means = [];
    
    % Loop through each row
    for row = 1:nRows
        row_data = data(row, :);  % Extract the current row
        row_means = [];  % Initialize row result
    
        % Loop over the current row with a step of window_size
        for i = 1:window_size:nCols
            window_data = row_data(i:min(i + window_size - 1, nCols));  % Define window
            row_means(end + 1) = mean(window_data);  % Calculate window mean
        end
    
        % Append the row result
        window_means = [window_means; row_means];
    end


    figure;
    scatter(window_means(2,:), window_means(18,:), 3); hold on;
    scatter(window_means(3,:), window_means(18,:), 3); hold on;
    scatter(window_means(4,:), window_means(18,:), 3); hold on;
    title({strrep(file_ext, "_", " ") + ' encoder', 'value against DAC output 1'}, "FontSize", 16);
    ylabel("DAC output [V]");
    xlabel("Encoder value [rad/s]");
    saveas(gcf,"figures/" + file_ext + "_encoder_dac_1",'epsc');

    figure;
    scatter(window_means(2,:), window_means(19,:), 3); hold on;
    scatter(window_means(3,:), window_means(19,:), 3); hold on;
    scatter(window_means(4,:), window_means(19,:), 3); hold on;
    title({strrep(file_ext, "_", " ") + ' encoder', 'value against DAC output 2'}, "FontSize", 16);
    ylabel("DAC output [V]");
    xlabel("Encoder value [rad/s]");
    saveas(gcf,"figures/" + file_ext + "_encoder_dac_2",'epsc');

    figure;
    scatter(window_means(2,:), window_means(20,:), 3); hold on;
    scatter(window_means(3,:), window_means(20,:), 3); hold on;
    scatter(window_means(4,:), window_means(20,:), 3); hold on;
    title({strrep(file_ext, "_", " ") + ' encoder', 'value against DAC output 3'}, "FontSize", 16);
    ylabel("DAC output [V]");
    xlabel("Encoder value [rad/s]");
    saveas(gcf,"figures/" + file_ext + "_encoder_dac_3",'epsc');
end
