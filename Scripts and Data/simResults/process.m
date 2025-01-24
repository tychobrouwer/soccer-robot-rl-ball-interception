filenames = [
  % "results-1730371250519-input_test1_straight_line_no_rotation_trunc"
  % "results-1730371289679-input_test2_straight_line_no_rotation_trunc"
  "results-1730371117004-input_test1_diamond_shape_trunc"
  "results-1730371176745-input_test2_diamond_shape_trunc"
  % "results-1731413804709-perfect_controller_input_test1_straight_line_no_rotation_trunc"
  % "results-1731413926122-perfect_controller_input_test2_straight_line_no_rotation_trunc"
  % "results-1731413990216-perfect_controller_input_test1_diamond_shape_trunc"
  % "results-1731414055426-perfect_controller_input_test2_diamond_shape_trunc"
];

filenames_2 = [
  % "unreal_data_test1_straight_line_no_rotation.mat"
  % "unreal_data_test2_straight_line_no_rotation.mat"
  "unreal_data_test1_diamond_shape.mat"
  "unreal_data_test2_diamond_shape.mat"
];

filenames_3 = [
  "results-1731413804709-perfect_controller_input_test1_straight_line_no_rotation_trunc"
  "results-1731413926122-perfect_controller_input_test2_straight_line_no_rotation_trunc"
  "results-1731413990216-perfect_controller_input_test1_diamond_shape_trunc"
  "results-1731414055426-perfect_controller_input_test2_diamond_shape_trunc"
];

for n = 1 : length(filenames)
  filename = filenames(n);
  filename_2 = filenames_2(n);
  filename_3 = filenames_3(n);

  data = csvread(filename + ".txt");
  data_3 = csvread(filename_3 + ".txt");
  data_2 = load(filename_2).ans;

  filename_parts = split(filename, "-");
  category = filename_parts(3);

  % Ensure time starts at zero
  first_time = data_2(1,1);
  data_2(1,:) = data_2(1,:) - first_time;
  toRemove = abs(data_2(2,:)) > 4 | abs(data_2(3,:)) > 4 | abs(data_2(4,:)) > 4;
  data_2(:,toRemove) = [];

  start_index = 1;
  end_index = width(data_2);
  start_index2 = 1;
  end_index2 = height(data);

  % if n == 3
  %   start_index = 6000;
  %   end_index = 23800;
  %   start_index2 = 1;
  %   end_index2 = 250;
  % elseif  n == 4
  %   start_index = 6000;
  %   end_index = 23800;
  %   start_index2 = 1;
  %   end_index2 = 230;
  % elseif  n == 1
  %   start_index = 1;
  %   end_index = 7000;
  %   start_index2 = 1;
  %   end_index2 = 150;
  % elseif  n == 2
  %   start_index = 1;
  %   end_index = 9500;
  %   start_index2 = 1;
  %   end_index2 = 200;
  % end

  % Plot position
  figure;
  if contains(category, "line")
    plot(data_2(10,start_index:end_index)-0.25, data_2(11,start_index:end_index)); hold on;
    plot(data(start_index2:end_index2,2)+0.25, data(start_index2:end_index2,3));
  else
    plot(data_2(10,start_index:end_index), data_2(11,start_index:end_index)); hold on;
    plot(data(start_index2:end_index2,2), data(start_index2:end_index2,3));
  end
  % plot(data_3(:,2), data_3(:,3));

  category = strrep(category, "input_", "");
  category = strrep(category, "_trunc", "");

  % if contains(category, "perfect")
  %   title('simulation results position (perfect controller)');
  % else
  %   title('simple controller simulation results position (' + strrep(category, "_", " ") + ')');
  % end
  if contains(category, "diamond")
    xlim([-3, 6]);
    ylim([-0.5, 6]);
  else
    xlim([-1.5, 5.5]);
    ylim([-0.5, 4.5]);
  end
  xlabel("x position [m]");
  ylabel("y position [m]");
  legend(["setpoints", "simulation"])
  set(gca, 'fontsize', 22);
  set(gca,'fontname','Linux Libertine');

  saveas(gcf,"figures/sim_" + category + "_position",'svg');
end






