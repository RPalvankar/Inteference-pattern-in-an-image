Inputimage=imread('C:\Users\ritvikpalvankar7\Desktop\Image Processing homework\HW 4\interfere.pgm');
Inputimage=double(Inputimage);
[s1,s2]=size(Inputimage); %Storing the dimensions of the image in variables s1 and s2 respectively
Fourier=fft2(Inputimage); %Finding the fourier transform of the input image.
Shift=fftshift(Fourier); %Centering the fft
Absolutevalue=log(abs(Shift)); %Calculating the absolute value (if X=A+Bi, then abs(X)=(((A)^2+(B)^2)^0.5)
figure;
plot(Absolutevalue);%Plotting the magnitude.
title('Absolute value');
maxval=max(max(Absolutevalue)); %Calculating the maximum value of the abolute value 
ref=4; %Setting a reference value

for i=1:s1-1 %Varying the variable 'i' from 1 to s1-1 for calculating the range where the out of place frequencies are placed.
    for j=1:s2 %Varying the variable 'j' from 1 to s2 for calculating the range along the y axis to calculate the peak value of the out of place frequency
        V1=Absolutevalue(i,j); %Peak1
        V2=Absolutevalue(i+1,j); %Peak2
        if(abs(V1-V2)>ref) %Setting a reference (4 in this case) to check the difference between the neighboring values of the out of place frequency and then calculating the absolute value. 
            Shift(i,j)=Shift(i,j-1); %Assigning the neighboring values
            Absolutevalue(i,j)=Absolutevalue(i,j-1); %Assigning the neighboring values
        end 
    end
end
figure,plot(Absolutevalue); 
title('Corrected absolute value');
Outputimage=abs(ifft2(Shift)); %Calculating the inverse fourier transform and then calculating the absolute value
%Displaying the input and the output images
figure,imshow(uint8(Inputimage));
title('Input image');
figure,imshow(uint8(Outputimage));
title('Output image');
