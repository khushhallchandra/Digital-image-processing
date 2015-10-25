function [corrupt out ] = myPCADenoising1(im )
    %% Processing barbara256.png
    [x, y] = size(im);
    pSize = 7; 
    sigma=20;
    N = (x+1-pSize)*(y+1-pSize);
    gaussNoise = sigma*randn(size(im));
    corrupt = im + gaussNoise;

    P = zeros([pSize*pSize N]);

    for i=1:x+1-pSize
        for j=1:y+1-pSize
            patch = corrupt(i:i-1+pSize, j:j-1+pSize);
            P(:, (y+1-pSize)*(i-1)+j) = patch(:);
        end
    end
    Pt = P*P';
    [W,T] = eig(Pt);
    alphaIJ = W'*P;
    alphaJ  = max(0, ((sum((alphaIJ.^2)'))'/N)-(sigma*sigma));
    alphaDenoised = alphaIJ ./ (1 + (sigma*sigma)./ kron(alphaJ, ones([1 N])));
    denoisedPatches = W*alphaDenoised;
 
    out = double(zeros(x, y));
    %% factor takes care of dividing the particular element of matrix so that
    %% to average out the effect of patch
    factor = double(zeros(x, y));

    for i=1:x-pSize+1
        for j=1:y-pSize+1
            out(i:i+pSize-1, j:j+pSize-1) = out(i:i+pSize-1, j:j+pSize-1) + reshape(denoisedPatches(:, (y+1-pSize)*(i-1)+j), pSize, pSize);
            factor(i:i+pSize-1, j:j+pSize-1) = factor(i:i+pSize-1, j:j+pSize-1) + 1;
        end
    end
    out = out./factor;
end

