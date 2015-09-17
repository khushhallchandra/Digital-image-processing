
function [ out ] = myPatchBasedFiltering(Img,sig )
% I did this problem after discussing with my friend
% Implemented the common idea 
%% Use 9 × 9 patches. Use a Gaussian, or clipped Gaussian, weight function
%% on on the patches to make the patch more isotropic (as compared to a
%% square patch). Note: this will imply neighbor-location-weighted distances
%% between patches. For filtering pixel “p”, use patches centered at pixels “q”
%% that lie within a window of size approximately 25 × 25 around “p”.

%% Window of size approximately 25 × 25 around “p”.
winSize = 25;

%% Use 9 × 9 patches
patchSize = 9;

siz = size(Img);
out = zeros(siz);

%% here we didn't use zero padding since it was increasing the image size
%% and thus run time. Instead on the corners we decreased the window size
%% and patch size as required.
for i = 1:siz(1)
    iMin = max(i-winSize,1);
    iMax = min(i+winSize,siz(1));
    for j = 1:siz(2)
        %% Here we are choosing a window corresponding to the winSize
        jMin = max(j-winSize,1);
        jMax = min(j+winSize,siz(2));
        window = Img(iMin:iMax,jMin:jMax);               
        winSize  = size(window);
        
        %% Now we will choose the patch centered at (i,j). This patch lies
        %% at the center of the window(i,j). This acts as our main patch
        %% and with reference to this patch we will calculate the weight of
        %% others pixels present in the window(i,j)
        mainPatchiMin = max(i-patchSize,1);
        mainPatchiMax = min(i+patchSize,siz(1));
        mainPatchjMin = max(j-patchSize,1);
        mainPatchjMax = min(j+patchSize,siz(2));
        mainPatch = Img(mainPatchiMin:mainPatchiMax,mainPatchjMin:mainPatchjMax);
        mainPatchSize = size(mainPatch);

        w = zeros(winSize);
        %% Now we have to find the weight of each pixel in the given window
        % so we will need 2 for loop to find the weight
        for k = 1:winSize(1)
            patchkMin = max(k-patchSize,1);
		    patchkMax = min(k+patchSize,winSize(1));
        	for l = 1:winSize(2)
            patchlMin = max(l-patchSize,1);
            patchlMax = min(l+patchSize,winSize(2));
            patch = window(patchkMin:patchkMax,patchlMin:patchlMax);
            patchSize = size(patch);

            %% Finding the difference between the patches
            %% Note: if the reference patch is same as this patch then
            %% simply take the difference otherwise we have to see the
            %% two patches are of same dimension as 
            %% THEY MAY DIFFER IN THE CORNER

            if (patchSize(1)==mainPatchSize(1) && patchSize(2)==mainPatchSize(2) )
                d = mainPatch - patch;                    
            else                    
                patch = patch(1:min(patchSize(1),mainPatchSize(1)),1:min(patchSize(2),mainPatchSize(2)));               
                d = mainPatch(1:min(patchSize(1),mainPatchSize(1)),1:min(patchSize(2),mainPatchSize(2))) - patch;         

            end
            w(k,l) = sum(sum(d.^2))/(size(d,1)*size(d,2));
        	end
        end
        %After this point we will the gaussian of the weight                
        % applying gaussian over the difference of the patches
        %% Also we will find the value of (i,j) point after applying the filtering
        %% Weights = Gaussian on patch distance
        g = exp(-(w)/(sig^2));      
        winWeight = g/(sum(sum(g)));
        out(i,j) = sum(sum(winWeight.*window));

    end
end

end



