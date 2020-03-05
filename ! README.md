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

## H12.m and H13.m
subfunction for Magnetfield.m

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
-------------------------------------------------------------------------------------------------------------------------
## 15.Dec.2019
I correct the Magnetfeld Distribution in Y-direction. And change the magnetic field strength (A/m) into magnetic flux density (Gauss), which can be detected by sensors

--------------------------------------------------------------------------------------------------------------------------
## 04.Feb.2020
from 15.Dec to 04.Feb, i forgot to write the README file :(

what i have done in this period of time:
fixed some problem with the interpolation function
2 localization algorithms are wrote
to select the hardware, i write a function to calculate the gradient, and the detectablearea
write the functions to simulate the noise and quatization
write a function to generate a random test point
write the functions to do better plot and mesh
write a function to do some experiment for the localization algorithms
rename coordinatentransform.m as coordinatew2i.m
rename inversetransform.m as coordinatei2w.m, which makes the name more clear.

## coordinatei2w.m
as i said, it's just a name-replacement of inverstranform.m

## coordinatew2i.m
as i said, it's just a name-replacement of coordinatentransform.m

## grad.m
a function to calculate the Gradient of Megnet flow density, using Find Difference Method

## mesh3D.m/ plotarea.m/ plotsensorposition.m
due to the complexity of ploting and meshing, i write these functions to plot and mesh. User can input the variables, Values and their names, it will plot or mesh by some presetting parameters.

## detectablearea.m
to calculate the detectable area of a magnet under some specifical sensor datens, e.g. ADC bit, Sensitivity,...

## Noising.m
to make some noise on the detected signal based on Error and Drift of the Hall sensor

## quantize.m
to quantize the noised signal in to discrete Voltage Value

## localization.m
Using Gradient Method to find the minimum of the optimization problem, then we can confirm the oritation of the 

## localization2.m
using Box-Search to determinate the orintation of the Magnet

## randpoint.m
Generate a random testpoint and its MFD distribution, as well as the detected signal of each sensor

## experiment.m
Using localization algorithms and generated MFD distribution of the random test point, we try to localize the Magnet.
I did 13000 times, using different datas of sensors, aim to find that, which parameter of a sensor is most important for localzing the Magnet.



---------------------------------------------------------------------------------------------------------------------------
## 05.Feb.2020
i write a Decorator and add 2 parameters for Decorator.m and mesh3D.m, so that user can activite or deactivete the function Decoriator or mesh-functions

## Decorator.m
a decorator, which shows that which funcion is now running.

___________________________________________________________________________________________________________________________

## 07.Feb.2020
changed the name of variables in Project.m
e.g. B -> MFD, BS -> MFD_at_Sensor,  k -> ADC_bit, n -> Nodenumber. so that the code will be easier to understand.

changed something in Magnetfield.m
  able to input the filename, and whether write the excel-file or not

changed the name Hy.xlsx into Hy_main.xlsx, and analogous for Hz, q2, q3. Because i want to calculate another MFS called Hy_show.xlsx. the new-calculated MFS can show the MFS distribution more clearly.

Fixed some problems in plot- and mesh- functions
new function of plot-/ and mesh- functions. if figureplot == 2, the function will output the image.

wrote a function called area2points.m to change the detectable area from a huge matrix into a n times 2 vector. so that it would be much faster ploting the detectable area.

wrote a function called detectmovement.m. Before that, i can only calculate the detectable area of a magnet field, when the magent move a specific (given) distance. for e.g. in my programm 1mm. The new function can calculate the detectable movement under different adc-bit.



## area2points.m
change the detectable area from a huge matrix into a n times 2 vector. so that it would be much faster ploting the detectable area.
for e.g. 
D = [1, 0, 1;
     0, 1, 1;
     1, 0, 0];
to
x = [1, 1;
     1, 3;
     2, 2;
     2, 3;
     3, 1];

## detectmovement.m
to calculate the detectable movement of a magnet under specific adc-bit

----------------------------------------------------------------------------------------------
i will change all variable names in uniform. (variable names in every sub-functions do not changed) So that the followers will use the code easily




-------------------------------------------------------------------------------------------------------------------------------------
## 03.03.2020
I wrote a funtion generateMFD.m to generate the detected MFD of 25 Sensors at a specific (gaven) Orientation.
I rewrite the function randpoints.m. The strategy of generating Random Points is changed. If  there is a NaN in MFD, that means the Magnet collides with the Bottom-Plane of the Workspace. Then the point will be discarded, and try to generate another point.
I changed some names of variables
I did another 2 Experiments.
The one is that, the test points homogenous distribute on the Plane w3 = 0.05 in the whole workspace (w1,w2 in (-0.05,0.05)).
The other is that, the test points homogenous distribute on a Plane w3 within a Segment (among 4 adjecent sensors, w1,w2 in (0,0.025))

## generatMFD.m
to calculate the detected signals by 25 sensors at a specific (gaven) Orientation of the Magnet.



