<a name="br1"></a> 

**Image Processing (ELEC8280-1-R-2023W)**

**Assignment #2:**

Understanding the HT, its implementation strategy and application.

**Instructor's Name**

Dr. Jonathan Wu

**Submitted by:** Smit Dixit - 110092043

**Date:** February 27<sup>th</sup> 2023



<a name="br2"></a> 

Answer: 1

The code in ‘line\_detection.m’ detects straight lines in an input RGB image

using the Hough transform. It converts the image to grayscale and applies the

Canny edge detection algorithm to obtain an edge map. Then it defines the

range of parameter values for the Hough transform, creates an accumulator

matrix, and incrementally adds the corresponding Hough parameter values for

each edge pixel. The maximum value in the accumulator matrix and its

corresponding indices are found to identify the detected line. Finally, the code

converts the detected Hough parameters to the equation of a line in slope-

intercept form and generates the x and y coordinates of the detected line to plot

on both the edge map and grayscale image.

Test image 1:

Command Window:

I = imread('test1.jpg');

line\_detection(I)



<a name="br3"></a> 

Output:

Answer :2

This code detects circles in an input RGB image using the Hough transform. It

first converts the image to grayscale and applies the Canny edge detection

algorithm to obtain an edge map. Then, it loops over each edge pixel and for



<a name="br4"></a> 

each pixel, it loops over all possible values of theta to calculate the coordinates

of the center of a circle with radius r. The center coordinates are then used to

increment the accumulator array. The top three maximum values in the

accumulator array are then found and the x and y coordinates of the center of

the detected circle are obtained. Finally, the detected circle is displayed on both

the edge image and the grayscale image.

Command window:

Output:

I=imread('test2.jpg');

r=30;

circle\_detection(I,r)

Detected circle

coordinates:

(457,337)

(457,336)

(92,502)



<a name="br5"></a> 

Command Window:

Output:

I=imread('test2.jpg');

r=35;

circle\_detection(I,r)

Detected circle

coordinates:

(122,689)

(239,344)

(207,87)

Command Window:

Output:

I=imread('test2.jpg');

r=37;

circle\_detection(I,r)

Detected circle

coordinates:

(265,365)

(205,88)

(260,322)

