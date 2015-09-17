function [out1]= myCLAHE(Img, windowsize, thresh)
figure,imshow(Img);
[rows1 cols1 chans]=size(Img);
%pixels=zeros(256,z);
freq=zeros(256,chans);
prob=zeros(256,chans);
cdf=zeros(256,chans);
out=zeros(rows1,cols1,chans);
max1=zeros(1,chans);
for i=1:rows1
    for j=1:cols1
        for k=1:chans
            if(Img(i,j,k)>max1(1,k))
                max1(1,k)=Img(i,j,k);
            end
        end
    end
end
padr=rows1+(floor((windowsize(1)-1)/2)*2);
padc=cols1+(floor((windowsize(2)-1)/2)*2);
padm=zeros(padr,padc,chans);
for temp=1:chans
    
    for i=floor((windowsize(1)-1)/2)+1:padr-floor((windowsize(1)-1)/2)
        for j=floor((windowsize(2)-1)/2)+1:padc-floor((windowsize(2)-1)/2)
            padm(i,j,temp)=Img(i-floor((windowsize(2)-1)/2),j-floor((windowsize(2)-1)/2),temp);
        end
    end

    for row1=1:rows1
        for col1=1:cols1
            if((row1<padr-(floor((windowsize(1)-1)/2)*2)) && (col1<padc-(floor((windowsize(2)-1)/2)*2)))
                for r11=1:256
                    freq(r11,temp)=0;
                    prob(r11,temp)=0;
                    cdf(r11,temp)=0;
                end
                sum=0;
                for i=row1:row1+windowsize(1)-1
                    for j=col1:col1+windowsize(2)-1
                        
                        val=padm(i,j,temp);
                        freq(val+1,temp)=freq(val+1,temp)+1;
                        prob(val+1,temp)=freq(val+1,temp)/(windowsize(1)*windowsize(2));
                        if(prob(val+1,temp)>thresh)
                            sum=sum+prob(val+1,temp);
                        end
                    end
                end
                avg=sum/256;
                for i=row1:row1+windowsize(1)-1
                    for j=col1:col1+windowsize(2)-1
                        val=padm(i,j,temp);
                        prob(val+1,temp)=prob(val+1,temp)+avg;
                    end
                end
                cdf(1,temp)=prob(1,temp);
                for i=2:256
                    cdf(i,temp)=cdf(i-1,temp)+prob(i,temp);
                end
                %midx=floor((windowsize(1)+1)/2);
                %midy=floor((windowsize(2)+1)/2);
                %Img(row1,col1,temp);
                out(row1,col1,temp)=floor(cdf(Img(row1,col1,temp)+1,temp)*max1(1,temp));
                
            end
        end
    end
    
end
out1=uint8(out);
figure, imshow(out1), colorbar;


