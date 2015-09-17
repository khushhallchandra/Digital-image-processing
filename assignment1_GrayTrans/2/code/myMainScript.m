%% MyMainScript

tic;
%% Your code here

im = imread('../data/barbara.png');
myLinearContrastStretching(im);
im = imread('../data/TEM.png');
myLinearContrastStretching(im);


im = imread('../data/canyon.png');
myLinearContrastStretching(im);


im = imread('../data/barbara.png');
myHE(im);
im = imread('../data/TEM.png');
myHE(im);

im = imread('../data/canyon.png');
myHE(im);


toc;
