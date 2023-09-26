disp("PIM3.2")
ct_head=imread('ct_head.jpg');

% Apply different filters using fspecial method
filter1 = fspecial('average', [5 5]);
filter2 = fspecial('gaussian', [5 5], 0.5);
filter3 = fspecial('laplacian');
filter4 = fspecial('sobel');
filter5 = fspecial('prewitt');

% Apply each filter to the ct_head image
filtered1 = imfilter(ct_head, filter1);
filtered2 = imfilter(ct_head, filter2);
filtered3 = imfilter(ct_head, filter3);
filtered4 = imfilter(ct_head, filter4);
filtered5 = imfilter(ct_head, filter5);
figure(1)

% Display the original and filtered images
subplot(2, 3, 1), imshow(ct_head), title('Original Image')
subplot(2, 3, 2), imshow(filtered1), title('Average Filter') %%low-pass filter
subplot(2, 3, 3), imshow(filtered2), title('Gaussian Filter') %%low-pass filter
subplot(2, 3, 4), imshow(filtered3), title('Laplacian Filter') %%high-pass filter
subplot(2, 3, 5), imshow(filtered4), title('Sobel Filter') %%high-pass filter
subplot(2, 3, 6), imshow(filtered5), title('Prewitt Filter') %%high-pass filter

%% 

filtered_trans = imfilter(ct_head,transpose(filter4) );

figure(2)
subplot(1, 2, 1), imshow(filtered4), title('Sobel Filter')  
subplot(1, 2, 2), imshow(filtered_trans), title('Sobel Filter transposed')

%% 

im = im2double(filtered4);
im2 = im2double(filtered_trans);

result_image = sqrt(pow2(im)+pow2(im2));

figure(3)
imshow(normalize(result_image)), title('Combined image')

%%

xray=imread('xray_chest.jpg');
k1=0.5;
k2=0.2;
k3=2;
kernel1 = fspecial('average',[3,3])*k1;
kernel2 = fspecial('average',[3,3])*k2;
kernel3 = fspecial('average',[3,3])*k3;
kernel4 = fspecial('gaussian', [5 5], 0.5);

filtered1 = imfilter(xray, kernel1);
filtered2 = imfilter(xray, kernel2);
filtered3 = imfilter(xray, kernel3);
filtered4 = imfilter(xray, kernel4);

figure(4)
subplot(2,2,1),imshow(normalize(im2double(filtered1))), title('Average filter k=0.5')
subplot(2,2,2),imshow(normalize(im2double(filtered2))), title('Average filter k=0.2')
subplot(2,2,3),imshow(normalize(im2double(filtered3))), title('Average filter k=2')
subplot(2,2,4),imshow(normalize(im2double(filtered4))), title('Gaussian Filter')

%%
z=8;
z1=12;
z2=30;
filter_hb = 1/9*[-1,-1,-1;-1,z,-1;-1,-1,-1];
filter_hb1 = 1/9*[-1,-1,-1;-1,z1,-1;-1,-1,-1];
filter_hb2 = 1/9*[-1,-1,-1;-1,z2,-1;-1,-1,-1];

img=im2double(imfilter(xray,filter_hb/sum(filter_hb)));
img1=im2double(imfilter(xray,filter_hb1/sum(filter_hb1)));
img2=im2double(imfilter(xray,filter_hb2/sum(filter_hb2)));

figure(5)
subplot(1,3,1), imshow(img), title('high boss filter z=8')
subplot(1,3,2), imshow(img1), title('high boss filter z=12')
subplot(1,3,3), imshow(img2), title('high boss filter z=30')

%%

im = imread('blood.tif');

noise1 = imnoise(im,'salt & pepper');
noise2 = imnoise(im,'gaussian');
noise3 = imnoise(im,'speckle');

figure(6)
subplot(1,3,1), imshow(noise1), title('salt & pepper noise')
subplot(1,3,2), imshow(noise2), title('gaussian noise')
subplot(1,3,3), imshow(noise3), title('speckle noise')

%%

sp1= imnoise(im,'salt & pepper',0.02);
sp2= imnoise(im,'salt & pepper',0.05);
sp3= imnoise(im,'salt & pepper',0.1);
sp4= imnoise(im,'salt & pepper',0.2);

figure(7)
subplot(2,2,1), imshow(sp1), title('salt & pepper noise density d=0.02 ')
subplot(2,2,2), imshow(sp2), title('salt & pepper noise density d=0.05')
subplot(2,2,3), imshow(sp3), title('salt & pepper noise density d=0.1')
subplot(2,2,4), imshow(sp4), title('salt & pepper noise density d=0.2')

%%

g1= imnoise(im,'gaussian',0.02);
g2= imnoise(im,'gaussian',0.05);
g3= imnoise(im,'gaussian',0.1);
g4= imnoise(im,'gaussian',0.5);

figure(8)
subplot(2,2,1), imshow(g1), title('gaussian noise with variance 0.02 ')
subplot(2,2,2), imshow(g2), title('gaussian noise with variance 0.05')
subplot(2,2,3), imshow(g3), title('gaussian noise with variance 0.1')
subplot(2,2,4), imshow(g4), title('gaussian noise with variance 0.5')

%%

sp = imnoise(im,'salt & pepper',0.2);

filter1 = fspecial('average', [5 5]);
filter2 = fspecial('gaussian', [5 5], 0.5);
median_filter = medfilt2(sp);

filtered1 = imfilter(sp, filter1);
filtered2 = imfilter(sp, filter2);

figure(9)
subplot(2,2,1), imshow(sp), title('salt & pepper noise 20%')
subplot(2,2,2), imshow(filtered1), title('Average low-pass filter')
subplot(2,2,3), imshow(filtered2), title('Gaussian low-pass filter')
subplot(2,2,4), imshow(median_filter), title('Median-pass filter')

%%

median_filter = medfilt2(sp);
median2_filter = medfilt2(median_filter);

figure(10)
subplot(1,3,1), imshow(sp), title('salt & pepper noise')
subplot(1,3,2), imshow(median_filter), title('One pass median filter')
subplot(1,3,3), imshow(median2_filter), title('Two passes median filter')

%% 

k=0.5;
kernel = fspecial('average',[3,3])*k1;
filter = imfilter(median2_filter,kernel);

figure(11)
subplot(1,3,1), imshow(sp), title('salt & pepper noise')
subplot(1,3,2), imshow(median2_filter), title('Two passes median filter')
subplot(1,3,3), imshow(filter), title('Two passes median filter with unsharp masking')

%%

k1=0.5;
k2=0.2;
k3=2;
kernel1 = fspecial('average',[3,3])*k1;
kernel2 = fspecial('average',[3,3])*k2;
kernel3 = fspecial('average',[3,3])*k3;

filter1 = imfilter(median_filter,kernel);
filter2 = imfilter(median_filter,kernel2);
filter3 = imfilter(median_filter,kernel3);

figure(12)
subplot(1,3,1), imshow(filter1), title('salt & pepper noise with density 0.5')
subplot(1,3,2), imshow(filter2), title('salt & pepper noise with density 0.2')
subplot(1,3,3), imshow(filter3), title('salt & pepper noise with density 2')