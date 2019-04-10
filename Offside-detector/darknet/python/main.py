import numpy as np
from matplotlib import pyplot as plt
import cv2
from darknet import PlayerDetector


def intersection(line1, line2):
	p1, p2, p3, p4 = line1['p1'], line1['p2'], line2['p1'], line2['p2']
	x = ((p1[0]*p2[1] - p1[1]*p2[0]) * (p3[0]-p4[0]) - (p1[0]-p2[0]) * (p3[0]*p4[1] - p3[1]*p4[0])) / ((p1[0]-p2[0]) * (p3[1]-p4[1]) - (p1[1]-p2[1]) * (p3[0]-p4[0]))
	y = ((p1[0]*p2[1] - p1[1]*p2[0]) * (p3[1]-p4[1]) - (p1[1]-p2[1]) * (p3[0]*p4[1] - p3[1]*p4[0])) / ((p1[0]-p2[0]) * (p3[1]-p4[1]) - (p1[1]-p2[1]) * (p3[0]-p4[0]))
	return (x,y)


cap = cv2.VideoCapture('../video.mp4')

out = cv2.VideoWriter('../output.mp4', 0x7634706d, 30.0, (1280,720))

if (not cap.isOpened()):
	raise Exception('Video cound not be opened')

#player_detector = PlayerDetector()

