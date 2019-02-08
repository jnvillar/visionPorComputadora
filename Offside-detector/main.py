import numpy as np
from matplotlib import pyplot as plt
import cv2

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

	ret, frame = cap.read()
	if ret==False:
		break

	if frame_index==start_frame:
		#cv2.imshow('frame',frame)
		plt.imshow(frame)
		points = plt.ginput(100, show_clicks=True)
		assert len(points)%2==0, 'Points count should be pair'
		print(points)
		m = [0]*(len(points)/2)
		c = [0]*(len(points)/2)
		k = 0
		vp = np.array([0,0])
		for j in range(0,len(points), 2):
			m[k] = (points[j+1][1] - points[j][0])/ (points[j+1][0] - points[j][0]) 		## TODO: ver si esta bien el eje x y el eje y
			c[k] = -points[j][0] * m[k] + points[j][1]
			k += 1
		count = 0
		for p in range(len(points)/2):
			for q in range(p+1, len(points)/2):
				count = count + 1
				A = np.array([[-m[p],1], [-m[q],1]])
				b = np.array([c[p], c[q]])
				vp = vp + np.linalg.inv(A).dot(b)
		vp = np.divide(vp, count)
		vp = np.around(vp)

		xs = [283, vp[0]]
		ys = [501, vp[1]]
		plt.plot(xs,ys,linewidth=2)
		raw_input("Press Enter to exit")
		break


cap.release()
out.release()

cv2.destroyAllWindows()