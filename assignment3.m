%% Assignment 3 - Digital Image Processing using MATLAB
% Landsat TM Image Processing for Coastal Region

% Clear workspace
clear ;
close all;
clc;  

%% Load all 7 bands
% Note: Replace 'band1.tif' with actual filenames from your ZIP file
fprintf('Loading Landsat TM bands...\n');

band1 = imread('band1.jpg'); % Blue (0.45-0.52 um)
band2 = imread('band2.jpg'); % Green (0.52-0.60 um)
band3 = imread('band3.jpg'); % Red (0.63-0.69 um)
band4 = imread('band4.jpg'); % Near-Infrared (0.76-0.90 um)
band5 = imread('band5.jpg'); % Mid-Infrared (1.55-1.75 um)
band6 = imread('band6.jpg'); % Thermal-Infrared (10.4-12.5 um)
band7 = imread('band7.jpg'); % Mid-Infrared (2.08-2.35 um)

% Convert to double for calculations
band1_d = double(band1);
band2_d = double(band2);
band3_d = double(band3);
band4_d = double(band4);
band5_d = double(band5);
band6_d = double(band6);
band7_d = double(band7);

%% Convert to double
% bands = {(band1_d), (band2_d), (band3_d), (band4_d), (band5_d), (band6_d), (band7_d)};
% band_names = {'Band 1 (Blue)', 'Band 2 (Green)', 'Band 3 (Red)', ...
%               'Band 4 (NIR)', 'Band 5 (MIR1)', 'Band 6 (TIR)', 'Band 7 (MIR2)'};
% 
% figure('Position',[200 100 1200 800]);
% for i = 1:7
%     subplot(3,3,i);
%     im_hist = bands{i}(:); 
%     histogram(im_hist, 256, 'FaceColor', [0.2 0.5 0.8], 'EdgeColor', 'none');
%     title(band_names{i}, 'FontWeight', 'bold');
%     xlabel('DN Value');
%     ylabel('Frequency');
%     grid on;
% end
% 
% sgtitle('Landsat TM Band Histograms', 'FontSize', 14, 'FontWeight', 'bold');

% saveas(gcf, 'Landsat_TM_Histograms.jpg');
% fprintf('Histogram image saved as Landsat_TM_Histograms.jpg\n');

%% 
% Question 1: Show histograms of all images
fprintf('\n1. Generating histograms for all bands...\n');

% Band 1 Histogram
figure('Name', 'Band 1 Histogram', 'Position', [100 100 1200 800]);
imhist(band1);
title('Band 1 (Blue) Histogram');
xlabel('Pixel Intensity');
ylabel('Frequency');

pause;

% Band 2 Histogram
figure('Name', 'Band 2 Histogram', 'Position', [100 100 1200 800]);
imhist(band2);
title('Band 2 (Green) Histogram');
xlabel('Pixel Intensity');
ylabel('Frequency');
pause;
% Band 3 Histogram
figure('Name', 'Band 3 Histogram', 'Position', [100 100 1200 800]);
imhist(band3);
title('Band 3 (Red) Histogram');
xlabel('Pixel Intensity');
ylabel('Frequency');
pause;
% Band 4 Histogram
figure('Name', 'Band 4 Histogram', 'Position', [100 100 1200 800]);
imhist(band4);
title('Band 4 (NIR) Histogram');
xlabel('Pixel Intensity');
ylabel('Frequency');
pause;
% Band 5 Histogram
figure('Name', 'Band 5 Histogram', 'Position', [100 100 1200 800]);
imhist(band5);
title('Band 5 (SWIR 1) Histogram');
xlabel('Pixel Intensity');
ylabel('Frequency');
pause;
% Band 6 Histogram
figure('Name', 'Band 6 Histogram', 'Position', [100 100 1200 800]);
imhist(band6);
title('Band 6 (SWIR 2) Histogram');
xlabel('Pixel Intensity');
ylabel('Frequency');
pause;
% Band 7 Histogram
figure('Name', 'Band 7 Histogram', 'Position', [100 100 1200 800]);
imhist(band7);
title('Band 7 (SWIR 3) Histogram');
xlabel('Pixel Intensity');
ylabel('Frequency');
pause;


