import cv2
from multiprocessing import Pipe
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

    def get_leftmost_player(self, bounding_boxes, vanishing_point):
        leftmost_player = None
        for i in range(len(bounding_boxes)):
            if bounding_boxes[i] is None:
                continue
            (x, y, w, h) = bounding_boxes[i]
            # Asumo que atacan para la izquierda
            p = (x, y + h)
            if leftmost_player is None:
                leftmost_player = p
            direction = (p[0] - vanishing_point[0]) * (leftmost_player[1] - vanishing_point[1]) - (
                    p[1] - vanishing_point[1]) * (leftmost_player[0] - vanishing_point[0])
            if direction < 0:
                leftmost_player = p
        return leftmost_player

    def detect_with_yolo(self, frame):
        yolo_img = self.open_img(frame)
        res = self.detect_players(yolo_img)

        if self.debug: print("yolo: players detected")

        res = [r for r in res if r[0] == 'person']
        res = [r for r in res if r[1] > 0.6]
        res = [r for r in res if r[2][3] < 200]  ## si tiene mas de 200 de ancho, entonces no es un jugador.
        res = [r for r in res if self.should_track_player(frame, r[
            2])]  ## si esta muy cerca del borde, no lo tomamos en cuenta

        self.load_players(frame, res)
        return res
    

