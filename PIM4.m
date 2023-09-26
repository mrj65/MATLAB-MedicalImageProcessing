hand=imread('hand.jpg');
disp('Segmantation')
figure(1);

bw1=im2bw(hand,0.48);

hand_grey=rgb2gray(hand);
bw2 = imbinarize(hand_grey);
%imshow(bw1);

subplot(1,2,1);
imshow(bw1);
title('im2bw 0.29');
subplot(1,2,2);
imshow(bw2);
title('Imbinarize / Otsu');

%%
figure(2)
disp('Segmantation 2')
threshold=graythresh(hand_grey);
bw3 = imbinarize(hand_grey,threshold);

subplot(1,2,1);
imshow(hand_grey>110);
title('T110');
subplot(1,2,2);
imshow(bw3);
title('Otsu')
%%
disp('double thresholding')
figure(3)

T1=70;
T2=145;
binarized = (hand_grey > T1) & (hand_grey < T2);
imshow(binarized)
%%
figure(18)
edge_image = edge(hand_grey, 'Canny');

% Display the input image and the edge-detected image side by side
imshowpair(hand_grey, edge_image, 'montage');
title('Input Image (Left) and Edge-Detected Image (Right)');




