%1) Face detector
%Read the image
A = imread('Group.jpg');

%Get face detector object (its the algorithm used to detect the faces in
%any images)
FaceDetector = vision.CascadeObjectDetector();

%Use face detector object on our image and get the faces
%This will detect the faces, the number of faces, its dimentions & co
%ordinates
bbox = step(FaceDetector,A);

%Annotate the detected faces on top of the image
B = insertObjectAnnotation(A,'rectangle',bbox,'Face');
figure;
imshow(B), title('Detected Faces');

%Dispaly the number of faces in a string
n = size(bbox,1);
str_n = num2str(n);
str = strcat('Number of Detected Faces are = ',str_n);
disp(str);

%2) Object segmentation
%Read the image
A = imread('Group.jpg');

%Gray scale
A_gray = rgb2gray(A);

%Define the mask
mask = zeros(size(A_gray));
mask(10:end-10,10:end-10) = 1;

%Active contour model
B = activecontour(A_gray,mask,1000);

figure;
subplot(1,2,1), imshow(A_gray), title('Gray Scale');
subplot(1,2,2), imshow(B), title('Active Contour');

%3) Vintage filter
%Read an image in double format
A = im2double(imread('Group.jpg'));

%Get input red,green &blue channels
iR=A(:,:,1);
iG=A(:,:,2);
iB=A(:,:,3);

%Get output red,green &blue channels
oR = (iR*.393)+(iG*.769)+(iB*.189)/(.393+.769+.189);
oG = (iR*.349)+(iG*.686)+(iB*.168)/(.349+.686+.168);
oB = (iR*.272)+(iG*.534)+(iB*.131)/(.272+.534+.131);

%Concatenate output channels to get 8 bit output image
A_out = cat(3,oR,oG,oB);
A_out = uint8(255*A_out);

%Show image in  a subplot
figure;
subplot(1,2,1), imshow(A), title('Original Image');
subplot(1,2,2), imshow(A_out), title('Processed Image');
