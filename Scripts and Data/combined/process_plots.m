files = [
  "test1_diamond_shape"
  "test2_diamond_shape"
  "test1_straight_line_no_rotation"
  "test2_straight_line_no_rotation"
];

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
      end_index = 2000;
      % end_index = 7000;
      start_index2 = 2600;
      % end_index2 = 4800;
      end_index2 = 3000;
    elseif  n == 4
      start_index = 1;
      end_index = 9500;
      start_index2 = 1000;
      end_index2 = 3800;
    end

    % Remove nan rows from data
    toDelete2 = isnan(T.X);
    T(toDelete2,:) = [];

    % Plot position
    figure;

    if contains(file_ext, "diamond")
      plot(data(11,start_index:end_index)+0.08, data(10,start_index:end_index)+0.02); hold on;
      plot(T.X_1(start_index2:end_index2), T.Z_1(start_index2:end_index2)); hold off;
    else
      plot(data(10,start_index:end_index)+0.02, data(11,start_index:end_index)+0.08); hold on;
      plot(T.Z_1(start_index2:end_index2), T.X_1(start_index2:end_index2)); hold off;
    end
    % title(strrep(file_ext, "_", " ") + ' setpoints and OptiTrack positions');
    if contains(file_ext, "diamond")
        xlim([1, 7]);
        ylim([-3.5, 3.5]);
    else
        xlim([-1.5, 5.5]);
        ylim([-0.5, 4.5]);
    end
    xlabel("x position [m]");
    ylabel("y position [m]");
    lgd = legend(["setpoints", "OptiTrack position"]);

    pos = lgd.Position; % [left, bottom, width, height]

    if contains(file_ext, "diamond")
      pos(1) = pos(1)+0.01;
      pos(2) = pos(2)-0.03;
      lgd.Position = pos;
    end

    set(gca, 'fontsize', 20);
    set(gca,'fontname','Linux Libertine');
    saveas(gcf,"figures/" + file_ext + "_position_comparison",'svg');
end











