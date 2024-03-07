% Load the image
image = imread('blur2.jpeg');

% Convert the image to grayscale
gray_image = rgb2gray(image);

% Apply edge detection (e.g., using Canny)
edges = edge(gray_image, 'Canny');

% Find contours in the edge-detected image
stats = regionprops(edges, 'BoundingBox', 'Area');

% Determine the largest bounding box (assumed to be the license plate)
[~, index] = max([stats.Area]);
boundingBox = stats(index).BoundingBox;

% Extract and blur the license plate region
x_start = floor(boundingBox(1));
y_start = floor(boundingBox(2));
x_end = x_start + boundingBox(3);
y_end = y_start + boundingBox(4);

% Apply Gaussian blur to the license plate region
sigma = 10; % Adjust the value for the amount of blur
blurred_license_plate = imgaussfilt(image(y_start:y_end, x_start:x_end, :), sigma);

% Replace the original license plate with the blurred license plate
image(y_start:y_end, x_start:x_end, :) = blurred_license_plate;

% Display the image with the redacted license plate
imshow(image);
