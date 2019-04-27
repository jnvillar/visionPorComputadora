import cv2
import numpy as np


class Classifier:

    def __init__(self):
        self.player_histograms = []
        self.buckets_per_color = 200

    def restart(self):
        self.player_histograms = []

    def classify(self, bounding_box, frame):
        player_histogram = self.calculate_histogram(frame, bounding_box)
        self.player_histograms.append(player_histogram)

    def _is_grass(self, pixel):
        rgbColor = np.uint8([[[0,255,0]]])
        hsvColor = cv2.cvtColor(rgbColor, cv2.COLOR_BGR2HSV)
        sensitivity = 20;
        COLOR_MIN = np.array([hsvColor[0][0][0] - sensitivity, 100, 70])
        COLOR_MAX = np.array([hsvColor[0][0][0] + sensitivity, 255, 255])

        
        pixel = cv2.cvtColor(np.uint8([[[pixel[0],pixel[1],pixel[2]]]]), cv2.COLOR_BGR2HSV)
        return COLOR_MIN[0] <= pixel[0][0][0] <= COLOR_MAX[0]

    def calculate_mask(self, frame, bounding_box):
        mask = np.zeros(frame.shape[:2], np.uint8)

        x = int(bounding_box[0])
        y = int(bounding_box[1])
        w = int(bounding_box[2])
        h = int(bounding_box[3])

        initial_x = int(x - (w / 2))
        initial_y = int(y - (h / 2))

        mask[initial_y: initial_y + h, initial_x: initial_x + w] = 255
        for j in range(initial_y, initial_y + h):
            for i in range(initial_x, initial_x + w):
                if self._is_grass(frame[j,i]):
                    mask[j,i] = 0
        return mask

    def calculate_histogram(self, frame, bounding_box):
        mask = self.calculate_mask(frame, bounding_box)
        hsv_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
        h1 = cv2.calcHist([hsv_frame], [1], mask, [255], [0, 255])
        
        return {'h': h1, 'bb': bounding_box}

    def histogram_distance(self, h1, h2):
        diff = cv2.compareHist(h1['h'], h2['h'], method=cv2.HISTCMP_CHISQR)
        return diff

    def max_histogram_diff(self, histogram, players_histograms):
        max_distance = 0
        i = 0
        for idx, player_histogram in enumerate(players_histograms):
            distance = self.histogram_distance(histogram, player_histogram)
            if distance > max_distance:
                max_distance = distance
                i = idx
        return i

    def calculate_distances(self, player_histograms):
        players = len(player_histograms)
        distances = np.zeros((players, players))
        in_process = 0
        for player_hh in player_histograms:
            next = in_process + 1
            while next < players:
                distance = self.histogram_distance(player_hh, player_histograms[next])
                distances[in_process, next] = distance
                distances[next, in_process] = distance
                next += 1
            in_process += 1
        return distances

    def max_difference(self, matrix):
        max_i = 0
        max_j = 0
        max = 0
        for i in range(len(matrix)):
            for j in range(len(matrix)):
                if max < matrix[i, j]:
                    max_i = i
                    max_j = j
                    max = matrix[i, j]
        return max_i, max_j

    def difference_with_others(self, i, distances):
        sum = 0
        for x in range(len(distances)):
            sum += distances[i][x]
        return sum

    def max_distance_with_others(self, distances):
        i = 0
        max = 0
        for p in range(len(distances)):
            dist = self.difference_with_others(p, distances)
            if max < dist:
                max = dist
                i = p
        return i

    def delete_referees(self, referees, distances, players_bb):
        for _ in range(referees):
            i = self.max_distance_with_others(distances)
            for p in range(len(distances)):
                distances[i][p] = 0
            players_bb.pop(i)
        return players_bb


    def get_teams(self, referee = 0):
        try:
            players_bb = list(self.player_histograms)
            distances = self.calculate_distances(players_bb)

            players_bb = self.delete_referees(referee, distances, players_bb)
            distances = self.calculate_distances(players_bb)

            player_one_i, player_two_j = self.max_difference(distances)

            if np.argmax(players_bb[player_one_i]['h']) < np.argmax(players_bb[player_two_j]['h']):     ## para intentar ser consistentes y elegir siempre los mismos colores para cada equipo
                team_one = [players_bb[player_one_i]]
                team_two = [players_bb[player_two_j]]
            else:
                team_two = [players_bb[player_one_i]]
                team_one = [players_bb[player_two_j]]

            players_bb.pop(player_one_i)
            players_bb.pop(player_two_j-1)

            for idx, player_histogram in enumerate(players_bb):
                d1 = self.histogram_distance(team_one[0], player_histogram)
                d2 = self.histogram_distance(team_two[0], player_histogram)
                if d1 < d2:
                    team_one.append(players_bb[idx])
                else:
                    team_two.append(players_bb[idx])

            team_one = [player['bb'] for player in team_one]
            team_two = [player['bb'] for player in team_two]
        except Exception as e:
            print('Team classifier failed', e)
            team_one, team_two = [], []            

        return [0 if player['bb'] in team_one else 1 if player['bb'] in team_two else None for player in self.player_histograms]
