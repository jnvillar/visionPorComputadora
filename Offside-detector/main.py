import cv2
import numpy as np
from field_detector import FieldDetector
from darknet import PlayerDetector
from classifier import Classifier
from drawer import Drawer
from matplotlib import pyplot as plt
from vanishing_point import get_offside_line, get_vanishing_point
from player_tracker import PlayerTracker
import math

field_detector = FieldDetector()
classifier = Classifier()
drawer = Drawer()
player_detector = PlayerDetector()
player_tracker = PlayerTracker()
debug = True
yolo_in_frames = 20


def intersection(line1, line2):
    p1, p2, p3, p4 = line1['p1'], line1['p2'], line2['p1'], line2['p2']
    x = ((p1[0] * p2[1] - p1[1] * p2[0]) * (p3[0] - p4[0]) - (p1[0] - p2[0]) * (p3[0] * p4[1] - p3[1] * p4[0])) / (
            (p1[0] - p2[0]) * (p3[1] - p4[1]) - (p1[1] - p2[1]) * (p3[0] - p4[0]))
    y = ((p1[0] * p2[1] - p1[1] * p2[0]) * (p3[1] - p4[1]) - (p1[1] - p2[1]) * (p3[0] * p4[1] - p3[1] * p4[0])) / (
            (p1[0] - p2[0]) * (p3[1] - p4[1]) - (p1[1] - p2[1]) * (p3[0] - p4[0]))
    return (x, y)

def get_leftmost_player(bounding_boxes, vanishing_point):
    leftmost_player = None
    for i in range(len(bounding_boxes)):
        if bounding_boxes[i] is None:
            continue
        (x, y, w, h) = bounding_boxes[i]
        # Asumo que atacan para la izquierda
        p = (x,y+h)
        if leftmost_player is None:
            leftmost_player = p
        direction = (p[0]-vanishing_point[0])*(leftmost_player[1]-vanishing_point[1])-(p[1]-vanishing_point[1])*(leftmost_player[0]-vanishing_point[0])
        if direction < 0:
            leftmost_player = p
    return leftmost_player

INPUT_VIDEO_NAME = 'pity'
cap = cv2.VideoCapture('./videos/{}.mp4'.format(INPUT_VIDEO_NAME))
out = cv2.VideoWriter('./videos/output-{}.mp4'.format(INPUT_VIDEO_NAME), 0x7634706d, 30.0, (1280, 720))

if not cap.isOpened():
    raise Exception('Video cound not be opened')

start_frame = 200
end_frame = 400
player_trackers = []

for frame_index in range(0, end_frame):

    ret, frame = cap.read()
    if frame_index < start_frame:    
        continue

    if ret == False:
        break
    
    vp = get_vanishing_point(frame)

    if frame_index == start_frame:
        first_vp = vp
    else:
        if math.sqrt((vp[0]-vp_copy[0])**2+(vp[1]-vp_copy[1])**2) > 100:
            #vp = vp_copy
            pass
    vp_copy = vp

    #frame = field_detector.detect_field(frame, first_vp)

    if frame_index % yolo_in_frames == 0:
        
        yolo_img = player_detector.open_img(frame)
        res = player_detector.detect_players(yolo_img)
        if debug: print("yolo: players detected")
        res = [r for r in res if r[1] > 0.6]
        res = [r for r in res if r[2][3] < 200]

        player_tracker.load_players(frame, res)
        classifier.restart()
        for i in range(len(res)):
            bb = res[i]
            bounding_box = bb[2]

            if player_tracker.should_track_player(frame, bounding_box):
                classifier.classify(bounding_box, frame)

        t1, t2 = classifier.get_teams(referee=0)

        drawer.draw_team(frame, t1, (0, 0, 255))
        drawer.draw_team(frame, t2, (0, 255, 0))


        out.write(frame)
        continue

    bounding_boxes = player_tracker.update(frame)
    for bb in bounding_boxes:
        if bb is not None:
            x,y,w,h = bb
            cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)


    leftmost_player = get_leftmost_player(bounding_boxes, vp)
    ## TODO: use this
    offside_line = get_offside_line(vp, leftmost_player)
    if offside_line is not None:
        cv2.line(frame, vp,leftmost_player,(255,255,0),2)

    out.write(frame)
    if debug: print('frame: ' + str(frame_index) + ' processed')
    continue

cap.release()
out.release()
cv2.destroyAllWindows()
