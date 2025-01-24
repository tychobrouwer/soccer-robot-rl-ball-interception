xs = 0:10:600;
ys = 10 * exp(-2*xs/500);

figure;
plot(xs, ys, "LineWidth", 2)
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, 'fontsize', 20);
set(gca,'fontname','Linux Libertine');

xlabel("distance robot and ball [cm]");
ylabel("distance reward");
ylim([0, 12]);
saveas(gcf,"distance_reward",'svg');




xs = -4:0.1:0;
ys = -2 * exp(0.2*abs(xs)) + 2;
xs = 0.1:0.1:4;
ys = [ys xs*0];
xs = -4:0.1:4;

figure;
plot(xs, ys, "LineWidth", 2)
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, 'fontsize', 20);
set(gca,'fontname','Linux Libertine');

xlabel("relative velocity robot and ball [m/s]");
ylabel("velocity penalty");
ylim([-3, 1]);
saveas(gcf,"velocity_reward",'svg');





xs = 0:0.1:20;
ys = max(-0.28 * exp(75*abs(xs)/500) + 0.28, -2);


figure;
plot(xs, ys, "LineWidth", 2)
set(gca, 'TickLabelInterpreter', 'latex');
set(gca, 'fontsize', 20);
set(gca,'fontname','Linux Libertine');

xlabel("simulation time [s]");
ylabel("time penalty");
% ylim([-3, 1]);
saveas(gcf,"time_reward",'svg');

% close all;
