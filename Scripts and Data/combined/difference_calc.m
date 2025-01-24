files = [
  "test1_diamond_shape"
  "test2_diamond_shape"
  "test1_straight_line_no_rotation"
  "test2_straight_line_no_rotation"
];

comb_avg_error = 0;
comb_max_error = 0;

for n = 1:length(files)
    file_ext = files(n);
    file_name = "unreal_data_" + file_ext + ".mat";

    data = load(file_name).ans;


    % Ensure time starts at zero
    first_time = data(1,1);
    data(1,:) = data(1,:) - first_time;

    numCols = size(data, 2);

    toRemove = abs(data(2,:)) > 4 | abs(data(3,:)) > 4 | abs(data(4,:)) > 4;
        
    data(:,toRemove) = [];

    T = readtable("Take " + n + ".csv", 'NumHeaderLines', 6);
    
    start_index = 1;
    end_index = height(T);

    if n == 1
      start_index = 6000;
      end_index = 23800;
      start_index2 = 4500;
      end_index2 = 10130;
    elseif  n == 2
      start_index = 6000;
      end_index = 23800;
      start_index2 = 4500;
      end_index2 = 10130;
    elseif  n == 3
      start_index = 1;
      end_index = 7000;
      start_index2 = 2600;
      end_index2 = 4800;
    elseif  n == 4
      start_index = 1;
      end_index = 9500;
      start_index2 = 1000;
      end_index2 = 3800;
    end

    % Remove nan rows from data
    toDelete2 = isnan(T.X);
    T(toDelete2,:) = [];

    if contains(file_ext, "diamond")
      x1 = data(11,start_index:end_index)+0.08;
      y1 = data(10,start_index:end_index)+0.02;
      
      x2 = T.X_1(start_index2:end_index2);
      y2 = T.Z_1(start_index2:end_index2);
    else
      x1 = data(10,start_index:end_index)+0.02;
      y1 = data(11,start_index:end_index)+0.08;
      
      x2 = T.Z_1(start_index2:end_index2);
      y2 = T.X_1(start_index2:end_index2);
    end
    
    % Interpolate dataset 2 to match the number of points in dataset 1
    n1 = length(x1);
    n2 = length(x2);
    
    % Generate uniform indices for interpolation
    t1 = linspace(0, 1, n1);
    t2 = linspace(0, 1, n2);
    
    x2_interp = interp1(t2, x2, t1, 'linear');
    y2_interp = interp1(t2, y2, t1, 'linear');
    
    % Initialize variables for alignment
    min_avg_distance = Inf; % Start with a very large value
    min_max_distance = Inf; % Start with a very large value
    best_shift = 0;
    
    % Loop through possible shifts of Dataset 2 relative to Dataset 1
    for shift = 0:(n1 - n2)
        % Extract the aligned subset of Dataset 1 for the current shift
        x1_shifted = x1(1+shift : n2+shift);
        y1_shifted = y1(1+shift : n2+shift);
        
        % Compute Euclidean distances for this shift
        distances = sqrt((x1_shifted - x2_interp(1:n2)).^2 + (y1_shifted - y2_interp(1:n2)).^2);
        
        % Calculate average distance
        avg_distance = mean(distances);
        
        % Check if this is the best alignment so far
        if avg_distance < min_avg_distance
            min_avg_distance = avg_distance;
            min_max_distance = max(distances);
            best_shift = shift;
        end
    end
    
    % Display results
    fprintf('Minimum Average Distance: %.4f\n', min_avg_distance);
    fprintf('Maximum Distance: %.4f\n', min_max_distance);
    fprintf('Best Shift: %d\n', best_shift);

    comb_avg_error = comb_avg_error + min_avg_distance;
    comb_max_error = comb_max_error + min_max_distance;
end

comb_avg_error = comb_avg_error / length(files);
comb_max_error = comb_max_error / length(files);


fprintf('\n COMBINED RESULTS\n')
fprintf('Average Error: %.4f\n', comb_avg_error);
fprintf('Maximum Error: %.4f\n', comb_max_error);
