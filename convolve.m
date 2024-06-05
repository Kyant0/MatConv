function out_img = convolve(img, kernel, ksize)
% 需要把图像数据转换为 double 进行运算
img = im2double(img);

% 填充图像边界
pad_size = floor(ksize / 2);
padded_img = padarray(img, [pad_size, pad_size], 'symmetric', 'both');

% 卷积
out_img = zeros(size(img));
for i = 1:3 % 对每个 RGB 通道分别处理
    out_img(:, :, i) = conv2(padded_img(:, :, i), kernel, 'valid');
end

% 在 [0, 1] 内裁剪通道，确保不超出 sRGB 色域
out_img(out_img < 0) = 0;
out_img(out_img > 1) = 1;
end


% conv2 的一种实现，假设 A, B 已经被填充
% （把上面代码中的 'valid' 参数去掉并把函数名换成 my_conv2 来使用这并不高效的代码）
function C = my_conv2(A, B)
[mA, nA] = size(A);
[mB, nB] = size(B);

mC = mA - mB + 1;
nC = nA - nB + 1;

C = zeros(mC, nC);

% 反褶
B = rot90(B, 2);

for i = 1:mC
    for j = 1:nC
        % 相乘
        C(i, j) = sum(sum(A(i:i+mB-1, j:j+nB-1) .* B));
    end
end
end
