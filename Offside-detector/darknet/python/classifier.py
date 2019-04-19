import cv2
import numpy as np
from sklearn.cluster import KMeans
import pandas as pd
from sklearn.decomposition import PCA
from sklearn.mixture import GaussianMixture
from matplotlib import pyplot as plt
class Classifier:

    def __init__(self):
        self.player_histograms = []
        self.buckets_per_color = 200

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
        res = cv2.bitwise_and(frame,frame,mask = mask)
        #cv2.imshow('res', res)
        #equipo = raw_input('continue')

        hsv_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)
        h1 = cv2.calcHist([hsv_frame], [0], mask, [180], [0, 180])
        return {'h': h1, 'bb': bounding_box}

    def histogram_distance(self, h1, h2):
        diff = cv2.compareHist(h1['h'], h2['h'], method=cv2.HISTCMP_INTERSECT)
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
        team_one, team_two = [], []
        
        for player in self.player_histograms:
            player['attrs'] = player['h'].ravel()

        m = [ 0,  6,  8,  9, 10]
        b = [ 1,  3,  4,  5,  7, 11, 12]
        r = [2,13]

        for j,player in enumerate(self.player_histograms):
                    
                histr = player['h']

                col = 'black' if j in m else 'blue' if j in b else 'g'
                plt.subplot(len(self.player_histograms),1,j+1)
                plt.plot(histr, color=col)

                histr_1 = histr[:40]
                histr_2 = histr[80:]
                if j in m:
                    plt.title('player Madrid {}'.format(j), loc='right')
                    print('madrid', np.mean(histr_1), np.mean(histr_2))
                    40-80
                elif j in b:
                    plt.title('player Barcelona {}'.format(j), loc='right')
                    print('barcelona', np.mean(histr_1), np.mean(histr_2))
                else:
                    plt.title('player Arbitro {}'.format(j), loc='right')
                    print('referi', np.mean(histr_1), np.mean(histr_2))
                plt.xlim([0,180])
        plt.show()
        
        self.player_histograms = [self.player_histograms[i] for i in range(len(self.player_histograms)) if i not in r]
        players_attributes = list(pd.DataFrame(self.player_histograms).attrs)

       	#pca = PCA(n_components=2)
        #pca_attrs = pca.fit_transform(np.array(players_attributes))
        #plt.scatter(pca_attrs[:,0], pca_attrs[:,1], c=['black', 'b', 'b', 'b', 'b', 'black', 'b', 'black', 'black', 'black', 'b', 'b'])
        #plt.show()
        #kmeans_labels = GaussianMixture(n_components=2).fit_predict(pca_attrs)
        
        kmeans_labels = GaussianMixture(n_components=2).fit_predict(np.array(players_attributes))
        
        print(kmeans_labels)

        for i in range(len(kmeans_labels)):
            if kmeans_labels[i] == 0:
                team_one.append(self.player_histograms[i])
            elif kmeans_labels[i] == 1:
                team_two.append(self.player_histograms[i])
        team_one = [player['bb'] for player in team_one]
        team_two = [player['bb'] for player in team_two]
        '''
        
        players_bb = self.player_histograms
        players_bb = [players_bb[i] for i in range(len(players_bb)) if i not in r]
        distances = self.calculate_distances(players_bb)

        players_bb = self.delete_referees(referee, distances, players_bb)
        distances = self.calculate_distances(players_bb)

        player_one_i, player_two_j = self.max_difference(distances)

        team_one = [players_bb[player_one_i]]
        team_two = [players_bb[player_two_j]]

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
        '''
        return team_one, team_two


