function [ Ix2, Iy2] =  myHarrisCornerDetector(im, sigma,k)
 %% Image Drivative
 dx = [-1 0 1; -1 0 1; -1 0 1]; % Derivative masks
 dy = dx';
 Ix = conv2(im, dx, 'same'); % Image derivatives
 Iy = conv2(im, dy, 'same');
 % Generate Gaussian filter of size 6
 g = fspecial('gaussian',[6 6], sigma);
 disp(['Optimal value of sigma of weight gaussian for x and y derivative =' num2str(sigma)]);
 % Smoothed squared image derivatives
 Ix2 = conv2(Ix.^2, g, 'same'); 
 Iy2 = conv2(Iy.^2, g, 'same');
 Ixy = conv2(Ix.*Iy, g, 'same');
 %% Corner measure
 [row col]=size(im);
 %   R = zeros(r, c);
 eigen1 = zeros(row, col); 
 eigen2 = zeros(row, col);
 cim = zeros(row, col);
 % Consider a window of 3x3 matrix 
 %for calculating the matrix A
 for i=2:row-1 
     for j=2:col-1
         Ix2s=sum(sum(Ix2(i-1:i+1,j-1:j+1)));
         Iy2s=sum(sum(Iy2(i-1:i+1,j-1:j+1)));
         IxIys= sum(sum(Ixy(i-1:i+1,j-1:j+1)));
         %Calculating matrix A
         A=[Ix2s, IxIys; IxIys, Iy2s];
         eValue = eig(A);
         eigen1(i,j)=max(eValue);
         eigen2(i,j)=min(eValue);
		 d = det(A);
         t = trace(A);
         cim(i,j) = d - (k*t*t);		
     end
 end
 cim = (cim>0.9)*256;
 %% Display Images
 figure, imshow(mat2gray(eigen1)),colorbar;
 name = strcat(['../images/output' 'eigen1']);
 file_name = strcat([name '.png']);
 imwrite(eigen1,file_name);
 title('Eigen 1');
 
 figure, imshow(mat2gray(eigen2)),colorbar;
 name = strcat(['../images/output' 'eigen2']);
 file_name = strcat([name '.png']);
 imwrite(eigen2,file_name);
 title('Eigen 2');
 
 figure, imshow(mat2gray(cim)),colorbar;
 name = strcat(['../images/output' 'Corner']);
 file_name = strcat([name '.png']);
 imwrite(cim,file_name);
 title('Corner detected image');
 %% Optimal value of k
 disp(['Optimal value of k (please note that k is normalized) =' num2str(k)]);
end