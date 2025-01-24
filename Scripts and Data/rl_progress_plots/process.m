% Load the data
figure;
T = readtable("run-dir2_Training_ppo_sharedmemory_2025-01-14_10-34-52-tag-experience_avg_episode_length.csv", 'NumHeaderLines', 1);

% Plot the original data
originalPlot = plot(T.Var2, T.Var3, 'b--'); % Blue solid line for original
originalPlot.Color = [0, 0, 1, 0.4];
hold on;

% Smooth the data
smoothedData = smoothdata(T.Var3, "movmean", 50);

% Plot the smoothed data
plot(T.Var2, smoothedData, 'b-', 'LineWidth', 1.5);

% Add labels and title
xlabel('training step');
ylabel('average episode length');
set(gca, 'fontsize', 22);
set(gca,'fontname','Linux Libertine');
saveas(gcf,"figures/rl_training_progress_episode_length",'svg')












% Load the data
figure;
T = readtable("run-dir2_Training_ppo_sharedmemory_2025-01-14_10-34-52-tag-experience_avg_return.csv", 'NumHeaderLines', 1);

% Plot the original data
originalPlot = plot(T.Var2, T.Var3, 'b--'); % Blue solid line for original
originalPlot.Color = [0, 0, 1, 0.4];
hold on;

% Smooth the data
smoothedData = smoothdata(T.Var3, "movmean", 50);

% Plot the smoothed data
plot(T.Var2, smoothedData, 'b-', 'LineWidth', 1.5);

% Add labels and title
xlabel('training step');
ylabel('average return');
set(gca, 'fontsize', 22);
set(gca,'fontname','Linux Libertine');
saveas(gcf,"figures/rl_training_progress_return",'svg')









% Load the data
figure;
T = readtable("run-dir2_Training_ppo_sharedmemory_2025-01-14_10-34-52-tag-experience_avg_reward.csv", 'NumHeaderLines', 1);

% Plot the original data
originalPlot = plot(T.Var2, T.Var3, 'b--'); % Blue solid line for original
originalPlot.Color = [0, 0, 1, 0.4];
hold on;

% Smooth the data
smoothedData = smoothdata(T.Var3, "movmean", 50);

% Plot the smoothed data
plot(T.Var2, smoothedData, 'b-', 'LineWidth', 1.5);

% Add labels and title
xlabel('training step');
ylabel('average reward');
set(gca, 'fontsize', 22);
set(gca,'fontname','Linux Libertine');
saveas(gcf,"figures/rl_training_progress_reward",'svg')











% Load the data
figure;
T = readtable("run-dir2_Training_ppo_sharedmemory_2025-01-14_10-34-52-tag-experience_avg_reward_sum.csv", 'NumHeaderLines', 1);

% Plot the original data
originalPlot = plot(T.Var2, T.Var3, 'b--'); % Blue solid line for original
originalPlot.Color = [0, 0, 1, 0.4];
hold on;

% Smooth the data
smoothedData = smoothdata(T.Var3, "movmean", 50);

% Plot the smoothed data
plot(T.Var2, smoothedData, 'b-', 'LineWidth', 1.5);

% Add labels and title
xlabel('training step');
ylabel('average reward sum');
set(gca, 'fontsize', 22);
set(gca,'fontname','Linux Libertine');
saveas(gcf,"figures/rl_training_progress_reward_sum",'svg')









