bloodtif=imread("blood.tif");
figure(1)
imshow(bloodtif);
I=im2gray(bloodtif);
%%
disp('1.1/2')

figure(2)

% Apply the edge detection methods
E_sobel = edge(I, 'sobel');
E_prewitt = edge(I, 'prewitt');
E_roberts = edge(I, 'roberts');
E_log = edge(I, 'log');
E_zerocross = edge(I, 'zerocross');
E_canny = edge(I, 'canny');

% Threshold the output images to obtain binary images
%

% Display the binary images side-by-side with titles
figure;
subplot(2,3,1);
imshow(E_sobel);
title('Sobel');
subplot(2,3,2);
imshow(E_prewitt);
title('Prewitt');
subplot(2,3,3);
imshow(E_roberts);
title('Roberts');
subplot(2,3,4);
imshow(E_log);
title('Log');
subplot(2,3,5);
imshow(E_zerocross);
title('Zerocross');
subplot(2,3,6);
imshow(E_canny);
title('Canny');


%%
figure(3)
disp('RG')
coins=imread("coins.jpg");
imshow(coins);
img=rgb2gray(coins);

figure(4)

% Create the mask
mask = zeros(size(img));
PX=10;
mask(PX:end-PX,PX:end-PX) = 1;


figure(5)
imshow(mask(PX:end-PX,PX:end-PX))

% Apply the active contours technique with default maximum iterations
contour_default = activecontour(img, mask);

% Apply the active contours technique with 50 maximum iterations
contour_50 = activecontour(img, mask, 50);

% Apply the active contours technique with 500 maximum iterations
contour_500 = activecontour(img, mask, 500);

% Apply the active contours technique with 1000 maximum iterations
contour_1000 = activecontour(img, mask, 1000);

% Display the results
figure;
subplot(2,3,1);
imshow(img);
title('Original Image');
subplot(2,3,2);
imshow(contour_default);
title('Default Iterations');
subplot(2,3,3);
imshow(contour_50);
title('50 Iterations');
subplot(2,3,4);
imshow(contour_500);
title('500 Iterations');
subplot(2,3,5);
imshow(contour_1000);
title('1000 Iterations');



%%

figure(10)
% Read the input image
dots = imread('CELLfind.jpg');

% Convert the image to grayscale
dots_gray = rgb2gray(dots);

% Binarize the image using Otsu's method
level = graythresh(dots_gray);
threshold1=adaptthresh(dots_gray,0.75,"NeighborhoodSize",[21 21]);
dots_bw = imbinarize(dots_gray, level);

% Create the diamond-shaped structuring element with size 8
se = strel('disk', 5);

t_binary=88;
dots_t=(dots_gray>t_binary);

% Apply a sequence of erosion/dilation operations to remove noise
dots_cleaned = dots_bw;
for i = 1:3
    dots_cleaned = imerode(dots_cleaned, se);
    dots_cleaned = imdilate(dots_cleaned, se);
end

% Display the original, Otsu binarized, and cleaned binary images side by side
subplot(2,2,1);
imshow(dots);
title('Original Image');
subplot(2,2,2);
imshow(dots_t);
title(['Picked threshold: ',num2str(t_binary)]);
subplot(2,2,3);
imshow(dots_bw);
title('Otsu Binarized Image');
subplot(2,2,4);
imshow(dots_cleaned);
title('Cleaned Binary Image for picked threshold');

%%
% Apply morphological algorithms to the cleaned binary image
dots_filled = imfill(dots_cleaned, 'holes');
dots_boundary = bwperim(dots_filled);
dots_skeleton = bwmorph(dots_filled, 'thin', inf);

% Display the original and the three results side by side
figure;
subplot(1,4,1);
imshow(dots_cleaned);
title('Original Image');
subplot(1,4,2);
imshow(dots_filled);
title('Filled Image');
subplot(1,4,3);
imshow(dots_boundary);
title('Boundary Image');
subplot(1,4,4);
imshow(dots_skeleton);
title('Skeleton Image');

