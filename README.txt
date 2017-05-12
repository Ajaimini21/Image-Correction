
Topic: Image Correction Project
Author: Andrew Sack
Date: 5/12/17

OVERVIEW

A common issue when collecting and using data is data loss or corruption. This project focuses on the issue of corruption in image data, specifically in the form of pixel-by-pixel random noise  It aims to approximate the non-corrupted image using just the corrupted image. Using statistical analysis of the images and variations on median filtering, this program can identify and mitigate or remove the corrupted pixels. 

WHERE TO START

To use the program run the main.m file. This will launch the gui.

USER INTERFACE/INSTRUCTIONS
1) Click 'Select Image' in the 'Load Image' box. A file browser will open and you can select a JPG image from the 'Data' folder. The image should appear under 'Image Preview'.

2) (OPTIONAL) In the 'Image Distortion' box enter a distortion percent value in the text box or use the slider below if you wish to distort the image. Press the button labelled 'Distort'. The distorted image will replace the previous image under 'Image Preview'. See the description for 'distortImg.m' under CALCULATION FUNCTIONS for more information

3) (OPTIONAL) Modify the values in the 'Image Correction Parameters' box. Press the 'Update Parameters' button to save the updates values.

	threshold: (DEFAULT: 0.10) used only for 'Selective Correction'. Is the decimal value between 0 and 1 of the minimum median difference a pixel must be from its surrounding pixels for filtering to occur. See THRESHOLD ANALYSIS for a more detailed explanation.

	M: (DEFAULT: 3) x/row size dimension of box surrounding a pixel that is included in the median filtering. See FILTERING METHOD for more details. Ex: M=3,N=3 is a 3x3 box with the target pixel in the center, a 1 pixel border around it

	N: (DEFAULT: 3) y/column sized dimension of box surrounding a pixel that is included in the median filtering. See FILTERING METHOD for more details. Ex: M=3,N=3 is a 3x3 box with the target pixel in the center, a 1 pixel border around it

	# iterations: (DEFAULT: 1) The number of times the correction is run.

4) In the 'Image Correction' box click either the 'Selective Correction' or 'Non-Selective Correction' button to run image correction. See FILTERING METHOD for more details of the process. A loading bar will pop up and then when the correction is complete, the corrected image will replace the previous image under 'Image Preview'.

5) In the 'Save Options' box, press a button to save results. A dialog box will pop up to enter a filename for the output file.

	'Save Current Figure': saves the image currently displayed under 'Image Preview' as a MATLAB figure file

	'Save as JPG': saves the image currently displayed under 'Image Preview' as a JPG

	'Save Combined Figure': saves a MATLAB figure of original, distorted (if applicable), and corrected image side-by-side

	'Generate Text Summary': saves a txt file with information about the correction performed
 

DATA
The data is contained in a folder named 'Data'. It contains several images that you can use or you can add any JPG image to the folder and use that. The images that come in the folder include: 

solid color/geometric images: useful for calibrating the code

uncorrupted photographs: these can be distorted in the program which allows a clear comparison of the corrected image with the original

pre-corrupted photographs: these images were found already in a distorted form and show that the program can work with corruption from other sources. Included images of this type have names that end in '_noisy'

If using own images, it is recommended that the image is under approximately 500x500 pixels, as the processing time increases drastically with increasing image size. 


RESULTS
All result files saved by the program are saved in a folder named 'Results'. The program generated 4 types of result files:

1) JPG of corrected image
2) MATLAB figure of corrected image
3) MATLAB figure of original, distorted (if applicable), and corrected image side-by-side
4) Text file with data about correction 

Inside the 'Results' folder is a series of folders of sets of results designed to show the effects of specific parts of the correction algorithm. They are:

'ChangeMandN' - show in an exagerated manner what the M and N parameters do

'CompareDistortAmounts' - shows efficacy of correction on distort amounts ranging from 20% to 100%

'CompareThresholds' - shows how increasing threshold values result in a decreasing amount of noise removed

'PreCorruptedImages' - shows efficacy of filtering on images that were found pre-distorted from other sources

'SelectiveVsNonSelective' - shows how selective filtering preserves sharpness in areas of the image (look at grass)


MAIN FILES

1) main.m - script that launches gui and manages path and workspace (RUN THIS)

2) imageDistort.m - code file for GUI

3) imageDistort.fig - figure file for GUI


CALCULATION FUNCTIONS

1) distortImg.m - This function will distort an image to the desired amount by randomly select the desired number of pixels and then replace their values with random color values across all channels. See function file for IO details.

Note: The function inputs a percent of pixels in the image to be distorted. This is not equal to the number of pixels that end up distorted due to the random selection of target locations and the possibility of repeats. The number of unique distorted pixels was measured for several runs of multiple images and the corresponding real percentages were determined to be very consistently as follows:
0% = 0% (This is always exactly true)
10% = 9.5%
20% = 18%
30% = 25%
40% = 32%
50% = 39%
60% = 45%
70% = 50%
80% = 54%
90% = 59%
100% = 63%
As the input percentage gets infinitely large, the true percentage will approach a horizontal asymptote at 100%

