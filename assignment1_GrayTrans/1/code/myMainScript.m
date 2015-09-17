%% MyMainScript

tic;
%% Your code here
im = imread('../data/circles_concentric.png');
myShrinkImageByFactorD(im,2)
myShrinkImageByFactorD(im,3)
im=imread('../data/barbaraSmall.png');
myBilinearInterpolation(im);
myNearestNeighborInterpolation(im);
toc;

%question b part
