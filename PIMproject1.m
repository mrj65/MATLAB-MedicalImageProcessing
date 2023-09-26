% Adding noise and converting to grayscale
disp('PIM Challange 1')

choice=input('Chest X-Ray -> 1 \n  Brain MRI -> 2 \n Your choice : ');

% Check if the input is 1 or 2
if choice == 1
    % Read the image from file 1
    image_nonoise=imread('chest_xray_1.jpeg');
    T1=110;
    T2=170;
elseif choice == 2
    % Read the image from file 2
    image_nonoise=imread('brain.jpg');
    T1=70;
    T2=190;
    
else
    % Display an error message and exit
    disp('Wrong input');
    return;
end


disp(size(image))
image= imnoise(image_nonoise,'salt & pepper',0.05);
image_gray=rgb2gray(image);

%%
% Filtering

figure(1)


median_filter = medfilt2(image_gray);
filtered_median2 = medfilt2(median_filter);

filter1 = fspecial('gaussian', [5 5], 0.5);
filtered_gaussian = imfilter(filtered_median2, filter1);

kernel1=ones(3)/9;
filtered_kernel= imfilter(image_gray, kernel1);

subplot(2, 2, 1), imshow(image_gray), title('Original Image');
subplot(2, 2, 2), imshow(filtered_gaussian), title('Gaussian Filter'); 
subplot(2, 2, 3), imshow(filtered_kernel), title('Kernel filter') ;
subplot(2, 2, 4), imshow(filtered_median2), title('Median filtered (2 passes)') ;

image_gray_filtered=filtered_gaussian;
%image_gray_filtered=filtered_median2;
%image_gray_filtered=filtered_gaussian;


figure(2)
filter2 = fspecial('sobel');
filtered_sobel= imfilter(image_gray_filtered, filter2);
imshow(filtered_sobel), title('Sobel filter') ;




%%
%%
%Entropy equalisation

p= image_gray_filtered;
figure(3)
subplot(3,2,1);
imshow (p);
subplot(3,2,2) ;
imhist (p), axis tight,title('Original') ;

eh= histeq (p);
subplot(3,2,3) ;
imshow (eh);
subplot(3,2,4);
imhist (eh), axis tight,title('Entropy histeq');

eh2= adapthisteq (p);
subplot(3,2,5) ;
imshow (eh2);
title('Entropy enhanced image')
subplot(3,2,6);
imhist (eh2), axis tight ,title('Entropy adapthisteq')

%image_gray_filtered_entropy=eh;

figure(4)
image_substract1= filtered_sobel+(eh2-p);
imshow(image_substract1);
title('Image substraction')

image_gray_filtered_entropy=eh2;

%%
%Binarization & substraction

negative = imadjust(image_gray_filtered_entropy, [0 1], [1 0]);
brain_grey=rgb2gray(image);

%Randomized variables
%T1 = randi([1, 110]);
%T2 = randi([145, 255]);

binarized_manually = (image_gray_filtered_entropy > T1) & (image_gray_filtered_entropy < T2);

threshold1=adaptthresh(image_gray_filtered_entropy,0.55,"NeighborhoodSize",[35 25]);

binarized_command = imbinarize(image_gray_filtered_entropy, threshold1);

figure(5);

subplot(1,4,1);
imshow(image_gray_filtered_entropy);
title('Original Image');
subplot(1,4,2);
imshow(binarized_manually)
title(['Binarized manually Image T1:',num2str(T1),' T2=',num2str(T2)]);
subplot(1,4,3);
imshow(binarized_command)
title('Binarized command adaptive Image');

subplot(1,4,4);
imshow((-binarized_command+binarized_manually))
title('Binarized substract');





%%
%2D Fourier magnitude spectrum
disp("2D Fourier magnitude spectrum")
figure(4);
image_fft=fft2(image_gray_filtered_entropy);
image_fft_shift=fftshift(image_fft);
image_magnitude=abs(image_fft_shift);
subplot(1,2,1);
imshow(image_gray_filtered_entropy);
title('Processed Image');
subplot(1,2,2);
imshow(log(1+image_magnitude),[]);
title('2D Fourier- Kspace');

%%
%SNR calcualtion
I = image_gray_filtered_entropy;
meanVal = mean(I(:));
stdDev = std(double(I(:)));
signal = meanVal;
noise = stdDev;
SNR_dB = 20*log10(signal/noise);
fprintf('Signal-to-Noise Ratio (SNR): %.2f dB\n', SNR_dB);

%%
% Kernel testing (embossing)
I = image_gray_filtered_entropy;
kernel=[
    -2 -1  0;
    -1  1  1;
     0  1  2];

I_new=imfilter(I, kernel);
figure;
subplot(1, 2, 1);
imshow(I);
title('Original image');
subplot(1, 2, 2);
imshow(I_new);
title('Image after usage of kernel');


