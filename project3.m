% hostogram-equalized
Image = imread("Histogram+Edge.bmp"); % read picture
Image = rgb2gray(Image); % turn to gray picture
w = width(Image);
h = height(Image);


% accumulate histogram
x = zeros(256);
for i=1:w
    for j=1:h
        x(Image(j,i)+1,1) = x(Image(j,i)+1,1)+1;
    end
end

% get sum
base = sum(x); 

% calculate original PDF
pdf = x/base;

% get CDF by integral
cdf = pdf;
for i =2:256
    cdf(i,1) = cdf(i-1,1) + cdf(i,1);
end
for i =1:256
    cdf(i,1) = round(cdf(i,1)*255);
end

% generate histogram equalized picture and histogram
x2 = zeros(256);
Image_eq = Image;
for i=1:w
    for j=1:h
        num = Image(j,i);
        if num==0
            num = 1;
        end
        Image_eq(j,i)=cdf(num,1); % transform to histogram equalized picture
        x2(Image_eq(j,i)+1,1) = x2(Image_eq(j,i)+1,1)+1; % calculate new pdf
    end
end

% get sum
base = sum(x2); 

% get new PDF
pdf2 = x2/base; 

% plot PDF comparison
f=figure;
subplot(1,2,1)
bar(pdf/255)
title('Original Histogram')
subplot(1,2,2)
bar(pdf2/255)
title('Histogram After Histogram Equalization')
exportgraphics(f,'Histogram_Comparison.png','Resolution',300)

% output histogram equalized image
f=figure
imshow(Image_eq)
exportgraphics(f,'Picture_Histogram_Equalization.png','Resolution',300)

% plot pictures comparison
f=figure
subplot(1,2,1)
imshow(Image)
title('Before')
subplot(1,2,2)
imshow(Image_eq)
title('After')
exportgraphics(f,'Picture_Comparison.png','Resolution',300)


% edge detection sobel
out_Image=sobel(Image);
f=figure
imshow(out_Image)
exportgraphics(f,'Edge_Detection.png','Resolution',300)

% impementation on picture that is histogram equalized
out_Image_eq=sobel(Image_eq)
f=figure
imshow(out_Image_eq)
exportgraphics(f,'Edge_Detection_eq.png','Resolution',300)

% output comparison
f=figure
subplot(2,1,1)
imshow(out_Image)
title('Edge Detection on Original Picture')
subplot(2,1,2)
imshow(out_Image_eq)
title('Edge Detection on Histogram Equalized Picture')
exportgraphics(f,'Edge_Detection_Comparison.png','Resolution',300)