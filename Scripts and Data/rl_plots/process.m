% Define the directory containing the CSV files
dataDirs = ["data1", "data2", "data3", "data4"];

for i = 1:1
  dataDir = dataDirs(i);

  % Get a list of all CSV files in the directory matching the pattern
  filePattern = fullfile(dataDir, 'results-location-*-robot0.txt');
  csvFiles = dir(filePattern);

  mkdir("figures_" + dataDir)
  
  % Loop through each file and create a plot
  for k = 1:length(csvFiles)
  % for k = [16, 28, 52, 85, 138, 144, 149]
  % for k = [144]
    % Get the full file path
    filePath = fullfile(dataDir, csvFiles(k).name);
    
    % Read the data from the CSV file
    % Assuming the CSV has a standard format with columns (e.g., time, x, y)
    data = readmatrix(filePath); % Alternatively, use readtable(filePath) for labeled data
    
    % Extract columns for plotting (adjust indices based on your CSV structure)
    % Example: time is column 1, x is column 2, y is column 3
    x = data(:, 2);
    y = data(:, 3);
    
    x_ball = data(:, 6);
    y_ball = data(:, 5);

    % Create a plot
    figure; % Open a new figure
    plot(x, y);
    hold on;
    plot(x_ball, y_ball, '-x', "MarkerSize", 6);
    hold off;
    
    % Add title, labels, and legend
    xlabel('X Position [m]');
    if i == 1

      ylabel('Y Position [m]');
    else
      ylabel('  ')
    end

    if k == 16
      xlim([-5, 5]);
      ylim([-2, 8]);
    elseif k == 28
      xlim([-5, 10]);
      ylim([-5, 10]);
    elseif k == 52
      xlim([-4, 16]); 
      ylim([-8, 12]);
    elseif k == 138
      xlim([-7, 3])
      ylim([-7, 3])
    elseif k == 144
      xlim([-7, 1])
      ylim([-4, 4])
    else
      xlim([-7, 13]); 
      ylim([-8, 12]);
    end
    legend({"Robot trajectory", "Ball trajectory"});
    set(gca, 'TickLabelInterpreter', 'latex');
    set(gca, 'fontsize', 20);
    set(gca,'fontname','Linux Libertine');

    saveas(gcf,"figures_" + dataDir + "/rl_trajectory_test_" + k,'svg');
    % saveas(gcf,"example_intercept", "svg");

    % close all;
  end
end

% data 1
% test 16 - stationary max distance
% test 28 - fairy good intercept
% test 52 - slow oke intercept
% test 138 - bounce intercept
% test 144 - good intercept

% data 4
% test 16 - stationary max distance
% test 28 - fairy good intercept
% test 52 - fairy good intercept
% test 85 - tracking intercept
% test 138 - good intercept
% test 144 - overshoot intercept
% test 149 - wierd tracking behaviour

