% 索伯滤波器（Sobel filter）
function edges = edge_detection(image)
sobelX = [-1 0 1; -2 0 2; -1 0 1]; % 横向边缘矩阵
sobelY = [-1 -2 -1; 0 0 0; 1 2 1]; % 纵向边缘矩阵

% 对横纵向分别卷积
horizontal_edges = convolve(image, sobelX, 3);
vertical_edges = convolve(image, sobelY, 3);

% 计算梯度大小
edges = sqrt(horizontal_edges.^2 + vertical_edges.^2);
end