2) combinedSmooth.m - performs 2D median filtering as described in FILTERING METHOD. This form of filtering is selective, it is performed only on points where the median of the differences of surrounding pixels to the target pixel are greater than a threshold. This helps preserve the image quality, especially sharpness in areas that are not distorted. It first converts the uint8 image into double form for use in calculations and then converts the corrected image back to uint8. This function also incorporates a timer and waitbar due to the long processing time. See function file for IO details.

3) smoothAll.m - performs 2D median filtering as described in FILTERING METHOD. This form of filtering is non-selective, it is performed on all points and all pixels are modified for the corrected image. It first converts the uint8 image into double form for use in calculations and then converts the corrected image back to uint8. This function also incorporates a timer and waitbar due to the long processing time. See function file for IO details. 


GUI FUNCTIONS

1) selectImg_SubFunc.m - triggers when 'Select Image' button is pressed. Handles process of selecting and loading in an image

2) distortGo_SubFunc.m - triggers when 'Distort' button is pressed. Calls 'distortImg.m' to distort.  the input image.

3) updateParam_SubFunc.m - triggers when 'Update Parameters' button is pressed. Reads in parameter values

4) selectCorr_SubFunc.m - triggers when 'Selective Correction' button is pressed. Calls 'combinedSmooth.m' to run selective correction on image

5) genCorr_SubFunc.m - triggers when 'Non-Selective Correction' button is pressed. Calls 'smoothAll.m' to run non-selective correction on image

6) saveCurr_SubFunc.m - triggers when 'Save Current Correction' button is pressed. See USER INTERFACE/INSTRUCTIONS #5

7) saveJPG_SubFunc.m - triggers when 'Save as JPG' button is pressed. See USER INTERFACE/INSTRUCTIONS #5

8) saveCombo_SubFunc.m - triggers when 'Save Combined Figure' button is pressed. See USER INTERFACE/INSTRUCTIONS #5

9) genTxt_SubFunc.m - triggers when 'Generate Text Summary' button is pressed. See USER INTERFACE/INSTRUCTIONS #5


FILTERING METHOD
A modified method of 2D median filtering. The center point is not included in the median calculation and median is used instead of mean, because the use is to remove outliers, so calculations that are heavily skewed by outliers are a poor choice. The function steps through each point on each channel in the image (all calculations keep the image channels completely separate). (*An additional step is included here for SELECTIVE filtering ONLY*) For each pixel, the value of each pixel in the M x N box around the pixel (excluding the target pixel) is added to an array. The median of this array is taken and that becomes the value of that pixel in the corrected image. This is able to handle edges of the image by simply only including pixels that exist in the median calculation.

Where noted, for selective filtering ONLY, the absolute value of the difference between the center pixel and each pixel in the MxN box surrounding it is added to an array. The median is taken, and only if the median is greater than a threshold median difference value, the value of the pixel is corrected to the median.

Overall, median filtering will smooth the image, making each pixel more like its neighbors. This is good for removing outlier (distorted) pixels, but in non-distorted portions of the image, this results in blurring the image. Selective filtering attempts to avoid this by only target pixels that are different enough from their surroundings that we believe they are outliers. This is determined by the threshold value and you can see THRESHOLD ANALYSIS for more details. By only smoothing targeted pixels, the other parts of the image remain sharper and the distorted pixels that may slip through are the least different from their surroundings anyways.


THRESHOLD ANALYSIS

The threshold value is a decimal value between 0 and 1 that is the minimum median difference a pixel must be from its surrounding pixels for filtering to occur when using the selective filtering method. The larger the threshold is, the less noise will be filtered out because only pixels with median differences above the threshold are filtered. This means a value of 0 will perform filtering on all pixels and a value of 1 will not perform filtering on any pixels. Determining the optimal value is a difficult problem and a mixture of manual trial and error and brute force calculations was used to reach the default value of 0.10. 

In the threshold analyis folder is some of the functions used to brute force calculate an ideal threshold. DO NOT try to run, as it takes over 15 to run. The spreadsheet shows the results of the different methods on different images with different levels of distortion. 

Method 2: knows the true number of pixels that were distorted and the median difference of all points. It sorts the median differences from large to small, and takes the value of the (true # of distorted pixels) index of the differences as the threshold. This uses the assumption that all distorted pixels have differences greater than all non-distorted pixels.

Method 3: knows the location and value of all distorted pixels. It sorts the differences of only the distorted pixels and discards the n% smallest values and the next smallest value is the ideal threshold. This can be run with different discard percents.

(Method 1 did not work at all so it no longer exists)

From testing both methods (including different discard percents from method 3) on different images with different levels of distortion, the spreadsheet was produced. A few different means and medians of subsets of the data were calculated and combined with my experience of trial and error, I decided 0.10 was a good all-around value. 

An interesting note is that the results of this brute forcing seem to indicate that a slightly higher threshold should be used as distort percent increases. 

(I know these files are not as well documented, but they are not intended to be run by others)