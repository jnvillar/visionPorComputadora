import cv2
from multiprocessing import Pipe
from threading import Thread
from concurrent.futures.thread import ThreadPoolExecutor

BOUNDING_BOX_END_LIMIT = 100
CSRT_PARAMS = cv2.FileStorage("CSRT_params.json", cv2.FileStorage_READ)
KCF_PARAMS = cv2.FileStorage("KCF_params.json", cv2.FileStorage_READ)
RANDOM_FIELD_POINT = (280,501)

class PlayerTracker:

    def __init__(self, debug=False):
        self.debug = debug
        self.player_trackers = []

    def _update_bounding_box(self, frame, tracker, send_end):
        send_end.send(tracker.update(frame))

    def load_players(self, frame, bounding_boxes):
        self.player_trackers = []

        for i in range(len(bounding_boxes)):
            bb = bounding_boxes[i]
            bounding_box = bb[2]
            x = int(bounding_box[0])
            y = int(bounding_box[1])
            w = int(bounding_box[2]/2)
            h = int(bounding_box[3]/2)
            

            tracker = cv2.TrackerCSRT_create()
            #tracker.read(CSRT_PARAMS.getFirstTopLevelNode())
            tracker.init(frame, (x-w, y-h, w*2, h*2))
            self.player_trackers.append(tracker)

    def update(self, frame):
        with ThreadPoolExecutor(max_workers=22) as executor:
            pipe_list = []
            #start_time = datetime.datetime.now()
            for tracker in self.player_trackers:
                
                recv_end, send_end = Pipe(False)
                executor.submit(self._update_bounding_box, frame, tracker, send_end)
                pipe_list.append(recv_end)
        

        
        updated_boxes = [x.recv() for x in pipe_list]
        
        
        player_track_to_remove = []
        bounding_boxes = []
        for i in range(len(updated_boxes)):
            (success, box) = updated_boxes[i]
            if success:
                (x, y, w, h) = [int(v) for v in box]
                ## Saco a los jugadores que estan muy cerca del borde
                if not self.should_track_player(frame, (x, y, w, h)):
                    player_track_to_remove.append(i)
                    bounding_boxes.append(None)
                else:
                    bounding_boxes.append((x, y, w, h))
            else:
                player_track_to_remove.append(i)
                bounding_boxes.append(None)
        
        
        self.player_trackers = [tracker for i, tracker in enumerate(self.player_trackers) if i not in player_track_to_remove]
        return bounding_boxes

    def should_track_player(self, frame, bounding_box):
        heigth, width = frame.shape[:2]
        (x, y, w, h) = bounding_box
        return not (width-x < BOUNDING_BOX_END_LIMIT or x < BOUNDING_BOX_END_LIMIT)
    

