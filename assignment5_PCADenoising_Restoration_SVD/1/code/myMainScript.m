%% MyMainScript

tic;
%% Your code here
%% Taking barbara256.png as input image
im = imread('../data/barbara256.png');
figure,imshow(im),colorbar;

%% Calling function myPCADenoising1() 
[corrupt1, out1] = myPCADenoising1(double(im));
%% corrupt image
figure,imshow(corrupt/max(max(corrupt1))),colorbar;
%% output image
figure,imshow(out/max(max(out1))),colorbar;

%% Calling function myPCADenoising2() 

[ corrupt2, out2, rmsd] = myPCADenoising2(double(im));
%% corrupt image
figure,imshow(corrupt2),colorbar;
%% output image
figure,imshow(out2),colorbar;


%% Calling the function myBilateralFiltering
%  As Given in question
sigmaSpace = 1.1;	
sigmaIntensity = 4.0;
gaussNoise = 20*randn([x y]);
corrupt3 = double(im) + gaussNoise;
[ out3 ] = myBilateralFiltering(corrupt3,sigmaSpace, sigmaIntensity);
%% corrupted image
figure,imshow(corrupt3/max(max(corrupt3))),colorbar;
%% output image after bilateral filtering
figure,imshow(out3/max(max(out3))),colorbar;
toc;
