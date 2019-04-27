import cv2
import numpy as np
from field_detector import FieldDetector
from darknet import PlayerDetector
from classifier import Classifier
from drawer import Drawer
from vanishing_point import get_offside_line, get_vanishing_point
from player_tracker import PlayerTracker
import math
import click

YOLO_FRAME_PERIOD = 20

@click.command()
@click.option("--input_video", default='video', help="Name of video to process", show_default=True)
@click.option("--start_frame", default=0, help="Start frame", show_default=True)
@click.option("--end_frame", default=10, help="End frame", show_default=True)
@click.option("--vp_validation", default=False, help="Validate vanishing point using the last vp calculated",
              show_default=True)
@click.option("--debug", default=True, help="Should display debug info", show_default=True)
def main(input_video, start_frame, end_frame, vp_validation, debug):
    field_detector = FieldDetector()
    classifier = Classifier()
    drawer = Drawer()
    player_detector = PlayerDetector()
    player_tracker = PlayerTracker()

    cap = cv2.VideoCapture('./videos/{}.mp4'.format(input_video))
    out = cv2.VideoWriter('./videos/output-{}.mp4'.format(input_video), 0x7634706d, 30.0, (1280, 720))

    if not cap.isOpened():
        raise Exception('Video cound not be opened')

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
            ## si el vp cambio mucho, entonces probablemente sea un outlier. Mejor usar el ultimo vp calculado. Esto asume que el primer vp es 'bueno'.
            if math.sqrt((vp[0] - vp_copy[0]) ** 2 + (vp[1] - vp_copy[1]) ** 2) > 100:
                if vp_validation:
                    vp = vp_copy
        vp_copy = vp

        # frame = field_detector.detect_field(frame, first_vp)

        if frame_index % YOLO_FRAME_PERIOD == 0:
            players_bbs = player_tracker.detect_with_yolo(frame)
            classifier.restart()
            classifier.process(players_bbs, frame)
            teams = classifier.get_teams(referee=0)
            drawer.draw_all_players(players_bbs, teams, frame)
            out.write(frame)
            continue

        bounding_boxes = player_tracker.update(frame)
        for idx, bb in enumerate(bounding_boxes):
            if bb is not None and teams[idx] is not None:
                x, y, w, h = bb
                drawer.draw_player(frame, (int(x + w / 2), int(y + h / 2), w, h), teams[idx])

        leftmost_player = player_tracker.get_leftmost_player(bounding_boxes, vp)

        offside_line = get_offside_line(vp, leftmost_player)
        if offside_line is not None:
            # cv2.line(frame, offside_line[0],offside_line[1],(255,255,0),2) ## TODO: usar esto cuando ande bien
            cv2.line(frame, vp, leftmost_player, (255, 255, 0), 2)

        out.write(frame)
        if debug: print('frame: ' + str(frame_index) + ' processed')
        continue

    cap.release()
    out.release()
    cv2.destroyAllWindows()


if __name__ == "__main__":
    main()
