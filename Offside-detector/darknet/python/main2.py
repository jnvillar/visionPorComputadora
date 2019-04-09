
import cv2
from darknet import PlayerDetector
from imutils.video import FPS
from classifier import Classifier

def intersection(line1, line2):
	p1, p2, p3, p4 = line1['p1'], line1['p2'], line2['p1'], line2['p2']
	x = ((p1[0]*p2[1] - p1[1]*p2[0]) * (p3[0]-p4[0]) - (p1[0]-p2[0]) * (p3[0]*p4[1] - p3[1]*p4[0])) / ((p1[0]-p2[0]) * (p3[1]-p4[1]) - (p1[1]-p2[1]) * (p3[0]-p4[0]))
	y = ((p1[0]*p2[1] - p1[1]*p2[0]) * (p3[1]-p4[1]) - (p1[1]-p2[1]) * (p3[0]*p4[1] - p3[1]*p4[0])) / ((p1[0]-p2[0]) * (p3[1]-p4[1]) - (p1[1]-p2[1]) * (p3[0]-p4[0]))
	return (x,y)


cap = cv2.VideoCapture('../video.mp4')
out = cv2.VideoWriter('../output.mp4', 0x7634706d, 30.0, (1280,720))
classifier = Classifier()

if (not cap.isOpened()):
	raise Exception('Video cound not be opened')

player_detector = PlayerDetector()

start_frame = 0
end_frame = 100
for frame_index in range(0, 1):
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
		
		yolo_img = player_detector.open_img(frame)
		res = player_detector.detect_players(yolo_img)
		
		res = [r for r in res if r[1] > 0.6] 
		
		frame_copy = frame.copy()
		### TODO: filtras detecciones con poca probabilidad (o que no sean personas)
		print(res)
		#for bb in res:
		player_trackers = []

		for i in range(len(res)):
			bb = res[i]
			bounding_box = bb[2]

			x = int(bounding_box[0])
			y = int(bounding_box[1])
			w = int(bounding_box[2]/2)
			h = int(bounding_box[3]/2)
			
			tracker = cv2.TrackerCSRT_create()
			tracker.init(frame, (x-w, y-h, w*2, h*2))
			player_trackers.append(tracker)

			#cv2.rectangle(frame_copy, (x-w, y-h), (x + w, y + h), (0, 0, 255), 2)
			classifier.classify(bounding_box, frame_copy)

		t1, t2 = classifier.get_teams()
		print(len(t1))
		print(len(t2))
		for b in t1:
			x = int(b[0])
			y = int(b[1])
			w = int(b[2] / 2)
			h = int(b[3] / 2)
			cv2.rectangle(frame_copy, (x - w, y - h), (x + w, y + h), (0, 0, 255), 2)
		for b in t2:
			x = int(b[0])
			y = int(b[1])
			w = int(b[2] / 2)
			h = int(b[3] / 2)
			cv2.rectangle(frame_copy, (x - w, y - h), (x + w, y + h), (0, 255, 0), 2)

		cv2.imshow('img', frame_copy)
		cv2.waitKey(0)
		
		fps = FPS().start()

		prev_img = frame

		continue

	
	
	

	# if the 's' key is selected, we are going to "select" a bounding
	# box to track
	
	# select the bounding box of the object we want to track (make
	# sure you press ENTER or SPACE after selecting the ROI)
	

	
	# start OpenCV object tracker using the supplied bounding box
	# coordinates, then start the FPS throughput estimator as well
	


	for i in range(len(player_trackers)):

		
		(img_h, img_w) = frame.shape[:2]
		(success, box) = player_trackers[i].update(frame)
		if success:
			(x, y, w, h) = [int(v) for v in box]
			cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
	fps.update()
	fps.stop()
		

	#plt.plot([left_most,vp[0]],[ly ,vp[1]])
	#cv2.imshow('img', frame)
	out.write(frame)
	continue


cap.release()
out.release()

cv2.destroyAllWindows()