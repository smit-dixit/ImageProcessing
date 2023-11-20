function C = circle_detection(I, r)

% Convert input RGB image to grayscale
i = rgb2gray(I);

% Apply Canny edge detection to the grayscale image
edg = edge(i, 'canny');

% Display the edge image
imshow(edg)

% Get the size of the edge image
[x, y] = size(edg);

% Define arrays to store the x and y coordinates of the image
x0 = 1:x;
y0 = 1:y;

% Define the range of theta values for the Hough transform
theta = 0:0.01:2*pi;

% Get the number of theta values
num_th = numel(theta);

% Define an accumulator array to store the votes for each possible circle
acc = zeros(size(edg));

% Loop over each edge pixel in the image
for xi = 1:x
    for yj = 1:y
        % Check if the current pixel is an edge pixel
        if edg(xi, yj) == 1
            % Loop over all possible values of theta
            for th_id = 1:num_th
                th = theta(th_id);
                % Calculate the coordinates of the center of the circle
                ai = round(xi - r*cos(th));
                bi = round(yj - r*sin(th));
                % Check if the center coordinates are within the image bounds
                if ai >= 1 && ai <= x && bi >= 1 && bi <= y
                    % Increment the accumulator array at the center coordinates
                    acc(ai, bi) = acc(ai, bi) + 1;
                end
            end
        end
    end
end

% Find the top 3 maximum values in the accumulator array
[A, B] = maxk(acc(:),3);

% Get the x and y coordinates of the center of the detected circle
[a, b] = ind2sub(size(acc), B);

% Display the detected circle on both the edge image and the grayscale image
figure;
subplot(1, 2, 1);
imagesc(edg);
colormap('gray');
hold on;
title('on edged image');
for k=1:3
    plot(y0(b(k)) + r*sin(theta), x0(a(k)) + r*cos(theta), 'r', 'Linewidth', 2);
end
subplot(1, 2, 2);
imagesc(i);
colormap('gray');
hold on;
title('on grayscale image');
for k=1:3
    plot(y0(b(k)) + r*sin(theta), x0(a(k)) + r*cos(theta), 'Linewidth', 2);
end
end
