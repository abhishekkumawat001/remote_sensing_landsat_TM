# Landsat TM Image Processing with MATLAB

This repository contains MATLAB code for processing and analyzing Landsat Thematic Mapper (TM) satellite imagery of coastal regions. The code demonstrates various digital image processing techniques including histogram analysis, contrast stretching, vegetation indices, and advanced composite image generation.

## Table of Contents
- [Overview](#overview)
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [Landsat TM Bands Explanation](#landsat-tm-bands-explanation)
- [Code Functionality](#code-functionality)
- [Output and Results](#output-and-results)
- [Image Processing Techniques](#image-processing-techniques)

## Overview

This project processes 7-band Landsat TM imagery to perform:
- Histogram generation and analysis for all spectral bands
- Scatter plot analysis between bands
- Contrast stretching for image enhancement
- Vegetation analysis using NDVI (Normalized Difference Vegetation Index)
- Water body detection and area estimation
- False Color Composite (FCC) generation
- Principal Component Analysis (PCA) for data compression
- HSV (Hue-Saturation-Value) transformation
- Density slicing for vegetation classification

## Requirements

### Software Requirements
- **MATLAB** (R2016b or later recommended)
  - MATLAB R2016b introduced several improvements to image processing functions
  - Tested on MATLAB R2020a and later versions

### Required MATLAB Toolboxes
The following MATLAB toolboxes are required to run the code:

1. **Image Processing Toolbox** - Core toolbox for image manipulation
   - Functions used: `imread`, `imshow`, `imhist`, `imadjust`, `stretchlim`, `rgb2hsv`, `mat2gray`, `bwboundaries`, `graythresh`
   
2. **Statistics and Machine Learning Toolbox** - For PCA analysis
   - Functions used: `pca`

### Hardware Requirements
- **RAM**: Minimum 4 GB (8 GB or more recommended for larger images)
- **Storage**: At least 100 MB free space for data and output
- **Display**: Screen resolution of at least 1024x768 for proper visualization

## Installation

1. **Clone or download this repository**
   ```bash
   git clone https://github.com/abhishekkumawat001/remote_sensing_landsat_TM.git
   cd remote_sensing_landsat_TM
   ```

2. **Extract the data files**
   
   The repository includes a `data.zip` file containing all 7 Landsat TM bands. Extract this file in the same directory as `assignment3.m`:
   
   - **On Windows**: Right-click `data.zip` → Extract Here
   - **On Linux/Mac**: 
     ```bash
     unzip data.zip
     ```
   
   After extraction, you should have the following image files:
   - `band1.jpg` - Blue band
   - `band2.jpg` - Green band
   - `band3.jpg` - Red band
   - `band4.jpg` - Near-Infrared band
   - `band5.jpg` - Mid-Infrared band (mid-IR 1)
   - `band6.jpg` - Thermal-Infrared band
   - `band7.jpg` - Mid-Infrared band (mid-IR 2)

3. **Verify file structure**
   
   Your directory should look like:
   ```
   remote_sensing_landsat_TM/
   ├── assignment3.m
   ├── data.zip
   ├── RS_assignment_3.pdf
   ├── band1.jpg
   ├── band2.jpg
   ├── band3.jpg
   ├── band4.jpg
   ├── band5.jpg
   ├── band6.jpg
   └── band7.jpg
   ```

## Usage

1. **Open MATLAB** and navigate to the project directory:
   ```matlab
   cd '/path/to/remote_sensing_landsat_TM'
   ```

2. **Run the main script**:
   ```matlab
   assignment3
   ```
   
   Or open `assignment3.m` in the MATLAB Editor and click the **Run** button.

3. **Interactive execution**:
   - The script will display various figures sequentially
   - Press any key in the MATLAB Command Window to proceed to the next visualization
   - Some sections are commented out for faster execution - uncomment them if needed

4. **Expected runtime**: 
   - Approximately 1-3 minutes depending on your system specifications
   - PCA computation may take longer on slower systems

## Landsat TM Bands Explanation

Landsat Thematic Mapper (TM) is a multispectral sensor that captures data in seven spectral bands. Each band is sensitive to different wavelengths of electromagnetic radiation and is useful for different applications.

### Band Specifications

| Band | Name | Wavelength (μm) | Spectral Region | Spatial Resolution | Primary Applications |
|------|------|-----------------|-----------------|-------------------|---------------------|
| **Band 1** | Blue | 0.45 - 0.52 | Visible Blue | 30m | Water body penetration, soil/vegetation discrimination, forest type mapping |
| **Band 2** | Green | 0.52 - 0.60 | Visible Green | 30m | Vegetation vigor assessment, green reflectance peak measurement |
| **Band 3** | Red | 0.63 - 0.69 | Visible Red | 30m | Chlorophyll absorption, vegetation discrimination, urban area identification |
| **Band 4** | Near-Infrared (NIR) | 0.76 - 0.90 | Near-Infrared | 30m | Biomass estimation, water body delineation, vegetation health monitoring |
| **Band 5** | Short-wave Infrared 1 (mid-IR1) | 1.55 - 1.75 | Mid-Infrared | 30m | Moisture content in soil and vegetation, cloud/snow discrimination |
| **Band 6** | Thermal Infrared (TIR) | 10.4 - 12.5 | Thermal | 120m* | Surface temperature, thermal mapping, water stress detection |
| **Band 7** | Short-wave Infrared 2 (mid-IR2) | 2.08 - 2.35 | Mid-Infrared | 30m | Mineral and rock discrimination, vegetation moisture content |

*Note: Band 6 has a lower spatial resolution (120m for Landsat 4-5 TM) compared to other bands (30m).

### Key Band Characteristics

#### Visible Bands (1-3)
- **Band 1 (Blue)**: Maximum water penetration among all bands, useful for bathymetry and differentiating between soil and vegetation
- **Band 2 (Green)**: Matches the green reflectance peak of healthy vegetation
- **Band 3 (Red)**: High chlorophyll absorption, excellent for vegetation discrimination

#### Infrared Bands (4-5, 7)
- **Band 4 (NIR)**: Healthy vegetation strongly reflects NIR while water strongly absorbs it. This is the most important band for vegetation studies
- **Band 5 (mid-IR1)**: Sensitive to moisture content in plants and soil. Helps separate clouds from snow
- **Band 7 (mid-IR2)**: Used for mineral and geological mapping, also sensitive to plant moisture

#### Thermal Band (6)
- **Band 6 (TIR)**: Measures thermal radiation/heat. Used for thermal mapping, identifying water stress in plants, and urban heat island studies

### Common Band Combinations

1. **Natural Color Composite (3-2-1)**: RGB = Red, Green, Blue
   - Appears as the human eye would see it
   - Good for urban area identification

2. **False Color Composite (4-3-2)**: RGB = NIR, Red, Green
   - Vegetation appears red (high NIR reflectance)
   - Water appears dark blue/black
   - Most popular combination for vegetation studies

3. **Agriculture Composite (5-4-1)**: RGB = SWIR1, NIR, Blue
   - Excellent for crop monitoring and agriculture
   - Shows vegetation health and moisture content

## Code Functionality

The `assignment3.m` script is organized into several sections:

### 1. Data Loading and Preprocessing
- Loads all 7 Landsat TM bands from JPEG files
- Converts images to double precision for numerical calculations
- Prepares data for analysis

### 2. Histogram Analysis (Question 1)
- Generates histograms for all 7 bands
- Shows the distribution of pixel intensity values
- Helps understand the radiometric characteristics of each band

### 3. Scatter Plot Analysis (Question 2)
- Creates scatter plot between Band 3 (Red) and Band 4 (NIR)
- Reveals relationships between spectral bands
- Helps identify different land cover types:
  - Vegetation: Low red, high NIR (upper-left region)
  - Water: Low red, low NIR (lower-left region)
  - Urban/bare soil: Diagonal pattern

### 4. Contrast Stretching (Question 3)
- Applies linear contrast enhancement to Bands 3 and 4
- Uses 2% and 98% percentiles for stretch limits
- Improves visual interpretation by expanding the dynamic range

### 5. Pixel Value Extraction (Question 4)
- Extracts pixel values at specific coordinates (row=15, col=45)
- Demonstrates how to access individual pixel values
- Interprets surface type based on spectral signature

### 6. NDVI Calculation (Question 5)
- Computes Normalized Difference Vegetation Index
- Formula: NDVI = (NIR - Red) / (NIR + Red)
- Generates color-coded vegetation maps
- NDVI ranges from -1 to +1:
  - Water: < 0
  - Bare soil: 0 to 0.2
  - Vegetation: > 0.2 (higher values = denser vegetation)

### 7. Band Difference Image (Question 6)
- Calculates Band 5 - Band 4 difference
- Highlights moisture content and soil characteristics
- Useful for identifying different surface materials

### 8. Water Body Detection (Question 7)
- Uses Band 4 (NIR) for water detection
- Applies Otsu's automatic thresholding method
- Calculates water body area in square meters and square kilometers
- Spatial resolution: 30m × 30m per pixel (900 m² per pixel)

### Challenge Questions

#### Challenge 1: Standard False Color Composite
- Creates FCC using bands 4-3-2 (NIR-Red-Green)
- Vegetation appears red due to high NIR reflectance

#### Challenge 2: Principal Component Analysis (PCA)
- Performs PCA on 6 bands (excluding thermal band 6)
- Reduces data dimensionality while preserving information
- Shows variance explained by each component
- Demonstrates data compression potential

#### Challenge 3: PCA False Color Composite
- Creates RGB composite from first 3 principal components
- Combines maximum information in three bands

#### Challenge 4: ISH (Intensity-Saturation-Hue) Transformation
- Converts RGB to HSV color space
- Extracts Intensity, Saturation, and Hue components
- Useful for analyzing color properties independently

#### Challenge 5: Density Slicing
- Classifies NDVI into discrete categories
- Applies custom color scheme with different tones of green
- Creates thematic map with 5 classes:
  1. Water/Non-vegetation (NDVI < 0)
  2. Bare soil (0 ≤ NDVI < 0.2)
  3. Sparse vegetation (0.2 ≤ NDVI < 0.4)
  4. Moderate vegetation (0.4 ≤ NDVI < 0.6)
  5. Dense vegetation (NDVI ≥ 0.6)

## Output and Results

The script generates multiple figure windows showing:

1. **Individual Band Histograms** (7 figures)
   - Shows pixel intensity distribution for each band
   
2. **Scatter Plot** (Band 3 vs Band 4)
   - Reveals spectral relationships and land cover patterns

3. **Contrast Stretching Comparison**
   - Before and after enhancement for Bands 3 and 4

4. **NDVI Images**
   - Continuous NDVI with colorbar
   - Classified NDVI with vegetation categories

5. **Band Difference Image** (Band 5 - Band 4)
   - Highlights moisture and soil characteristics

6. **Water Body Detection**
   - Binary water mask
   - Water boundaries overlaid on RGB composite

7. **False Color Composites**
   - Standard FCC (4-3-2)
   - PCA-based FCC

8. **Principal Component Images**
   - Individual PC1, PC2, PC3 images with variance percentages

9. **ISH Components**
   - Intensity, Saturation, and Hue images

10. **Density Sliced NDVI**
    - Classified vegetation map with statistics

### Console Output

The script provides detailed text output including:
- Progress messages for each processing step
- Pixel values at specified locations
- NDVI interpretation guidelines
- Water area calculations (in m² and km²)
- PCA variance explained percentages
- Vegetation statistics from density slicing

## Image Processing Techniques

### Techniques Implemented

1. **Histogram Analysis**: Understanding data distribution and radiometric properties

2. **Linear Contrast Stretching**: Enhancing image contrast using percentile-based stretching

3. **Band Ratioing**: Creating vegetation indices (NDVI) to highlight specific features

4. **Thresholding**: Automated segmentation using Otsu's method for water detection

5. **Principal Component Analysis**: Dimensionality reduction and data compression

6. **Color Space Transformation**: RGB to HSV conversion for color-based analysis

7. **Density Slicing**: Classification of continuous data into discrete categories

8. **Image Algebra**: Band arithmetic operations for enhanced feature extraction

### Applications

This code demonstrates practical applications in:
- **Environmental Monitoring**: Tracking vegetation health and water resources
- **Agriculture**: Crop monitoring and yield prediction
- **Urban Planning**: Land use and land cover classification
- **Water Resources Management**: Water body mapping and monitoring
- **Forestry**: Forest type mapping and biomass estimation
- **Coastal Studies**: Coastal vegetation and water quality assessment

## References

- **Landsat 4-5 Thematic Mapper (TM) Documentation**. NASA/USGS Earth Resources Observation and Science (EROS) Center. Available at: https://www.usgs.gov/landsat-missions/landsat-4-5-thematic-mapper

- **MathWorks Image Processing Toolbox Documentation** (2024). The MathWorks, Inc. Available at: https://www.mathworks.com/help/images/

- Lillesand, T., Kiefer, R. W., & Chipman, J. (2015). *Remote Sensing and Image Interpretation* (7th ed.). John Wiley & Sons.

- Jensen, J. R. (2015). *Introductory Digital Image Processing: A Remote Sensing Perspective* (4th ed.). Pearson Education.

## License

This project is for educational purposes as part of a remote sensing and digital image processing assignment.

## Author

Abhishek Kumawat

## Acknowledgments

- USGS/NASA for Landsat data
- Educational institution for assignment framework
