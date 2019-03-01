
from matplotlib import pyplot as plt
import numpy as np
import cv2 as cv2

def imshow_components(labels):
  # Map component labels to hue val
  label_hue = np.uint8(179*labels/np.max(labels))
  blank_ch = 255*np.ones_like(label_hue)
  labeled_img = cv2.merge([label_hue, blank_ch, blank_ch])

  # cvt to BGR for display
  labeled_img = cv2.cvtColor(labeled_img, cv2.COLOR_HSV2BGR)

  # set bg label to black
  labeled_img[label_hue==0] = 0

  cv2.imshow('labeled.png', labeled_img)
  cv2.waitKey()

# leo imagen
img = cv2.imread('images/test_img.png');

# la paso a blanco y negro, y detecto bordes con Canny
gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
edges = cv2.Canny(gray,100,200,apertureSize = 3)

cv2.imshow('canny', edges)
cv2.waitKey(0)

# busco linea de lateral para cortar publico
lines = cv2.HoughLines(edges,1,np.pi/180,600)
maxRho = -1;
for line in lines:
  print(line)
  for rho,theta in line:
    if abs(theta - 1.57) > 1:
      continue

    if maxRho < rho:
      maxRho = rho
    a = np.cos(theta)
    b = np.sin(theta)
    x0 = a*rho
    y0 = b*rho
    x1 = int(x0 + 1000*(-b))
    y1 = int(y0 + 1000*(a))
    x2 = int(x0 - 1000*(-b))
    y2 = int(y0 - 1000*(a))

    cv2.line(img,(x1,y1),(x2,y2),(0,0,255),1)
    cv2.imshow('img', img)
    cv2.waitKey(0)

print(int(maxRho));

# pinto de negro toda la parte de la imagen superior a la recta encontrada (aca asumo que el publico se ve arriba, podrian hacerse los casos analogos para cuando el publico se ve abajo)
img[0:int(maxRho), 0:(img.shape[1]-1)] = 0;

cv2.imshow('img', img)
cv2.waitKey(0)


rgbColor = np.uint8([[[0,255,0]]])
hsvColor = cv2.cvtColor(rgbColor, cv2.COLOR_BGR2HSV)
sensitivity = 20;
COLOR_MIN = np.array([hsvColor[0][0][0] - sensitivity, 100, 70])
COLOR_MAX = np.array([hsvColor[0][0][0] + sensitivity, 255, 255])

hsv_img = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)
frame_threshed = cv2.inRange(hsv_img, COLOR_MIN, COLOR_MAX)

cv2.imshow('frame_threshed', frame_threshed)
cv2.waitKey(0)

# Mask used to flood filling.
# Notice the size needs to be 2 pixels than the image.
h, w = frame_threshed.shape[:2]
mask = np.zeros((h+2, w+2), np.uint8)
 
im_floodfill = frame_threshed.copy()

# Floodfill from point (0, 0)
cv2.floodFill(im_floodfill, mask, (0,0), 255);

# Invert floodfilled image
im_floodfill_inv = cv2.bitwise_not(im_floodfill)

# Combine the two images to get the foreground.
im_out = frame_threshed | im_floodfill_inv

# cv2.imshow('img', img)
cv2.imshow('mask', im_out)
cv2.waitKey(0)

# ret, labels = cv2.connectedComponents(im_out)

# imshow_components(labels)

contours, hierarchy = cv2.findContours(im_out,cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)

minX = 999999999
maxX = -1
minY = 999999999
maxY = -1
for c in contours:
  x,y,w,h = cv2.boundingRect(c)
  
  if x < minX:
    minX = x
  
  if x + w > maxX:
    maxX = x + w

  if y < minY:
    minY = y

  if y + h > maxY:
    maxY = y + h

  cv2.drawContours(img, [c], 0, (0,255,0), 3)
  cv2.imshow('box', img)
  cv2.waitKey(0)

cv2.rectangle(img,(minX,minY),(maxX,maxY),COLOR_MAX,2)

cv2.imshow('box', img)
cv2.waitKey(0)

# cv2.waitKey(0)
# cv2.destroyAllWindows()