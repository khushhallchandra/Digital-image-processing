function [ output ] = myMeanShiftSegmentation( input_image, hs, hr, th )
input1=input_image;
myfilter = fspecial('gaussian',[5 5], 1);
input1 = imfilter(input1, myfilter, 'replicate');
input1=imresize(input1,[256,256]);
input=input1;
radius_sp=hs;
radius_col=hr;
thresh=th;

I=input;
nbins=40;
H1=zeros([nbins nbins nbins]);
ct=0;
for i=1:size(I,1)
    for j=1:size(I,2)
        p=double(reshape(I(i,j,:),[1 3]));
        p=floor(p/(256/nbins))+1;
        ct=ct+1;
        arr1(ct,:)=[p(1),p(2),p(3)];
        H1(p(1),p(2),p(3))=H1(p(1),p(2),p(3))+1;
        pixels1(ct,:)=[I(i,j,:)];
    end
end
H1=H1(:);
H1=H1./sum(H1);
H_all=reshape(H1,[nbins,nbins,nbins]);

height=size(input,1);
width=size(input,2);
output=input;
disp(['Value of hs =' num2str(hs)]);
disp(['Value of hr =' num2str(hr)]);
disp(['Value of threshold (Note : This will control number of iteration) =' num2str(th)]);
for i=1:size(input,1)
    for j=1:size(input,2)
        p_y=i;
        p_x=j;
        r1 = p_x - radius_sp; 
        r2 = p_x + radius_sp;
        c1 = p_y - radius_sp;
        c2 = p_y + radius_sp;
        if (r1<1) 
            r1 = 1 ;
        end
        if (c1<1) 
            c1 = 1 ; 
        end
        if (r2>height) 
            r2 = height ; 
        end
        if (c2>width) 
            c2 = width ; 
        end
        patch=input(r1:r2,c1:c2,:);
        R=input(p_y,p_x,1); 
        G=input(p_y,p_x,2); 
        B=input(p_y,p_x,3);
        factor=256/nbins;
        bin_r=ceil(double(R)/factor); 
        bin_g=ceil(double(G)/factor); 
        bin_b=ceil(double(B)/factor);
        old_bins=[bin_r bin_g bin_b];
        dist=thresh+1;
        while(dist>thresh)
            hr=min(nbins,(bin_r+radius_col)); lr=max(1,(bin_r-radius_col));
            hg=min(nbins,(bin_g+radius_col)); lg=max(1,(bin_g-radius_col));
            hb=min(nbins,(bin_b+radius_col)); lb=max(1,(bin_b-radius_col));
            s_r=0; s_b=0; s_g=0;
            weight=0;
            for k=lr:hr
                for l=lg:hg
                    for m=lb:hb
                        s_r=s_r+k*H_all(k,l,m);
                        s_g=s_g+l*H_all(k,l,m);
                        s_b=s_b+m*H_all(k,l,m);
                        weight=weight+H_all(k,l,m);
                    end
                end
            end
            s_r=s_r/weight; 
            s_g=s_g/weight; 
            s_b=s_b/weight;
            rd=(s_r-bin_r); 
            gd=(s_g-bin_g);
            bd=(s_b-bin_b);
            dist=sqrt(rd^2+gd^2+bd^2);
            bin_r=round(s_r); 
            bin_g=round(s_g); 
            bin_b=round(s_b);

        end

        color_r=bin_r*(256/nbins);
        color_g=bin_g*(256/nbins);
        color_b=bin_b*(256/nbins);
        output(i,j,1)=color_r;
        output(i,j,2)=color_g;
        output(i,j,3)=color_b;
    end
end
I=output;
ct=0;
for i=1:size(I,1)
    for j=1:size(I,2)
        p=double(reshape(I(i,j,:),[1 3]));
        p=floor(p/(256/nbins))+1;
        ct=ct+1;
        arr2(ct,:)=[p(1),p(2),p(3)];
        pixels2(ct,:)=I(i,j,:);
    end
end

end