disp('PIM Assignment 5')

%% 

P1 = phantom('Shepp-Logan', 128);
P2 = phantom('Modified Shepp-Logan', 128);

P3 = phantom('Shepp-Logan', 256);
P4 = phantom('Modified Shepp-Logan', 256);

P5 = phantom('Shepp-Logan', 512);
P6 = phantom('Modified Shepp-Logan', 512);

P7 = phantom('Shepp-Logan', 1024);
P8 = phantom('Modified Shepp-Logan', 1024);

figure(1)
subplot(2, 4, 1), imshow(P1), title('Shepp-Logan 128x128');
subplot(2, 4, 2), imshow(P2), title('Modified Shepp-Logan 128x128');
subplot(2, 4, 3), imshow(P3), title('Shepp-Logan 256x256') ;
subplot(2, 4, 4), imshow(P4), title('Modified Shepp-Logan 256x256') ;
subplot(2, 4, 5), imshow(P5), title('Shepp-Logan 512x512');
subplot(2, 4, 6), imshow(P6), title('Modified Shepp-Logan 512x512');
subplot(2, 4, 7), imshow(P7), title('Shepp-Logan 1024x1024') ;
subplot(2, 4, 8), imshow(P8), title('Modified Shepp-Logan 1024x1024') ;

%% 

R1 = radon(P2);
R2 = radon(P4);
R3 = radon(P6);
R4 = radon(P8);

subplot(2, 2, 1), imshow(R1,[]), title('Radom transfrom of the Shepp-Logan 128x128');
subplot(2, 2, 2), imshow(R2,[]), title('Radom transfrom of the Shepp-Logan 256x256');
subplot(2, 2, 3), imshow(R3,[]), title('Radom transfrom of the Shepp-Logan 512x512');
subplot(2, 2, 4), imshow(R4,[]), title('Radom transfrom of the Shepp-Logan 1024x1024');

%% 

% Read the image from file:
image = imread('brainCT.jpeg');
figure(2)
R =  radon(image);
subplot(1, 2, 1), imshow(image), title('Original image');
subplot(1, 2, 2), imshow(R), title('Radom transfrom of the original image');

%% 
figure(3)
R1 =  radon(image, 0:0.5:180);
R2 =  radon(image, 0:2:280);
R3 =  radon(image, 0:1:90);

subplot(1, 3, 1), imshow(R1,[]), title('Radon 180 projections and 0.5˚ between projections');
subplot(1, 3, 2), imshow(R2,[]), title('Radon 180 projections and 2˚ between projections');
subplot(1, 3, 3), imshow(R3,[]), title('Radon 90 projections and 1˚ between projections');

%%
