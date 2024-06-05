function sharpened_img = sharpen(image)
m = [0 -1 0; -1 5 -1; 0 -1 0];
sharpened_img = convolve(image, m, 3);
end
