function myNearestNeighborInterpolation(Img)
figure, imshow(Img),colorbar;
[r c z]=size(Img);
Out=zeros(3*r-2, 2*c-1, z);
for chan=1:z
    for i=1:r-1
        for j=1:c-1
            A=Img(i,j,chan);
            B=Img(i,j+1,chan);
            C=Img(i+1,j,chan);
            D=Img(i+1,j+1,chan);
            
            Out(3*i-2,2*j-1,chan)=A;
            Out(3*i-1,2*j,chan)=A;
            Out(3*i,2*j,chan)=D;
        end
    end
end
Out1=uint8(Out);
figure, imshow(Out1),colorbar;


end