%% Question 2: Scatter plot of Bands 3 vs 4
fprintf('\n2. Creating scatter plot of Band 3 vs Band 4...\n');

figure('Name', 'Scatter Plot: Band 3 vs Band 4', Position=[100 100 1200 800]);
scatter(band3_d(:), band4_d(:), 1, 'filled', 'MarkerFaceAlpha', 0.3);
xlabel('Band 3 (Red) Pixel Value');
ylabel('Band 4 (NIR) Pixel Value');
title('Scatter Plot: Band 3 (Red) vs Band 4 (NIR)');
grid on; 
xlim([0 257]);
ylim([0 257]);
axis square;  % Makes the plot square for better comparison


% Comment on the scatter plot
fprintf('\nComment on Band 3 vs Band 4 scatter plot:\n');
fprintf('The scatter plot shows the relationship between red and NIR bands.\n');
fprintf('Vegetation appears in the upper-left region (low red, high NIR).\n');
fprintf('Water bodies appear in the lower-left (low red, low NIR).\n');
fprintf('Urban/bare soil appears along a diagonal pattern.\n');

%% Question 3: Contrast stretch Bands 3 & 4
fprintf('\n3. Performing contrast stretching on Bands 3 and 4...\n');

% Linear contrast stretch (2% and 98% percentiles)
band3_stretched = imadjust(band3, stretchlim(band3, [0.02 0.98]), []);
band4_stretched = imadjust(band4, stretchlim(band4, [0.02 0.98]), []);

figure('Name', 'Contrast Stretching Comparison');

subplot(2,2,1);
imshow(band3);
title('Band 3 (Red) - Original');

subplot(2,2,2);
imshow(band3_stretched);
title('Band 3 (Red) - Contrast Stretched');

subplot(2,2,3);
imshow(band4);
title('Band 4 (NIR) - Original');

subplot(2,2,4);
imshow(band4_stretched);
title('Band 4 (NIR) - Contrast Stretched');

fprintf('\nComment on contrast stretching:\n');
fprintf('Contrast stretching enhances the visual appearance by expanding\n');
fprintf('the dynamic range of pixel values, making features more distinguishable.\n');
fprintf('Dark areas become darker and bright areas become brighter.\n');

%% Question 4: Get pixel value at row=15, column=45 for standard FCC
fprintf('\n4. Extracting pixel values at row=15, column=45 for FCC (Bands 3,2,1)...\n');

row = 15;
col = 45;

% Standard FCC uses RGB = Bands 3, 2, 1
pixel_band3 = band3(row, col);
pixel_band2 = band2(row, col);
pixel_band1 = band1(row, col);

fprintf('Pixel values at (row=%d, col=%d):\n', row, col);
fprintf('  Band 3 (Red):   %d\n', pixel_band3);
fprintf('  Band 2 (Green): %d\n', pixel_band2);
fprintf('  Band 1 (Blue):  %d\n', pixel_band1);

% Comment on likely feature based on FCC bands only

fprintf('\nThat means the surface reflects much more blue light than red or green.\n');
fprintf('\nGiven the low red/green and moderate blue, the most likely surface is clear water or a shaded area over water\n')

%% Question 5: Produce NDVI image with colorbar
fprintf('\n5. Generating NDVI image...\n');

% NDVI = (NIR - Red) / (NIR + Red)
% Using Bands 4 (NIR) and 3 (Red)
ndvi = (band4_d - band3_d) ./ (band4_d + band3_d + eps); % eps to avoid division by zero

figure('Name', 'NDVI Image');
imagesc(ndvi);
colormap('jet');
colorbar;
clim([-1 1]); % NDVI ranges from -1 to 1
title('NDVI Image (Normalized Difference Vegetation Index)');
xlabel('Column');
ylabel('Row');

