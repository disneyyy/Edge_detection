function [out_Image] = sobel(Image)
% Gx: horizontal edge, Gy: vertical edge
Gx = [-1 -2 -1; 0 0 0; 1 2 1];
Gy = [-1 0 1; -2 0 2; -1 0 1];

% get width and height of image
w = width(Image);
h = height(Image);
out_Image_temp = zeros(size(Image), 'int32');


for i=1:w
    for j=1:h
        % set all pixels on boundary to 0
        if(i==1 || i==w || j==1 || j==h)
            out_Image_temp(j,i)=0;
        else
            X = 0;
            Y = 0;
            for k=-1:1
                % sum Gx*A, Gy*A
                for l=-1:1
                    X = X + Gx(2+k,2+l)*int32(Image(j+k,i+l));
                    Y = Y + Gy(2+k,2+l)*int32(Image(j+k,i+l));
                end
            end
            out_Image_temp(j,i)=abs(X)+abs(Y);
        end
    end
end
Image
% map the generated value to 0~255
Maxi=max(max(out_Image_temp))
Mini=min(min(out_Image_temp))
out_Image=uint8(round(out_Image_temp/(Maxi-Mini)*255));


