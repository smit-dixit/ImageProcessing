function L= line_detection(I)
% This function detects straight lines in an input RGB image using the Hough transform.
% The function takes an RGB image 'I' as input and returns nothing.

% Convert the input RGB image to grayscale
i=rgb2gray(I);

% Apply the Canny edge detection algorithm to the grayscale image to obtain an edge map
edg=edge(i,'canny');

% Define the range of parameter values for the Hough transform
% The range of rho values is determined by the size of the edge map
[x,y]=size(edg);
rho_limit=norm([x y]);
rho = (-rho_limit:1:rho_limit);
% The range of theta values is set to be from 0 to pi in steps of 0.01 radians
theta=0:0.01:pi;

% Create an accumulator matrix with the same dimensions as the parameter range
% For each edge pixel in the edge map, compute the corresponding Hough parameter values (rho and theta) 
% and increment the corresponding entry in the accumulator matrix.
num_th=numel(theta);
num_rho = numel(rho);
acc=zeros(num_rho,num_th);
for xi= 1:x
    for yj= 1:y
        if edg(xi,yj)==1
            for th_id= 1:num_th
                th=theta(th_id);
                r=xi*cos(th) + yj*sin(th);
                rho_id=round(r+num_rho/2);
                acc(rho_id,th_id)=acc(rho_id,th_id)+1;
            end
        end
    end
end

% Find the maximum value in the accumulator matrix and its corresponding indices in the parameter range
[A,B] = max(acc(:));
[a,b]=ind2sub(size(acc),B);

% Plot the accumulator matrix as an image and overlay the detected line in red
figure(1);
imagesc(theta,rho,acc);
colormap('gray');
hold on;
title('Hough transform'); xlabel('Theta(rad)'); ylabel('Rho(pixels)')
plot(theta(b),rho(a),'*','Linewidth',4);
hold off;

% Convert the detected Hough parameters (theta and rho) to the equation of a line in slope-intercept form (y = mx + b)
max_theta=theta(b);
max_rho=rho(a);
slope_m= -(cos(max_theta)/sin(max_theta));
m=slope_m;
intercept_b= max_rho/sin(max_theta);
b=intercept_b;

% Generate the x and y coordinates of the detected line using the slope-intercept form
x=1:x;
y= m*x+b;

% Plot the detected line on both the edge map and the grayscale image
figure(2);
subplot(1,2,1);
imagesc(edg);
colormap('gray');
hold on;
title('On Edged image');
plot(y,x,'g','LineWidth',2)
subplot(1,2,2);
imagesc(i);
hold on;
title('On Grayscale image');
plot(y,x,'LineWidth',2);
end