% Create a more detailed NDVI classification
figure('Name', 'NDVI Classification');
imagesc(ndvi);
colormap([0 0 0.5; 0 0.5 1; 0.5 0.5 0.5; 0 0.8 0; 0 0.5 0]); % Custom colormap
colorbar('Ticks', [-1, -0.5, 0, 0.5, 1], ...
         'TickLabels', {'Water', 'Bare Soil', 'Low Veg', 'Moderate Veg', 'Dense Veg'});
title('NDVI Classification');
xlabel('Column');
ylabel('Row');

fprintf('NDVI ranges: Water (<0), Bare soil (0-0.2), Vegetation (>0.2)\n');

%% Question 6: Produce Band 5 - Band 4 image
fprintf('\n6. Generating Band 5 - Band 4 image...\n');

band_diff = band5_d - band4_d;

figure('Name', 'Band 5 - Band 4 Difference');
imagesc(band_diff);
colormap('gray');
colorbar;
title('Band 5 (MIR) - Band 4 (NIR) Difference Image');
xlabel('Column');
ylabel('Row');

fprintf('This difference highlights moisture content and soil characteristics.\n');

%% Question 7: Estimate water body area from Band 4
fprintf('\n7. Estimating water body area using Band 4...\n');

% Landsat TM spatial resolution
pixel_size = 30; % meters
pixel_area = pixel_size * pixel_size; % square meters

% Water has low reflectance in NIR (Band 4)
% Determine threshold using Otsu's method or manual threshold
threshold = graythresh(band4) * 255; % Otsu's threshold
fprintf('Using threshold: %.2f\n', threshold);

% Create water mask (pixels below threshold are water)
water_mask = band4_d < threshold;

% Count water pixels
water_pixels = sum(water_mask(:));

% Calculate area
water_area_m2 = water_pixels * pixel_area;
water_area_km2 = water_area_m2 / 1e6;

fprintf('Number of water pixels: %d\n', water_pixels);
fprintf('Estimated water body area: %.2f m² (%.4f km²)\n', water_area_m2, water_area_km2);

% Visualize water mask
figure('Name', 'Water Body Detection');
subplot(1,2,1);
imshow(band4);
title('Band 4 (NIR) - Original');

subplot(1,2,2);
imshow(water_mask);
title(sprintf('Water Mask (Area: %.4f km²)', water_area_km2));

% Overlay water on RGB image
figure('Name', 'Water Bodies Highlighted');
rgb_image = cat(3, band3, band2, band1);
rgb_image = imadjust(rgb_image, stretchlim(rgb_image, [0.02 0.98]), []);
imshow(rgb_image);
hold on;
[B, L] = bwboundaries(water_mask, 'noholes');
for k = 1:length(B)
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'c', 'LineWidth', 2);
end
hold off;
title('Water Bodies Highlighted on RGB Composite');

%% Additional Visualizations
% fprintf('\n8. Creating additional composite images...\n');
% 
% % Standard False Color Composite (FCC): RGB = 4,3,2
% figure('Name', 'Standard False Color Composite (4,3,2)');
% fcc = cat(3, band4, band3, band2);
% fcc = imadjust(fcc, stretchlim(fcc, [0.02 0.98]), []);
% imshow(fcc);
% title('False Color Composite (NIR-Red-Green): Vegetation appears red');
% 
% % Natural Color Composite: RGB = 3,2,1
% figure('Name', 'Natural Color Composite (3,2,1)');
% ncc = cat(3, band3, band2, band1);
% ncc = imadjust(ncc, stretchlim(ncc, [0.02 0.98]), []);
% imshow(ncc);
% title('Natural Color Composite (Red-Green-Blue)');
% 
% fprintf('\n=== Image Processing Complete ===\n');
% fprintf('All figures have been generated.\n');
% fprintf('Review each figure for analysis results.\n');


%% Challenge Question 1: Produce standard FCC (4-3-2)
fprintf('\n=== Challenge Question 1: Standard FCC(4-3-2) ===\n');
fprintf('Creating standard FCC from Band 4 (NIR), Band 3 (Red), Band 2 (Green)...\n');