start_frame = 0
end_frame = 100
for frame_index in range(0, end_frame):
	print(frame_index)
	if frame_index<start_frame:
		continue

	ret, frame = cap.read()
	if ret==False:
		break

	if frame_index==start_frame:
		

		### Deteccion linea offside
		'''
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
		raw_input("Press Enter to continue")
		'''
		
		### Deteccion jugadores
		
		#yolo_img = player_detector.open_img(frame)
		#res = player_detector.detect_players(yolo_img)
		res = [('person', 0.9896788001060486, (367.18341064453125, 437.80145263671875, 38.514793395996094, 69.6651611328125)), ('person', 0.9813730120658875, (291.6535949707031, 585.266357421875, 47.23373031616211, 89.79061889648438)), ('person', 0.9451802372932434, (1184.445068359375, 438.14361572265625, 27.63399887084961, 70.66059875488281)), ('person', 0.9427978992462158, (613.549072265625, 310.98052978515625, 28.87258529663086, 47.110721588134766)), ('person', 0.9319689273834229, (1070.2806396484375, 212.15728759765625, 16.6505184173584, 33.18511962890625)), ('person', 0.9279605746269226, (298.9461669921875, 471.6380310058594, 60.612213134765625, 70.96109008789062)), ('person', 0.8941689133644104, (917.6439208984375, 270.20245361328125, 17.11932373046875, 29.22058868408203)), ('person', 0.8926199078559875, (1047.6141357421875, 487.6801452636719, 26.599294662475586, 70.4723892211914)), ('person', 0.8923733830451965, (688.3287353515625, 300.20904541015625, 17.36338233947754, 54.863426208496094)), ('person', 0.8835442066192627, (1109.42041015625, 202.57579040527344, 17.15543556213379, 30.07115936279297)), ('person', 0.8802978992462158, (828.4103393554688, 457.4922180175781, 54.69183349609375, 60.64540100097656)), ('person', 0.8713310360908508, (856.3143920898438, 386.87445068359375, 37.859336853027344, 45.99755096435547)), ('person', 0.7614070773124695, (1156.033203125, 520.988525390625, 39.83382034301758, 65.85809326171875)), ('person', 0.7554710507392883, (530.2201538085938, 142.78485107421875, 15.13008975982666, 29.750947952270508)), ('person', 0.5962433218955994, (896.7042236328125, 295.4379577636719, 25.71770477294922, 46.1233024597168)), ('person', 0.5799990296363831, (697.3583374023438, 355.2196044921875, 1133.34765625, 631.6737670898438))]
		res = [r for r in res if r[1] > 0.6] 
		
		frame_copy = frame.copy()
		### TODO: filtras detecciones con poca probabilidad (o que no sean personas)
		print(res)
		for bb in res:
			bounding_box = bb[2]
			x = int(bounding_box[0])
			y = int(bounding_box[1])
			w = int(bounding_box[2]/2)
			h = int(bounding_box[3]/2)

			cv2.rectangle(frame_copy, (x-w, y-h), (x + w, y + h), (0, 0, 255), 2)
		cv2.imshow('img', frame_copy)
		cv2.waitKey(0)
		
		prev_img = frame

		continue

	img = frame
	plt.imshow(frame)
	left_most = 9999
	for i in range(len(res)):
		BB = res[i][2]
		x = int(BB[0])
		y = int(BB[1])
		w = int(BB[2]/2)
		h = int(BB[3]/2)
		print(x,y,w,h)

		prev_img_gray = cv2.cvtColor(prev_img, cv2.COLOR_BGR2GRAY)
		bounding_box_gray = prev_img_gray[y:y+h, x:x+w]

		feature_params = dict( maxCorners = 10,
			qualityLevel = 0.01,
			minDistance = 1
		)
		points_gf = cv2.goodFeaturesToTrack(bounding_box_gray, **feature_params)
		
		if len(points_gf) == 0:
			print('ERROR in points here')
			continue
		
		points = np.array(points_gf, dtype=np.float32)+np.array([x,y], dtype=np.float32)
		print(points)
		
		for i in points:
			p_x,p_y = i.ravel()
			#cv2.circle(prev_img,(p_x,p_y),3,255,-1)
		#cv2.imshow('img', prev_img)
		#raw_input("Press Enter to continue")

		
		lk_params = dict(
			winSize  = (max(h,w), max(h,w)),  
			maxLevel = 2,   
			criteria = (cv2.TERM_CRITERIA_EPS | cv2.TERM_CRITERIA_COUNT, 10, 0.03)
		) ## revisar estos parametros

		
		img_gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
		#img_points = cv2.goodFeaturesToTrack(img_gray[y:y+h, x:x+w], **feature_params)
		#img_points = np.int0(img_points)+[x,y]
		
		
		p1, st, err = cv2.calcOpticalFlowPyrLK(prev_img_gray, img_gray, points, None, **lk_params)
		#print(flow_res)
		#print('\n')
		#mean_x = np.mean(flow_res[0][0][:,0])
		#mean_y = np.mean(flow_res[0][0][:,1])
		#new_bounding_box = (int(mean_x - w/2), int(mean_y - h/2), w, h)
		#res[i][2] = new_bounding_box
		mask = np.zeros_like(prev_img)
		good_new = p1[st==1]
		good_old = points_gf[st==1]
		for i,(new,old) in enumerate(zip(good_new,good_old)):
			a,b = new.ravel()
			c,d = old.ravel()
			mask = cv2.line(mask, (a,b),(c,d), 5, 2)
			frame = cv2.circle(frame,(a,b),5,5,-1)
		img = cv2.add(frame,mask)
		cv2.imshow('frame',img)
		

		#cv2.rectangle(img, new_bounding_box, 2) 
		'''
		if Team_Ids(i)==0:
			plt.annotate(BB[0]-2, BB[1]-2, 'D_T')
		if Team_Ids(i)==1:
			plt.annotate(BB[0]-2, BB[1]-2, 'A_T')
		'''

		#Calculating the last defender on the left side using vanishing point. Same can be done symmetrically to the right hand side as well.
		'''
		x1 = floor(BB[0] + BB[2]/2)
		y1 = floor(BB[1] + BB[3])
		ly = len(img)
		
		slope = (vp[1] - y1)/(vp[0] - x1);
		y_int = - x1 * slope + y1;
		lx = (ly - y_int)/slope;
		
		if lx<left_most and Team_Ids[i] == 0:
			left_most = lx
		'''
		

	#plt.plot([left_most,vp[0]],[ly ,vp[1]])
	cv2.imshow('img', frame)
	cv2.waitKey(0)
	continue


cap.release()
out.release()

cv2.destroyAllWindows()