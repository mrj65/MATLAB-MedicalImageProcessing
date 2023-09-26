disp('PIM Challenge 2')

disp('The aim of the challenge is to segment the cells of the input image ')

% Read the input image
dots = imread('CELLfind.jpg');

% Convert the image to grayscale
dots_gray = rgb2gray(dots);

% Binarization process by Otsu's method
level = graythresh(dots_gray);
dots_bw = imbinarize(dots_gray, level);

% Creation of the diamond-shaped structuring element with the appropiate
% size for detecting the cells properly
se = strel('disk', 8);

% Definiton of the appropiate threshold
t_binary=88;
dots_t=(dots_gray>t_binary);

% Apply 3 times the erosion and dilation operations
dots_cleaned = dots_t;
% for i = 1:3
%     dots_cleaned = imerode(dots_cleaned, se);
%     dots_cleaned = imdilate(dots_cleaned, se);
% end

dots_cleaned = imerode(dots_cleaned, se);
% We apply this to the image for eliminating the specific image details
% that do not have importance because of the sizes in comparition with the
% cells to be segmented

% Apply morphological algorithms to the cleaned binary image
dots_skeleton = bwmorph(dots_cleaned, 'remove');

% We apply this for a better visualization of the shape of all the cells
% segmented

% Display the original image, the cleaned binary image with the
% thresholding and the final image
subplot(1,3,1), imshow(dots), title('Original image');
subplot(1,3,2), imshow(dots_cleaned), title('Cleaned Binary Image for picked threshold');
subplot(1,3,3), imshow(dots_skeleton), title('Final Image');