% Standard FCC uses: R=Band4 (NIR), G=Band3 (Red), B=Band2 (Green)
% Stack the bands to create RGB composite
fcc_image = cat(3, band4, band3, band2);

% Display the FCC
figure('Name', 'Standard FCC (4-3-2)', 'Position', [100 100 1200 800]);
imshow(fcc_image);
title('Standard False Color Composite (FCC) - Band 4-3-2');
xlabel('Red = NIR (Band 4), Green = Red (Band 3), Blue = Green (Band 2)');
fprintf('Standard FCC image displayed.\n');
fprintf('  R channel: Band 4 (NIR)\n');
fprintf('  G channel: Band 3 (Red)\n');
fprintf('  B channel: Band 2 (Green)\n');
fprintf('In FCC, vegetation appears red due to high NIR reflectance.\n');
%% Challenge Question 2: PCA on six bands (excluding band 6)
fprintf('\n=== Challenge Question 2: Principal Component Analysis ===\n');
fprintf('Performing PCA on 6 bands (excluding band 6)...\n');

% Stack bands for PCA (excluding band 6) - using downsampled double versions
[rows, cols] = size(band1_d);
bands_matrix = [band1_d(:), band2_d(:), band3_d(:), band4_d(:), band5_d(:), band7_d(:)];

% Perform PCA
[coeff, score, latent, tsquared, explained] = pca(bands_matrix);

% Reshape PC scores back to image dimensions
pc1 = reshape(score(:,1), rows, cols);
pc2 = reshape(score(:,2), rows, cols);
pc3 = reshape(score(:,3), rows, cols);

% Normalize PCs to 0-255 for display
pc1_norm = mat2gray(pc1) * 255;
pc2_norm = mat2gray(pc2) * 255;
pc3_norm = mat2gray(pc3) * 255;

% Display variance explained
fprintf('Variance explained by each component:\n');
for i = 1:length(explained)
    fprintf('  PC%d: %.2f%%\n', i, explained(i));
end
fprintf('Total variance by first 3 PCs: %.2f%%\n', sum(explained(1:3)));

% Display individual PC images
figure('Name', 'Challenge 2: Principal Components', 'Position', [100 100 1200 400]);
subplot(1,3,1);
imshow(uint8(pc1_norm));
title(sprintf('PC1 (%.2f%% variance)', explained(1)));

subplot(1,3,2);
imshow(uint8(pc2_norm));
title(sprintf('PC2 (%.2f%% variance)', explained(2)));

subplot(1,3,3);
imshow(uint8(pc3_norm));
title(sprintf('PC3 (%.2f%% variance)', explained(3)));

% Comment on compression
fprintf('\nImage Compression Analysis:\n');
fprintf('Original data: 6 bands × %d pixels = %d values\n', rows*cols, 6*rows*cols);
fprintf('Using 3 PCs: 3 bands × %d pixels = %d values\n', rows*cols, 3*rows*cols);
fprintf('Compression ratio: %.2f:1\n', 6/3);
fprintf('Information retained: %.2f%%\n', sum(explained(1:3)));
fprintf('This represents excellent compression with minimal information loss.\n');

%% Challenge Question 3: FCC of first three principal components
fprintf('\n=== Challenge Question 3: FCC of Principal Components ===\n');
fprintf('Creating FCC from first 3 principal components...\n');

% Create RGB composite from first 3 PCs
pca_fcc = cat(3, uint8(pc1_norm), uint8(pc2_norm), uint8(pc3_norm));

figure('Name', 'Challenge 3: PCA FCC', 'Position', [100 100 800 600]);
imshow(pca_fcc);
title('False Color Composite of First 3 Principal Components');
fprintf('PCA-based FCC displayed (R=PC1, G=PC2, B=PC3).\n');

%% Challenge Question 4: Derive ISH Images
fprintf('\n=== Challenge Question 4: ISH (Intensity-Saturation-Hue) Images ===\n');
fprintf('Converting RGB to HSV and extracting ISH components...\n');

