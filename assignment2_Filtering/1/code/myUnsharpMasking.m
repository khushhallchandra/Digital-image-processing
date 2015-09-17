function [out]= myUnsharpMasking(Img,hsize,sigma,factor)
%fspecial('gaussian', hsize, sigma) returns a rotationally symmetric
%Gaussian lowpass filter of size hsize with standard deviation sigma (positive)
f=fspecial('gaussian',hsize,sigma); 
convolved=imfilter(Img,f,'conv'); 
unSharp = Img-convolved;
out = Img+factor*unSharp;
end