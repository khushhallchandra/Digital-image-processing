function [ out ]= myBilateralFiltering(Img,sigmaSpace,sigmaIntensity)

winSize=8;
siz = size(Img);
out = zeros(siz);

[x,y] = meshgrid(-winSize:winSize,-winSize:winSize);
spaceG = exp(-(x.^2+y.^2)/(2*sigmaSpace^2));

% Avoide zero padding by reducing the window size at corners.
for i = 1:siz(1)
    iMin = max(i-winSize,1);
    iMax = min(i+winSize,siz(1));
    for j = 1:siz(2)
    jMin = max(j-winSize,1);
    jMax = min(j+winSize,siz(2));
    window = Img(iMin:iMax,jMin:jMax); 
    intensityG = exp(-(window-Img(i,j)).^2/(2*sigmaIntensity^2));
    temp = intensityG.*spaceG((iMin:iMax)-i+winSize+1,(jMin:jMax)-j+winSize+1);
    out(i,j) = sum(temp(:).*window(:))/sum(temp(:));
    end
end
end
