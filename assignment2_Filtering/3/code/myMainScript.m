%% MyMainScript
tic;

%% Adding noise to the original image
im = load('../data/barbara.mat');

%% If you think your code takes too long to %run, (i) resize the image by
%% subsampling by a factor of 2 along each dimension, after applying a 
%% Gaussian blur of standard deviation around 0.66 pixel width and (ii) 
%% apply the filter to the resized image.
factor=2;
img1=im.imageOrig;
img = img1(1:factor:end,1:factor:end);

%% Adding gaussion noise to image 
[ x,y ] = size(img);
%randn() gives random numbers drawn independently from 
% a Gaussian with mean 0 and standard deviation 1.
intensityRange = max(max(img)) - min(min(img));
corrupt = img + 0.05*intensityRange*randn([x y]);
% The idea of not doing zero padding I learnt from my friend
% Here we are directly putting the value of Standard deviation ="3.5"
% Other value can also be given in the similar fashion
%% Called myPatchBasedFiltering
out = myPatchBasedFiltering(corrupt,3.5);
%% The next module is for displaying the result	
iptsetpref('ImshowAxesVisible','on');
figure('units','normalized','outerposition',[0 0 1 1])
mainFig= subplot(1,3,1);
imshow(mat2gray(img)), colorbar;
title('Input Image')
subplot(1,3,2);
imshow(mat2gray(corrupt)), colorbar;
title('Image with noise')
subplot(1,3,3);
imshow(mat2gray(out)), colorbar;
title('Output Image')

diffOfImage = out - img;
RMSD = sqrt(sum(sum(diffOfImage.^2))/(x*y));
disp(RMSD);

name = '../images/output';
file_name = strcat([name '.png']);
imwrite(mat2gray(filteredImage),file_name);

toc;
