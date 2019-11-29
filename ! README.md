# Lab Project - Magnetic Tracking

Student: Haibin Zhao

Impelementation of magnetic tracking 

## Project.m
is the main file

## Magnetfield.m
to calculate the Magnetfield Strength in ![](http://latex.codecogs.com/gif.latex?\\vec{i}_{2}-\vec{i}_{3}}) Plane.

![Bild](https://shangqinghome.files.wordpress.com/2019/11/berechneter-bereich.png).

And the last 4 lines creat and write the Magnetfield and the Coordinates into a Excel-Files

I have already calculated the Data and upload the xlsx-file with the following Parameters
* Ra = 0.009;     % Halbmesserdes Magnets in Meter m
* L = 0.005;      % Hoehe des Magnets in Meter m
* Br = 1.48;      % Magnetische Remanenz in T
* n = 500;        % Anzahl der Knoten
* B = 0.15;
* H = 2 * B;      % Breite und Hoehe des zu berechneten Bereichs
So that user can directly use these data

## sensorposition.m
calculate the Sensorpositions with a specific Workspace size and the number of sensors on each edge

## coordinatentransform.m
transform the Global-coordinates of the sensor and the Magnet in to the Magnet-coordinate based on the Position and Orientation of the Magnet
The return Values are 2 Coordinates and a rotate angle
* the first coordinate rcs(1,:) is the sensor position in Magnet-coordinate
* the second coordinate rcs(2,:) is the reference point which lies on the Plane ![](http://latex.codecogs.com/gif.latex?\\vec{i}_{2}-\vec{i}_{3}})
* the rotate angle ![](http://latex.codecogs.com/gif.latex?\\theta_{k}) is the rotate angle between rcs(1,:) and rcs(2,:)

## itplt.m
interpolates the Magnetfield strength, and return the magnet field strength in Magnet-coordinate

## inversetransform.m
transform the magnet field strength in Magnet-coordinate back to the Global-coordinate

-------------------------------------------------------------------------------------------------------------------------
## 25.Nov.2019
I rename and rewrite some m-files from german-language into english
