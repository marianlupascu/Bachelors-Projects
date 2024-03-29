

# M&M Sorter

:link: [The list of necessary items](https://docs.google.com/spreadsheets/d/1_GYeWjBXVv_4aekasxN6_g4DxXadq2Kq5P1_7F1olAA/edit#gid=1109858318), and documentation is in romanian.

[![Video Link](http://intranet.tuck.dartmouth.edu/assets/img/tc-img-grid-video.png)](https://drive.google.com/open?id=1Tku_jSl2cBDdhYhFvjOPgxOAxMOkLSOl)

<div style="float: left;">
  <img src="4.jpg" width="49%"/>
  <img src="5.jpg" width="49%"/>
</div>

<div style="float: left;">
  <img src="6.jpg" width="99%"/>
</div>

<div style="float: left;">
  <img src="1.jpg" width="33%"/>
  <img src="2.jpg" width="33%"/>
  <img src="3.jpg" width="33%"/>
</div>

## Information :page_facing_up:
1. Initially, colored candies are held in a charger and fall in turn (they are taken over by a stepper-motor).
2. Then it is analyzed by the color sensor that detects its color.
3. Then the servomotor picks up the candy, rotates to the candy color container.
 ### More detailed :pencil:
 Sorting is done in 2 stages, namely: the first stage, which involves the sorting of yellow and brown colors, and the remaining candy will be put in all the recipes, then if they are 5 consecutive rows in the color sensor the absence of the bumble beans can pass at Stage 2, alerting the user by moving the redistribution bridge of the candy 5 times. 
	Step 2 involves sorting the other three colors: red, green and blue. :boom:
	
### Note :crystal_ball:   
**I recommend** the use of a black or dark colored surface under the M & M Sorter.

## Used components :gem:
* 1 x robotlinking uno r3
* 1 x breadboard
* 2 x servo-motor
* 1 x color-sensor
* jumper wire
* 1 x F-M cable
## Bugs :bug:
* It may happen that the candy remain stuck on the original collection tube.
* It can happen that candy remain stuck on the distribution bridge.
