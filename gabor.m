function img = gabor(image, deg)
size = 27;
sigma = 4.0;
theta = deg / 180.0 * pi;
frequency = 0.2;
gamma = 0.5;
phase = 0;

gaborKernel = createGaborKernel(size, sigma, theta, frequency, gamma, phase);

img = convolve(image, gaborKernel, size);
end

% size 核的大小
% sigma 高斯函数的标准差
% theta 方位角，以弧度为单位
% frequency 核的频率
% gamma 长宽比
% phase 相位偏移量
function gaborKernel = createGaborKernel(size, sigma, theta, frequency, gamma, phase)
    n = (size - 1) / 2;
    [x, y] = meshgrid(-n:n, -n:n);

    xPrime = x * cos(theta) + y * sin(theta);
    yPrime = -x * sin(theta) + y * cos(theta);

    g = exp(-0.5 * (xPrime.^2 / sigma^2 + gamma^2 * yPrime.^2 / sigma^2));

    s = cos(2 * pi * frequency * xPrime + phase);

    gaborKernel = g .* s;
end