% Create RGB composite (Natural Color: Band 3, 2, 1)
rgb_image = cat(3, band3_d, band2_d, band1_d);
rgb_normalized = (rgb_image) / 255;

% Convert to HSV (Hue, Saturation, Value/Intensity)
hsv_image = rgb2hsv(rgb_normalized);

% Extract components
intensity = hsv_image(:,:,3); % Value = Intensity
saturation = hsv_image(:,:,2);
hue = hsv_image(:,:,1);

% Display ISH components
figure('Name', 'Challenge 4: ISH Components', 'Position', [100 100 1200 400]);

subplot(1,3,1);
imshow(intensity);
title('Intensity Component');
colorbar;

subplot(1,3,2);
imshow(saturation);
title('Saturation Component');
colorbar;

subplot(1,3,3);
imshow(hue);
title('Hue Component');
colorbar;

fprintf('ISH components extracted and displayed.\n');
fprintf('- Intensity: Overall brightness\n');
fprintf('- Saturation: Color purity\n');
fprintf('- Hue: Color type\n');


%% Challenge Question 5: Density slice NDVI image
fprintf('\n=== Challenge Question 5: Density Sliced NDVI ===\n');
fprintf('Creating density sliced NDVI with different tones of green...\n');

% Calculate NDVI
ndvi = ((band4_d) - (band3_d)) ./ ((band4_d) + (band3_d) + 1e-10);

% Create density slices for vegetation
% Define NDVI thresholds
ndvi_classified = zeros(size(ndvi));
ndvi_classified(ndvi < 0) = 1;           % Water/Non-vegetation (Dark)
ndvi_classified(ndvi >= 0 & ndvi < 0.2) = 2;  % Bare soil (Light brown)
ndvi_classified(ndvi >= 0.2 & ndvi < 0.4) = 3; % Sparse vegetation (Light green)
ndvi_classified(ndvi >= 0.4 & ndvi < 0.6) = 4; % Moderate vegetation (Medium green)
ndvi_classified(ndvi >= 0.6) = 5;        % Dense vegetation (Dark green)

% Create custom colormap with different tones of green
custom_cmap = [
    0.4 0.2 0.0;   % Brown for bare soil
    0.6 0.4 0.2;   % Light brown
    0.8 1.0 0.6;   % Light green
    0.4 0.8 0.3;   % Medium green
    0.1 0.5 0.1;   % Dark green
];

% Display density sliced NDVI
figure('Name', 'Challenge 5: Density Sliced NDVI', 'Position', [100 100 1200 800]);

subplot(2,1,1);
imshow(ndvi, []);
colormap(gca, 'jet');
colorbar;
title('Continuous NDVI Image');
xlabel('NDVI Range: -1 to +1');

subplot(2,1,2);
imagesc(ndvi_classified);
colormap(gca, custom_cmap);
colorbar('Ticks', [1 2 3 4 5], ...
         'TickLabels', {'Water', 'Bare Soil', 'Sparse Veg', 'Moderate Veg', 'Dense Veg'});
title('Density Sliced NDVI - Vegetation in Different Tones of Green');
axis image;

fprintf('Density slicing completed.\n');
fprintf('Classification:\n');
fprintf('  Class 1 (Brown): Water/Non-vegetation (NDVI < 0)\n');
fprintf('  Class 2 (Light Brown): Bare soil (0 ≤ NDVI < 0.2)\n');
fprintf('  Class 3 (Light Green): Sparse vegetation (0.2 ≤ NDVI < 0.4)\n');
fprintf('  Class 4 (Medium Green): Moderate vegetation (0.4 ≤ NDVI < 0.6)\n');
fprintf('  Class 5 (Dark Green): Dense vegetation (NDVI ≥ 0.6)\n');

% Calculate statistics
fprintf('\nVegetation Statistics:\n');
total_pixels = numel(ndvi);
for i = 1:5
    class_pixels = sum(ndvi_classified(:) == i);
    percentage = (class_pixels / total_pixels) * 100;
    fprintf('  Class %d: %.2f%% of image\n', i, percentage);
end