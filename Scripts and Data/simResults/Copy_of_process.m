filenames = [
  "results-1730371250519-input_test1_straight_line_no_rotation_trunc"
  "results-1730371289679-input_test2_straight_line_no_rotation_trunc"
  "results-1730371117004-input_test1_diamond_shape_trunc"
  "results-1730371176745-input_test2_diamond_shape_trunc"
  "results-1731413804709-perfect_controller_input_test1_straight_line_no_rotation_trunc"
  "results-1731413926122-perfect_controller_input_test2_straight_line_no_rotation_trunc"
  "results-1731413990216-perfect_controller_input_test1_diamond_shape_trunc"
  "results-1731414055426-perfect_controller_input_test2_diamond_shape_trunc"
];

for n = 1 : length(filenames)
  filename = filenames(n);

  data = csvread(filename + ".txt");
  
  filename_parts = split(filename, "-");
  category = filename_parts(3);
  category_hiphen = strrep(category, "_", "-");

  % Plot position
  figure;
  plot(data(:,2), data(:,3));
  if contains(category_hiphen, "perfect")
    title('simulation results position (perfect controller)');
  else
    title('simulation results position (' + category_hiphen + ')');
  end
  if contains(category, "diamond")
    ylim([-1, 6]);
    xlim([-3.5, 3.5]);
  else
    ylim([-0.5, 5]);
    xlim([-2.5, 2.5]);
  end
  xlabel("x position [m]");
  ylabel("y position [m]");
  legend(["setpoints", "simulation"], FontSize=11)

  saveas(gcf,"figures/sim_" + category + "_position",'epsc');
end






