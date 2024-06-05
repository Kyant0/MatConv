function blurred_img = box_blur(img, ksize)
if mod(ksize, 2) == 0
    ksize = ksize + 1; % 核大小为奇数
end

% 生成标准化的卷积核
kernel = double(ones(ksize)) / ksize / ksize;

% 卷积
blurred_img = convolve(img, kernel, ksize);
end
