% Set up a figure with two y-axis on left and right side
% DK Shin
% 19/08/16


%% Create figure and axis
figure();  % create the figure

% Axes 1
ax1 = gca;
ax1.Box = 'off';
hold on;

% Axes 2
ax2 = axes('Position',ax1.Position,...
    'XAxisLocation','bottom',...
    'YAxisLocation','right',...
    'Color','none');
ax2.XLim = ax1.XLim;    % Fix x-axis limits
ax2.XAxis.Color = 'none';
hold on;

%% Figure labels
title('FIGURE TITLE');

xlabel(ax1,'COMMON X');
ylabel(ax1,'Y1');

xlabel(ax2,'COMMON X INVIS');
ylabel(ax2,'Y2');
