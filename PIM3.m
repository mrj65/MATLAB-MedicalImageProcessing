disp("PIM3")
angio=imread('angio.jpg');

figure(1);

imshow(angio);
kernel1=ones(11);
%Normalized kernel -> kernel divided by sum of its elements
%Convert to double to prevent saturation
img1=im2double(imfilter(angio,kernel1/sum(kernel1)));

%Convert back to uint8 to visualise from [0;1] to [0;255]
figure(2);
imshow(im2uint8(img1));


%%
figure(3);
kernel2=[0,0,0;0,1,0;0,0,0];
img2=im2double(imfilter(angio,kernel2/sum(kernel2)));
imshow(im2uint8(img2));
%%
disp("sec4")

kernel3=[-9;1;-9];
kernel4=[-8,-8,-8;7,7,7;-2,-2,-2];

img3=im2double(imfilter(angio,kernel3/sum(kernel3)));
img4=im2double(imfilter(angio,kernel4/sum(kernel4)));

figure(4), subplot(2,1,1),imshow(im2uint8(img3));
figure(4), subplot(2,1,2),imshow(im2uint8(img4));
%%
disp("sec5")
kernel5 = fspecial('average',[3,7])
kernel6 = fspecial('average',[11,11])

img5=im2double(imfilter(angio,kernel5/sum(kernel5)));
img6=im2double(imfilter(angio,kernel6/sum(kernel6)));

figure(5), subplot(3,1,1),imshow(angio),title('Original'),;
figure(5), subplot(3,1,2),imshow(im2uint8(img5)),title('Average Filter 3x7');
figure(5), subplot(3,1,3),imshow(im2uint8(img5)),title('Average Filter 11x11');

%%
% Convert the image to grayscale
gray_image = rgb2gray(angio);

% Apply 5 different filters using fspecial method
filter1 = fspecial('average', [5 5]);
filter2 = fspecial('gaussian', [5 5], 0.5);
filter3 = fspecial('laplacian');
filter4 = fspecial('sobel');
filter5 = fspecial('prewitt');

% Apply each filter to the grayscale image
filtered1 = imfilter(gray_image, filter1);
filtered2 = imfilter(gray_image, filter2);
filtered3 = imfilter(gray_image, filter3);
filtered4 = imfilter(gray_image, filter4);
filtered5 = imfilter(gray_image, filter5);
figure(6)
% Display the original and filtered images
subplot(2, 3, 1), imshow(angio), title('Original Image')
subplot(2, 3, 2), imshow(filtered1), title('Average Filter')
subplot(2, 3, 3), imshow(filtered2), title('Gaussian Filter')
subplot(2, 3, 4), imshow(filtered3), title('Laplacian Filter')
subplot(2, 3, 5), imshow(filtered4), title('Sobel Filter')
subplot(2, 3, 6), imshow(filtered5), title('Prewitt Filter')

%%

% Obtain the negative image using imadjust
negative = imadjust(angio, [0 1], [1 0]);

% Define a 15 x 15 Gaussian filter
filter_size = 15;
filter_sigma = 2;
filter = fspecial('gaussian', [filter_size filter_size], filter_sigma);

% Apply the filter using different padding methods
result_replicate = imfilter(negative, filter, 'replicate');
result_symmetric = imfilter(negative, filter, 'symmetric');
result_circular = imfilter(negative, filter, 'circular');


figure(7);
% Display the results using subplot
subplot(2, 2, 1), imshow(negative), title('Negative Image');
subplot(2, 2, 2), imshow(result_replicate), title('Replicate Padding');
subplot(2, 2, 3), imshow(result_symmetric), title('Symmetric Padding');
subplot(2, 2, 4), imshow(result_circular), title('Circular Padding');

%%

gray_image = rgb2gray(angio);

% Define the sizes of the square masks
filteravg1 = fspecial('average', [3 3]);
filteravg2 = fspecial('average', [9 9]);
filteravg3 = fspecial('average', [25 25]);

result1 = imfilter(negative, filteravg1);
result2 = imfilter(negative, filteravg2);
result3 = imfilter(negative, filteravg3);

subplot(2, 2, 1), imshow(angio), title('Image');
subplot(2, 2, 2), imshow(result1), title('3x3 avg');
subplot(2, 2, 3), imshow(result2), title('9x9 avg');
subplot(2, 2, 4), imshow(result3), title('25x25 avg ');


