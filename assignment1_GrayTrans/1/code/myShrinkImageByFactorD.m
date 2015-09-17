function myShrinkImageByFactorD(Img,factor)
figure,imshow(Img),colorbar;
[x,y] = size(Img);
out = Img(1:factor:end,1:factor:end);
[a b] = size(out);
figure,imshow(out),colorbar;

end