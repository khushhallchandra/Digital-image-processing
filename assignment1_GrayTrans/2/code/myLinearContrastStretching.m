function myLinearContrastStretching(im)
%[x,y]=size(im)

[r c z]=size(im);

if(z==3)
i = im(:,:,1);
rowtemp = min(i);              
rowmin = min(rowtemp);         
rowtemp = max(i);              
rowmax = max(rowtemp);         
m = 255/(rowmax - rowmin);     
c = 255 - m*rowmax;            
iTransformed(:,:,1) = m*i + c; 

i = im(:,:,2);
rowtemp = min(i);              
rowmin = min(rowtemp);         
rowtemp = max(i);              
rowmax = max(rowtemp);         
m = 255/(rowmax - rowmin);     
c = 255 - m*rowmax;            
iTransformed(:,:,2) = m*i + c; 

i = im(:,:,3);
rowtemp = min(i);             
rowmin = min(rowtemp);        
rowtemp = max(i);             
rowmax = max(rowtemp);        
m = 255/(rowmax - rowmin);    
c = 255 - m*rowmax;           
iTransformed(:,:,3) = m*i + c;

elseif(z==1)
i = im(:,:,1);
rowtemp = min(i);             
rowmin = min(rowtemp);        
rowtemp = max(i);             
rowmax = max(rowtemp);         
m = 255/(rowmax - rowmin);    
c = 255 - m*rowmax;            
iTransformed(:,:,1) = m*i + c;     
end

figure,imshow(im),colorbar;            
figure,imshow(iTransformed),colorbar;  

end