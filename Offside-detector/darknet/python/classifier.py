class Classifier:

    def __init__(self):
        self.player_histograms = []
        self.players_bb = []
        self.buckets_per_color = 3

    def classify(self, bounding_box, frame):
        x = int(bounding_box[0])
        y = int(bounding_box[1])
        w = int(bounding_box[2])
        h = int(bounding_box[3])

        initial_x = int(x - (w / 2))
        initial_y = int(y - (h / 2))

        player_histogram = {}

        for i in range(initial_x, initial_x + w):
            for j in range(initial_y, initial_y + h):
                self.add_to_histogram(player_histogram, frame[j,i])

        self.player_histograms.append(player_histogram)
        self.players_bb.append(bounding_box)

    def add_to_histogram(self, player_histogram, pixel):
        bucket_1 = self.bucket_for_pixel(pixel[0])
        bucket_2 = self.bucket_for_pixel(pixel[1])
        bucket_3 = self.bucket_for_pixel(pixel[2])

        key = (bucket_1, bucket_2, bucket_3)
        player_histogram[key] = player_histogram.get(key, 0) + 1

    def bucket_for_pixel(self, number):
        bucket_size = int(255/self.buckets_per_color)
        return int(number/bucket_size)

    def histogram_distance(self, h1, h2):
        diff = 0
        for k, v in h1.iteritems():
            diff += abs(v - h2.get(k, 0))
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

    def get_teams(self):
        players_histograms = self.player_histograms
        players_bb = self.players_bb

        team_one = [players_bb[0]]
        team_one_player_histogram = players_histograms[0]

        players_histograms.pop(0)
        players_bb.pop(0)

        i = self.max_histogram_diff(team_one_player_histogram, players_histograms)
        team_two_player_histogram = players_histograms[i]
        team_two = [players_bb[i]]

        players_histograms.pop(i)
        players_bb.pop(i)

        for idx, player_histogram in enumerate(players_histograms):
            d1 = self.histogram_distance(team_one_player_histogram, player_histogram)
            d2 = self.histogram_distance(team_two_player_histogram, player_histogram)
            print('distance')
            print(d1)
            print(d2)
            if d1 < d2:
                team_one.append(players_bb[idx])
            else:
                team_two.append(players_bb[idx])

        return team_one, team_two
