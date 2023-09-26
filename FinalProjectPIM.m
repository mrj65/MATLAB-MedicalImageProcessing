disp('Final Project')

disp('Objective: Identify the glioblastoma mass and calculate its perimeter')

% Read the input image
input = imread('brain_2.jpg');


% Normalize the image to the range [0, 1]
normalized_image = im2double(input);

% Set the gamma value
gamma = 3.0; % Adjust this value as needed

% Apply gamma correction
corrected_image = normalized_image .^ gamma;

% Scale the image back to the range [0, 255]
corrected_image = uint8(corrected_image * 255);

% Display the original and corrected images
figure(1);
subplot(1, 2, 1);
imshow(input);
title('Original Image');

subplot(1, 2, 2);
imshow(corrected_image);
title('Gamma Corrected Image');

%corrected_image=rgb2gray(corrected_image);

%%
disp('Histogram /Thresholding / segmentation / morphorogical');

figure(2)
subplot(2,2,1);
imshow (input);
subplot(2,2,2) ;
imhist (input), axis tight,title('Original') ;


subplot(2,2,3) ;
imshow (corrected_image);
subplot(2,2,4);
imhist (corrected_image), axis tight,title('GAMMA histeq');



%%
disp('Thresholding / segmentation');

figure(3);
T1=75;
T2=115;
binarized_manually = (corrected_image > T1) & (corrected_image < T2);
%binarized_manually2=(corrected_image>90) & (corrected_image<96)  ;
%binarized_manually1=binarized_manually1-binarized_manually2;

subplot(1, 3, 1);
imshow(corrected_image);
title('Gamma Corrected Image');

subplot(1, 3, 2);
imshow(binarized_manually)
title(['Binarized manually Image T1:',num2str(T1),' T2=',num2str(T2)]);

subplot(1, 3, 3);
[labeled1, ~] = bwlabel(binarized_manually, 8);
ARTlabel = label2rgb (labeled1, 'hsv', 'k', 'shuffle');
imshow(ARTlabel)
title('ART');


%%
binaryImage = bwareaopen(binarized_manually, 3800);
binaryImage = imfill(binaryImage, 'holes');


se = strel('disk', 21);
 morphedImage = imclose(binaryImage, se);
 morphedImage = imopen(morphedImage, se);

% for i = 1:3
%     morphedImage = imclose(binaryImage, se);
%     morphedImage = imopen(morphedImage, se);
% end


figure(4)
[labeledImage, numberOfBlobs] = bwlabel(morphedImage, 8);


labeledImageRGB = label2rgb (labeledImage, 'hsv', 'k', 'shuffle');
imshow(labeledImageRGB);
subplot(1, 2, 1);
imshow(corrected_image);
title('Gamma Corrected Image');

subplot(1, 2, 2);
imshow(labeledImageRGB);
title('Labeled image');

%%
figure(5)

overlayImage = imfuse(input, labeledImageRGB);
imshow(overlayImage);
title('Segmentation Overlay');

%%
%figure(6)
% Calculate the area of each labeled region
regionProps = regionprops(labeledImage, 'Area');

% Extract the areas from the region properties structure
areas = [regionProps.Area];

% Total area of all labeled regions
totalArea = sum(areas);

% Display the total area
disp(['Total area: ', num2str(totalArea)]);
