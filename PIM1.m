disp('welcome PIM')
%% 

knex=imread('knex.jpeg');

figure(1)
imshow(knex);
disp(size(knex));
sizek=size(knex)

A=knex(:,1:sizek(2)/2,:);
B=knex(:,sizek(2)/2:end,:);

figure(2)
subplot(1,2,1);
imshow(A);

subplot(1,2,2);
imshow(B);

imwrite(A,"Image_of_knee_A.jpg");
imwrite(B,"Image_of_knee_B.jpg");

Asave=imread("Image_of_knee_A.jpg");
Bsave=imread("Image_of_knee_B.jpg");

figure(3)
subplot(1,2,1);
imshow(Asave);
subplot(1,2,2);
imshow(Bsave);

DiffA=abs(A-Asave);
DiffB=abs(B-Bsave);

disp('MinMax differance in value A:')
disp(max(DiffA,[],'all'))
disp(min(DiffA,[],'all'))

disp('MinMax differance in value B:')
disp(max(DiffB,[],'all'))
disp(min(DiffB,[],'all'))

%% 

figure(4)
gray_img = rgb2gray(knex);
% Perform 2D Fourier transform
ft_img = fft2(gray_img);

% Shift the zero-frequency component to the center
ft_img = fftshift(ft_img);

% Calculate the magnitude spectrum
mag_ft_img = abs(ft_img);

% Plot the original image and its magnitude spectrum side by side
subplot(1, 2, 1);
imshow(gray_img);
title('Original Image');
subplot(1, 2, 2);
imshow(log(1 + mag_ft_img), []);
title('Magnitude Spectrum');


figure(5)
% Define filter parameters
D0 = 21; % Cutoff frequency
n = 4; % Order of Butterworth filter

% Create low-pass filter using Butterworth filter
[M, N] = size(gray_img);
[X, Y] = meshgrid(1:N, 1:M);
D = sqrt((X - N/2).^2 + (Y - M/2).^2);
Hlp = 1 ./ (1 + (D ./ D0).^(2*n));

% Create high-pass filter as the complement of low-pass filter
Hhp = 1 - Hlp;

% Apply the filters to the Fourier transform of the image
ft_img_lp = ft_img .* Hlp;
ft_img_hp = ft_img .* Hhp;

% Shift the Fourier transform back to the original position
ft_img_lp = ifftshift(ft_img_lp);
ft_img_hp = ifftshift(ft_img_hp);

% Perform inverse Fourier transform to obtain the filtered images
img_lp = ifft2(ft_img_lp);
img_hp = ifft2(ft_img_hp);

% Plot the original image and the filtered images side by side

subplot(1, 3, 1);
imshow(gray_img);
title('Original Image');
subplot(1, 3, 2);
imshow(abs(img_lp), []);
title('Low-Pass Filtered Image');
subplot(1, 3, 3);
imshow(abs(img_hp), []);
title('High-Pass Filtered Image');

figure(6)
% Get the size of the image
[rows, cols, channels] = size(knex);

% Create a new image with random RGB values
new_img = randi([0, 255], rows, cols, channels, 'uint8');

% Display the original and new image
subplot(1, 2, 1);
imshow(knex);
title('Original Image');
subplot(1, 2, 2);
imshow(new_img);
title('Randomized Image');

figure(7)
% Convert the image to grayscale
grayImg = rgb2gray(knex);

% Define Sobel filter masks for vertical and horizontal edges
Sx = [-1 0 1; -2 0 2; -1 0 1];
Sy = [-1 -2 -1; 0 0 0; 1 2 1];

% Apply the filters to the image using convolution
Gx = conv2(double(grayImg), double(Sx), 'same');
Gy = conv2(double(grayImg), double(Sy), 'same');

% Compute the magnitude and direction of the edges
edgeMag = sqrt(Gx.^2 + Gy.^2);
edgeDir = atan2d(Gy, Gx);

% Threshold the magnitude of the edges to obtain a binary image
edgeImg = edgeMag > 50;


% Perform morphological operations to enhance edges and remove noise
se = strel('disk', 2);
edgeImg = imdilate(edgeImg, se);
edgeImg = imerode(edgeImg, se);

% Perform image segmentation using Otsu's method
level = graythresh(grayImg);
segmentedImg = imbinarize(grayImg, level);

% Display the results
figure;
subplot(2,2,1), imshow(knex), title('Original Image');
subplot(2,2,2), imshow(grayImg), title('Grayscale Image');
subplot(2,2,3), imshow(edgeImg), title('Edge Detection');
subplot(2,2,4), imshow(segmentedImg), title('Segmented Image');

