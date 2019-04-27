import numpy as np
import cv2


def _intersection(line1, line2):
	p1, p2, p3, p4 = line1['p1'], line1['p2'], line2['p1'], line2['p2']
	x = ((p1[0]*p2[1] - p1[1]*p2[0]) * (p3[0]-p4[0]) - (p1[0]-p2[0]) * (p3[0]*p4[1] - p3[1]*p4[0])) / ((p1[0]-p2[0]) * (p3[1]-p4[1]) - (p1[1]-p2[1]) * (p3[0]-p4[0]))
	y = ((p1[0]*p2[1] - p1[1]*p2[0]) * (p3[1]-p4[1]) - (p1[1]-p2[1]) * (p3[0]*p4[1] - p3[1]*p4[0])) / ((p1[0]-p2[0]) * (p3[1]-p4[1]) - (p1[1]-p2[1]) * (p3[0]-p4[0]))
	return (x,y)

def _get_full_line(p1, p2):
	slope = (p2[1]-p1[1])/float(p2[0]-p1[0])
	init_img = [10000,10000]
	end_img = [-10000,-10000]

	init_img[1] = int(-(p1[0]-init_img[0]) * slope + p1[1])
	end_img[1] = int(-(p2[0]-end_img[0]) * slope + p2[1])
	return tuple(init_img), tuple(end_img)


def _same_lines(line1, line2):
	rho1,theta1 = line1
	rho2,theta2 = line2
	return abs(rho1-rho2) < 20 and abs(theta1-theta2) < 0.1
	

def get_vanishing_point(frame):
	gray_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
	blur_gray = cv2.GaussianBlur(gray_frame,(5, 5),0)

	sobelx = cv2.Sobel(blur_gray,cv2.CV_8U,1,0,ksize=-1)

	lines = cv2.HoughLines(sobelx,1,np.pi/180,200)

	parallel_lines = []
	i = 0
	j = 0

	for j in range(len(lines)):
		for i in range(len(lines[j])):
			if len(parallel_lines) == 2:
				break
			rho,theta = lines[j][i]
			if not (len(parallel_lines) == 1 and _same_lines(lines[j][i], (first_rho,first_theta))):
				a = np.cos(theta)
				b = np.sin(theta)
				x0 = a*rho
				y0 = b*rho
				x1 = int(x0 + 1000*(-b))
				y1 = int(y0 + 1000*(a))
				x2 = int(x0 - 1000*(-b))
				y2 = int(y0 - 1000*(a))	

				first_rho, first_theta = rho,theta
				parallel_lines.append({'p1': (x1,y1), 'p2': (x2,y2)})
				try:
					if len(parallel_lines) == 2 and _intersection(parallel_lines[0], parallel_lines[1])[1] > 0:
						parallel_lines.pop()
				except:
					## lines are parallel
					parallel_lines.pop()

		
	x1,y1 = parallel_lines[0]['p1']
	x2,y2 = parallel_lines[0]['p2']
	#cv2.line(frame,(x1,y1),(x2,y2),(0,0,255),2)

	x1,y1 = parallel_lines[1]['p1']
	x2,y2 = parallel_lines[1]['p2']
	#cv2.line(frame,(x1,y1),(x2,y2),(0,0,255),2)

	vanishing_point = _intersection(parallel_lines[0], parallel_lines[1])
	return vanishing_point



def get_offside_line(vanishing_point, leftmost_player_position):
	offside_line = None
	try:
		if leftmost_player_position is None:
			return None
		offside_line = _get_full_line(vanishing_point, leftmost_player_position)
	except Exception as e:
		print('Get offside line failed', e)
	return offside_line


