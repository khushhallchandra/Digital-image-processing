function [corrupt, out, RMSD] = myPCADenoising2(im )
    
    [x, y] = size(im);
    sigma =20;
    % im1 is the corrupted image
    im1 = im + 20*randn(x,y);
    
    outputImage = double(zeros(x,y));   
    outputMask = double(zeros(x,y));
    pSize = 7;
    neighbour=31;
    for i = 1:x +1-neighbour
        for j = 1:y +1-neighbour
            % 31x31
            subImage = im1(i:i -1+neighbour ,j:j-1+neighbour);
            
            
            % choose top 200 patch
            
            for ii=1:neighbour+1-pSize
                for jj=1:neighbour+1-pSize
                    patch = subImage(ii:ii-1+pSize, jj:jj-1+pSize);
                    
                    P(:, (neighbour+1-pSize)*(ii-1)+jj) = patch(:);
                end                
            end
            N=625;
            % P is 49 X 625 
            % using P we will generate Qi
           [IDX,D] = knnsearch(P',P(:,1)' ,'K',200);
            Qi = P(:,IDX);
            Qit = Qi*Qi';
            [W,T] = eig(Qit);
            alphaIJ = W'*Qi;
            alphaJ  = max(0, ((sum((alphaIJ.^2)'))'/N)-(sigma*sigma));
            alphaDenoised = alphaIJ ./ (1 + (sigma*sigma)./ kron(alphaJ, ones([1 200])));
            denoisedPatch = W*alphaDenoised;
            
            outputImage(i:i+6, j:j+6) = outputImage(i:i+6, j:j+6) + reshape(denoisedPatch(:,1), 7, 7);
            outputMask(i:i+6, j:j+6) = outputMask(i:i+6, j:j+6) + 1;
            
        end        
    end
    corrupt = im1(1:x+1-neighbour,1:y+1-neighbour)/max(max(im1));
    outputImage = outputImage./outputMask;
    out = outputImage(1:x+1-neighbour,1:y+1-neighbour)/max(max(outputImage));

    diffImage = out - im(1:x+1-neighbour,1:y+1-neighbour);
    RMSD = sqrt(sum(sum(diffImage.^2))/(x+1-neighbour)*(1:y+1-neighbour));
  
end