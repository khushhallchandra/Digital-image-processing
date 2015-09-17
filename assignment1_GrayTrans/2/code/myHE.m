function [out1]= myHE(im )
figure,imshow(im),colorbar;
[r c z]=size(im);
freq=zeros(256,z);
prob=zeros(256,z);
cdf=zeros(256,z);
out=zeros(r,c,z);
max1=zeros(1,z);
for i=1:r
    for j=1:c
        for temp=1:z
            if(im(i,j,temp)>max1(1,temp))
                max1(1,temp)=im(i,j,temp);
            end
        end
    end
end
for temp=1:z
    for i=1:r
        for j=1:c
            val=im(i,j,temp);
            freq(val+1,temp)=freq(val+1,temp)+1;
            prob(val+1,temp)=freq(val+1,temp)/(r*c);
        end
    end
    cdf(1,temp)=prob(1,temp);
    for i=2:256
        cdf(i,temp)=cdf(i-1,temp)+prob(i,temp);
    end
    for i=1:r
        for j=1:c
            out(i,j,temp)=round(cdf(im(i,j,temp),temp)*max1(1,temp));
        end
    end
end
out1=uint8(out);
figure, imshow(out1),colorbar;