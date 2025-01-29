% A 是 3000x2561 的矩阵，第 2561 列为样本标签

% 提取样本标签和数据
labels = A(:, 2561); % 样本标签 (第2561列)
data = A(:, 1:2560); % 样本数据 (前2560列)

% 初始化存储每类样本均方根的数组
num_classes = 6; % 样本类别为 1-6
mean_rms_values = zeros(1, num_classes);

% 颜色数组，每类样本使用不同颜色
colors = lines(num_classes);

% 计算每类样本的均方根统计值
for class = 1:num_classes
    % 提取当前类别的样本
    class_samples = data(labels == class, :);
    
    % 计算当前类别每个样本的 RMS 值
    rms_values = kurtosis(class_samples);
    
    % 计算该类别 RMS 值的平均值
    mean_rms_values(class) = mean(rms_values);
end

% 绘制柱状图
figure;
b = bar(1:num_classes, mean_rms_values, 'FaceColor', 'flat');

% 应用每个柱子的颜色
for class = 1:num_classes
    b.CData(class, :) = colors(class, :); % 设置柱子的颜色
end

% 设置图形属性
xlabel('Sample Class', 'FontSize', 12);
ylabel('Kurtosis Value', 'FontSize', 12);
title('Kurtosis for Each Class', 'FontSize', 12);
xticks(1:num_classes);
grid on;

% 图例
% legend_labels = arrayfun(@(x) ['Class ' num2str(x)], 1:num_classes, 'UniformOutput', false);
% legend(legend_labels, 'Location', 'bestoutside', 'FontSize', 10);
