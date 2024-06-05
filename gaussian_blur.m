function blurred_img = gaussian_blur(img, sigma)
% 估计高斯核大小
ksize = ceil(6*sigma);
if mod(ksize, 2) == 0
    ksize = ksize + 1; % 核大小为奇数
end

% 生成高斯核
m = floor(ksize / 2);
[X, Y] = meshgrid(1:ksize);
kernel = exp(-((X-m).^2 + (Y-m).^2) / (2*sigma^2));
kernel = kernel / sum(kernel(:)); % 标准化

% 卷积
blurred_img = convolve(img, kernel, ksize);
end
