% A 是一个 3000x2561 的矩阵，前 2560 列为信号，第 2561 列为样本标签

% 参数设置
fs = 64000; % 采样频率 (64 kHz)

% 获取第 1 个样本和最后一个样本信号
signal1 = A(1, 1:2560);            % 第 1 个样本信号
signal_last = A(end, 1:2560);      % 最后一个样本信号

% 定义包络谱绘制函数
function plotEnvelopeSpectrum(signal, fs, sample_num)
    % 信号绝对值取包络
    envelope = abs(hilbert(signal));
    
    % 频谱计算
    N = length(envelope);          % 信号长度
    Y = abs(fft(envelope) / N);    % FFT 幅值归一化
    f = (0:N-1) * (fs / N);        % 频率向量
    
    % 去除零频成分
    Y(1) = 0;                      % 将零频成分置零
    
    % 仅保留前半段频谱
    half_range = 1:ceil(N/2);
    f = f(half_range);
    Y = Y(half_range);
    
    % 绘制图像
    figure;
    plot(f, Y, 'b', 'LineWidth', 1.2);
    xlabel('Frequency (Hz)', 'FontSize', 12);
    ylabel('Amplitude', 'FontSize', 12);
    title(['Envelope Spectrum of Sample ' num2str(sample_num)], ...
         'FontSize', 12);
    grid on;
end

% 绘制第 1 个样本的包络谱
plotEnvelopeSpectrum(signal1, fs, 1);

% 绘制最后一个样本的包络谱
plotEnvelopeSpectrum(signal_last, fs, size(A, 1));
