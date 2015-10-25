function [ out] = myButterworthFiltering( img,d )
%the filter will be the size of input image
    [rows cols] = size(img);
    cutoff=d;
    n=2;
    Fimg=fftshift(fft2(img));

    % X and Y matrices with ranges normalised to +/- 0.5
    x =  (ones(rows,1) * [1:cols]  - (fix(cols/2)+1))/cols;
    y =  ([1:rows]' * ones(1,cols) - (fix(rows/2)+1))/rows;
    radius = sqrt(x.^2 + y.^2);        % A matrix with every pixel = radius relative to centre.
    H = 1 ./ (1.0 + (radius ./ cutoff).^(2*n));   % The filter
G=H.*Fimg;
G=ifft2(fftshift(G));
g=sqrt(real(G).^2+imag(G).^2);
G = uint8(g); 
out=G;


end
