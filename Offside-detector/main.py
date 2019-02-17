import numpy as np
from matplotlib import pyplot as plt
import cv2



def intersection(line1, line2):
	p1, p2, p3, p4 = line1['p1'], line1['p2'], line2['p1'], line2['p2']
	x = ((p1[0]*p2[1] - p1[1]*p2[0]) * (p3[0]-p4[0]) - (p1[0]-p2[0]) * (p3[0]*p4[1] - p3[1]*p4[0])) / ((p1[0]-p2[0]) * (p3[1]-p4[1]) - (p1[1]-p2[1]) * (p3[0]-p4[0]))
	y = ((p1[0]*p2[1] - p1[1]*p2[0]) * (p3[1]-p4[1]) - (p1[1]-p2[1]) * (p3[0]*p4[1] - p3[1]*p4[0])) / ((p1[0]-p2[0]) * (p3[1]-p4[1]) - (p1[1]-p2[1]) * (p3[0]-p4[0]))
	return (x,y)


cap = cv2.VideoCapture('video.mp4')

out = cv2.VideoWriter('output.mp4', 0x7634706d, 30.0, (1280,720))

if (not cap.isOpened()):
	raise Exception('Video cound not be opened')


start_frame = 0
end_frame = 100
for frame_index in range(0, end_frame):
	print(frame_index)
	if frame_index<start_frame:
		continue

	if frame_index>start_frame:
		prev_img = frame
		
	ret, frame = cap.read()

	if ret==False:
		break

	if frame_index==start_frame:
		#cv2.imshow('frame',frame)
		plt.imshow(frame)
		points = plt.ginput(100, show_clicks=True)
		assert len(points)%2==0, 'Points count should be pair'
		assert len(points)>=4, 'Should be at least two lines'

		print(points)
		lines = []
		for i in range(0, len(points), 2):
			line = {'p1': points[i], 'p2': points[i+1]}
			lines.append(line)

		print(lines)

		lines_intersection = []
		for i in range(len(lines)-1):
			intersec = intersection(lines[i], lines[i+1])
			lines_intersection.append(intersec)

		x_intersection = list(map(lambda x: x[0], lines_intersection))
		y_intersection = list(map(lambda x: x[1], lines_intersection))
		vp = (np.median(x_intersection), np.median(y_intersection))
		xs = [283, vp[0]]
		ys = [501, vp[1]]
		plt.plot(xs,ys,linewidth=2)
		raw_input("Press Enter to exit")
		break

	if frame_index>start_frame+1 and frame_index%20 != 0:
		img = frame
		plt.imshow(frame)
		left_most = 9999
		for i in range(len(S)):
			BB = S[i].bounding_box
			if (BB[0]+(BB[2]/2)<115 or BB[0]+(BB[2]/2)>130) and (BB[1]+(BB[3]/2)<990 or BB[1]+(BB[3]/2)>1010):
				if S[i].bounding_box[0]<1:
					S[i].bounding_box[0] = 1;
					BB[0] = S[i].bounding_box[0];

				if(S[i].bounding_box[1]<1):
					S[i].bounding_box[1] = 1;
					BB[1] = S[i].bounding_box[1];

				if(S[i].bounding_box[0]+BB[2]>size(img,2)):
					S[i].bounding_box[2] = size(img,2)-S[i].bounding_box[0];
					BB[2] = S[i].bounding_box[2];

				if(S[i].bounding_box[1]+BB[3]>size(img,1)):
					S[i].bounding_box[3] = size(img,1)-S[i].bounding_box[1];
					BB[3] = S[i].bounding_box[3];

				prev_img_gray = cv2.cvtColor(prev_img, cv2.COLOR_BGR2GRAY)

				points  = cv2.goodFeaturesToTrack(prev_img_gray,S[i].bounding_box)
				#points = detectMinEigenFeatures(rgb2gray(prev_img),'ROI',S(i).BoundingBox);
				if len(points) == 0:
					print('ERROR in points here')
					continue

				plt.plot(prev_img, points.location, marker='+', color='w') ## esto no va a andar asi

				
				lk_params = dict(
					winSize  = (15,15),  
					maxLevel = 2,   
					criteria = (cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 10, 0.03)
				) ## revisar estos parametros

				points, validity, err = cv2.calcOpticalFlowPyrLK(prev_img, img, points, None, **lk_params) ## deberian estar en gris?
				mean_x = np.mean(points[0])
				mean_y = np.mean(points[1])	## esto no esta bien
				S[i].bounding_box[0] = floor(mean_x - BB[2]/2)
				S[i].bounding_box[1] = floor(mean_y - BB[4]/2)
				S[i].bounding_box[2] = BB[2]
				S[i].bounding_box[3] = BB[3]

				plt.plot(img, points[validity], marker='+') ## esto no va a andar asi

				cv2.rectangle(img, [S[i].bounding_box[1],S[i].bounding_box[2],S[i].bounding_box[3],S[i].bounding_box[4]], color='red') ## tampoco va a andar
				if Team_Ids(i)==0:
					plt.annotate(BB[0]-2, BB[1]-2, 'D_T')
				if Team_Ids(i)==1:
					plt.annotate(BB[0]-2, BB[1]-2, 'A_T')
				

				#Calculating the last defender on the left side using vanishing point. Same can be done symmetrically to the right hand side as well.
				x1 = floor(BB[0] + BB[2]/2)
				y1 = floor(BB[1] + BB[3])
				ly = len(img)
				
				slope = (vp[1] - y1)/(vp[0] - x1);
				y_int = - x1 * slope + y1;
				lx = (ly - y_int)/slope;
				
				if lx<left_most and Team_Ids[i] == 0
					left_most = lx

			

		plt.plot([left_most,vp[0]],[ly ,vp[1]])
		continue

cap.release()
out.release()

cv2.destroyAllWindows()