[img] = imread('resources\740.jpg');
scaledImg = imresize(img, 0.5);

[imgToSharpen] = imread('resources\car.png');

windowHeight = 600;
fig = uifigure('Position', [250, 200, 760, windowHeight], 'Name', 'Image Display GUI');

function newPos = pos(left, top, width, height)
windowHeight = 600;
bottom = windowHeight - top - height;
newPos = [left, bottom, width, height];
end

uicontrol(fig, ...
    'Style','text', ...
    'String', 'MatConv', ...
    'FontSize', 24, ...
    'Position', pos(300, 20, 200, 100));

uicontrol(fig, ...
    'Style','text', ...
    'String', 'Original', ...
    'FontSize', 16, ...
    'Position', pos(40, 100, 300, 40));

uicontrol(fig, ...
    'Style','text', ...
    'String', 'Processed', ...
    'FontSize', 16, ...
    'Position', pos(430, 100, 300, 40));

global compOriImg;
global compImg;
global compList;
global compListLength;
compOriImg = 0;
compImg = 0;
compList = [];
compListLength = 0;

dropdown = uidropdown(fig, ...
    'Position', pos(50, 500, 200, 22), ...
    'Items', {'Gaussian blur', 'Box blur', 'Edge detection', 'Sharpen'}, ...
    'FontSize', 16, ...
    'Value', 'Gaussian blur', ...
    'ValueChangedFcn', @(src,event) selectionChanged(fig, scaledImg, img, imgToSharpen, src.Value));

selectionChanged(fig, scaledImg, img, imgToSharpen, dropdown.Value);


function selectionChanged(fig, img, nonScaledImg, imgToSharpen, val)
global compOriImg;
global compImg;
global compList;
global compListLength;

if compOriImg ~= 0
    delete(compOriImg);
    compOriImg = 0;
end

if compImg ~= 0
    delete(compImg);
    compImg = 0;
end

if compListLength > 0
    for index = compListLength:-1:1
        delete(compList(index));
    end
    compListLength = 0;
end

switch val
    case 'Gaussian blur'
        global sigmaVal;
        sigmaVal = 7;

        oriImg = img;

        % sigma
        compList(1) = uicontrol(fig, ...
            'Style','text', ...
            'String', 'Sigma', ...
            'FontSize', 12, ...
            'Position', pos(400, 500, 100, 40));
        slider = uislider(fig, ...
            'Limits', [1, 25], 'Value', sigmaVal, ...
            'Position', pos(500, 500, 200, 0), ...
            "ValueChangedFcn", @(src,event) updateGaussianSigma(fig, oriImg, event.Value));
        compList(2) = slider;
        compListLength = 2;

        updateGaussianSigma(fig, oriImg, sigmaVal);

    case 'Box blur'
        global kSizeVal;
        global iterationVal;
        kSizeVal = 7;
        iterationVal = 12;

        oriImg = img;

        % kSize
        compList(1) = uicontrol(fig, ...
            'Style','text', ...
            'String', 'Kernel size', ...
            'FontSize', kSizeVal, ...
            'Position', pos(400, 480, 100, 40));
        slider = uislider(fig, ...
            'Limits', [1, 25], 'Value', kSizeVal, ...
            'Position', pos(500, 480, 200, 0), ...
            "ValueChangedFcn", @(src,event) updateBoxKSize(fig, oriImg, round(event.Value), iterationVal));
        compList(2) = slider;

        % iteration
        compList(3) = uicontrol(fig, ...
            'Style','text', ...
            'String', 'Iterations', ...
            'FontSize', 12, ...
            'Position', pos(400, 540, 100, 40));
        slider = uislider(fig, ...
            'Limits', [1, 25], 'Value', iterationVal, ...
            'Position', pos(500, 540, 200, 0), ...
            "ValueChangedFcn", @(src,event) updateBoxKSize(fig, oriImg, kSizeVal, round(event.Value)));
        compList(4) = slider;
        compListLength = 4;

        updateBoxKSize(fig, oriImg, kSizeVal, iterationVal);

    case 'Edge detection'
        oriImg = nonScaledImg;
        updateEdgeDetection(fig, oriImg);

    case 'Sharpen'
        oriImg = imgToSharpen;
        updateSharpen(fig, oriImg);

    otherwise
end

imgAxis = uiaxes(fig, ...
    'Position', pos(20, 140, 380, 380));
compOriImg = imshow(oriImg, 'Parent', imgAxis);

end


function updateGaussianSigma(fig, img, sigma)
global sigmaVal;
global compImg;

sigmaVal = sigma;

if compImg ~= 0
    delete(compImg);
end

outImg = gaussian_blur(img, sigma);
outImgAxis = uiaxes(fig, ...
    'Position', pos(400, 140, 380, 380));
compImg = imshow(outImg, 'Parent', outImgAxis);
end


function updateBoxKSize(fig, img, kSize, iteration)
global kSizeVal;
global iterationVal;
global compImg;

kSizeVal = kSize;
iterationVal = iteration;

if compImg ~= 0
    delete(compImg);
end

outImg = img;
for index = 1:iteration
    outImg = box_blur(outImg, kSize);
end

outImgAxis = uiaxes(fig, ...
    'Position', pos(400, 140, 380, 380));
compImg = imshow(outImg, 'Parent', outImgAxis);
end


function updateEdgeDetection(fig, img)
global compImg;

if compImg ~= 0
    delete(compImg);
end

outImg = edge_detection(img);
outImgAxis = uiaxes(fig, ...
    'Position', pos(400, 140, 380, 380));
compImg = imshow(outImg, 'Parent', outImgAxis);
end


function updateSharpen(fig, img)
global compImg;

if compImg ~= 0
    delete(compImg);
end

outImg = sharpen(img);
outImgAxis = uiaxes(fig, ...
    'Position', pos(400, 140, 380, 380));
compImg = imshow(outImg, 'Parent', outImgAxis);
end
