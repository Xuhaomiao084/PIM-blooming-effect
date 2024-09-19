import sys

def create_peak(peak_data, dist_data):
    peak_data_b = "".join(f"{peak_data:018b}")
    dist_data_b = "".join(f"{dist_data:014b}")
    peak = peak_data_b + dist_data_b
    return peak

def create_point(peak):
    point = "00000000" + peak[0] + peak[1] + peak[2] + peak[3] + "\n"
    return point

mem_size = 30
peak = []

mode = sys.argv[1]

# normal peak: peak_data = 3000, peak_dist = 400
# blooming peak: peak_data = 2500, peak_dist = 1000
# reflector peak: peak_data = 35000, peak_dist = 1000
if (mode == "1"): # version 1.0
    for k in range(40):
        f = open("./mem_files/mem_test{id}.txt".format(id=k), "w")
        if (k == 17):
            for i in range(30):
                if (i <= 11 or (i >= 18 and i <= 21) or i >= 28):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 22 or i == 27):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    peak.append(create_peak(35000, 1000))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 18):
            for i in range(30):
                if (i in [0, 1, 8, 9, 10, 11, 18, 19, 20, 21, 28, 29]):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i in [2, 7, 12, 17, 22, 27]):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    peak.append(create_peak(35000, 1000))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 19):
            for i in range(30):
                if (i <= 1 or (i >= 8 and i <= 11) or i >= 18):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 2 or i == 7):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    peak.append(create_peak(35000, 1000))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 10):
            for i in range(30):
                if (i >= 10 and i <= 20):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        else:
            for i in range(30):
                for j in range(4):
                    peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        f.close()
if (mode == "2"): # version 2.0 multiple reflector
    for k in range(40):
        f = open("./mem_files/mem_test{id}.txt".format(id=k), "w")
        # ref1
        # blooming peak: peak_data = 3500, peak_dist = 800
        # reflector peak: peak_data = 30000, peak_dist = 800
        if (k == 11):
            for i in range(30):
                if (i <= 11 or (i >= 18 and i <= 21) or i >= 28):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 22 or i == 27):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(3500, 800))
                else:
                    peak.append(create_peak(30000, 800))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 12):
            for i in range(30):
                if (i in [0, 1, 8, 9, 10, 11, 18, 19, 20, 21, 28, 29]):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i in [2, 7, 12, 17, 22, 27]):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(3500, 800))
                else:
                    peak.append(create_peak(30000, 800))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 13):
            for i in range(30):
                if (i <= 1 or (i >= 8 and i <= 11) or i >= 18):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 2 or i == 7):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(3500, 800))
                else:
                    peak.append(create_peak(30000, 800))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 17):
            for i in range(30):
                if (i <= 11 or (i >= 18 and i <= 21) or i >= 28):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 22 or i == 27):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    peak.append(create_peak(35000, 1000))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 18):
            for i in range(30):
                if (i in [0, 1, 8, 9, 10, 11, 18, 19, 20, 21, 28, 29]):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i in [2, 7, 12, 17, 22, 27]):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    peak.append(create_peak(35000, 1000))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 19):
            for i in range(30):
                if (i <= 1 or (i >= 8 and i <= 11) or i >= 18):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 2 or i == 7):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    peak.append(create_peak(35000, 1000))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        # ref3
        # blooming peak: peak_data = 4500, peak_dist = 300
        # reflector peak: peak_data = 40000, peak_dist = 300 
        elif (k == 25):
            for i in range(30):
                if (i <= 11 or (i >= 18 and i <= 21) or i >= 28):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 22 or i == 27):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(4500, 300))
                else:
                    peak.append(create_peak(40000, 300))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 26):
            for i in range(30):
                if (i in [0, 1, 8, 9, 10, 11, 18, 19, 20, 21, 28, 29]):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i in [2, 7, 12, 17, 22, 27]):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(4500, 300))
                else:
                    peak.append(create_peak(40000, 300))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 27):
            for i in range(30):
                if (i <= 1 or (i >= 8 and i <= 11) or i >= 18):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 2 or i == 7):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(4500, 300))
                else:
                    peak.append(create_peak(40000, 300))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        # ref4
        # blooming peak: peak_data = 6500, peak_dist = 500
        # reflector peak: peak_data = 45000, peak_dist = 500 
        elif (k == 28):
            for i in range(30):
                if (i <= 11 or (i >= 18 and i <= 21) or i >= 28):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 22 or i == 27):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(6500, 500))
                else:
                    peak.append(create_peak(45000, 500))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 29):
            for i in range(30):
                if (i in [0, 1, 8, 9, 10, 11, 18, 19, 20, 21, 28, 29]):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i in [2, 7, 12, 17, 22, 27]):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(6500, 500))
                else:
                    peak.append(create_peak(45000, 500))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 30):
            for i in range(30):
                if (i <= 1 or (i >= 8 and i <= 11) or i >= 18):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 2 or i == 7):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(6500, 500))
                else:
                    peak.append(create_peak(45000, 500))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 32):
            for i in range(30):
                if (i <= 11 or (i >= 18 and i <= 21) or i >= 28):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 22 or i == 27):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(6500, 100))
                else:
                    peak.append(create_peak(45000, 100))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 33):
            for i in range(30):
                if (i in [0, 1, 8, 9, 10, 11, 18, 19, 20, 21, 28, 29]):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i in [2, 7, 12, 17, 22, 27]):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(6500, 100))
                else:
                    peak.append(create_peak(45000, 100))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 34):
            for i in range(30):
                if (i <= 1 or (i >= 8 and i <= 11) or i >= 18):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 2 or i == 7):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(6500, 100))
                else:
                    peak.append(create_peak(45000, 100))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 0):
            for i in range(30):
                if (i >= 10 and i <= 20):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        else:
            for i in range(30):
                for j in range(4):
                    peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        f.close()
if (mode == "3"): # version 2.2 multiple blooming with overlap
    for k in range(40):
        f = open("./mem_files/mem_test{id}.txt".format(id=k), "w")
        # ref1
        # blooming peak: peak_data = 3500, peak_dist = 800
        # reflector peak: peak_data = 30000, peak_dist = 800
        if (k == 11):
            for i in range(30):
                if (i <= 11 or (i >= 18 and i <= 21) or i >= 28):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 22 or i == 27):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(3500, 800))
                else:
                    peak.append(create_peak(30000, 800))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 12):
            for i in range(30):
                if (i in [0, 1, 8, 9, 10, 11, 18, 19, 20, 21, 28, 29]):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i in [2, 7, 12, 17, 22, 27]):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(3500, 800))
                else:
                    peak.append(create_peak(30000, 800))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 13):
            for i in range(30):
                if (i <= 1 or (i >= 8 and i <= 11) or i >= 18):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 2 or i == 7):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(3500, 800))
                else:
                    peak.append(create_peak(30000, 800))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 17):
            for i in range(30):
                if (i <= 11 or (i >= 18 and i <= 21) or i >= 28):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 22 or i == 27):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    peak.append(create_peak(35000, 1000))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 18):
            for i in range(30):
                if (i in [0, 1, 8, 9, 10, 11, 18, 19, 20, 21, 28, 29]):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i in [2, 7, 12, 17, 22, 27]):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    peak.append(create_peak(35000, 1000))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 19):
            for i in range(30):
                if (i <= 1 or (i >= 8 and i <= 11) or i >= 18):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 2 or i == 7):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    peak.append(create_peak(35000, 1000))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        # ref3
        # blooming peak: peak_data = 4500, peak_dist = 300
        # reflector peak: peak_data = 40000, peak_dist = 300 
        elif (k == 25):
            for i in range(30):
                if (i <= 11 or (i >= 18 and i <= 21) or i >= 28):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 22 or i == 27):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(4500, 300))
                else:
                    peak.append(create_peak(40000, 300))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 26):
            for i in range(30):
                if (i in [0, 1, 8, 9, 10, 11, 18, 19, 20, 21, 28, 29]):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i in [2, 7, 12, 17, 22, 27]):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(4500, 300))
                else:
                    peak.append(create_peak(40000, 300))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 27):
            for i in range(30):
                if (i <= 1 or (i >= 8 and i <= 11) or (i >= 18 and i <= 21) or i >=28):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i >= 12 and i <= 17):
                    for j in range(2):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(4500, 300))
                    peak.append(create_peak(6500, 500))
                elif (i == 2 or i == 7):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(4500, 300))
                elif (i == 22 or i == 27):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(6500, 500))
                elif (i >= 23 and i <= 26):
                    peak.append(create_peak(45000, 500))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                else:
                    peak.append(create_peak(40000, 300))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        # ref4
        # blooming peak: peak_data = 6500, peak_dist = 500
        # reflector peak: peak_data = 45000, peak_dist = 500 
        elif (k == 28):
            for i in range(30):
                if (i in [0, 1, 8, 9, 10, 11, 18, 19, 20, 21, 28, 29]):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i in [2, 7, 12, 17, 22, 27]):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(6500, 500))
                else:
                    peak.append(create_peak(45000, 500))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 29):
            for i in range(30):
                if (i <= 1 or (i >= 8 and i <= 11) or i >= 18):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 2 or i == 7):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(6500, 500))
                else:
                    peak.append(create_peak(45000, 500))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 0):
            for i in range(30):
                if (i >= 10 and i <= 20):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        else:
            for i in range(30):
                for j in range(4):
                    peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        f.close()
if (mode == "4"): # version 2.3 multiple reflector with overlap
    for k in range(40):
        f = open("./mem_files/mem_test{id}.txt".format(id=k), "w")
        # ref1
        # blooming peak: peak_data = 3500, peak_dist = 800
        # reflector peak: peak_data = 30000, peak_dist = 800
        if (k == 11):
            for i in range(30):
                if (i <= 11 or (i >= 18 and i <= 21) or i >= 28):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 22 or i == 27):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(3500, 800))
                else:
                    peak.append(create_peak(30000, 800))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 12):
            for i in range(30):
                if (i in [0, 1, 8, 9, 10, 11, 18, 19, 20, 21, 28, 29]):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i in [2, 7, 12, 17, 22, 27]):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(3500, 800))
                else:
                    peak.append(create_peak(30000, 800))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 13):
            for i in range(30):
                if (i <= 1 or (i >= 8 and i <= 11) or i >= 18):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 2 or i == 7):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(3500, 800))
                else:
                    peak.append(create_peak(30000, 800))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 17):
            for i in range(30):
                if (i <= 11 or (i >= 18 and i <= 21) or i >= 28):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 22 or i == 27):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    peak.append(create_peak(35000, 1000))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 18):
            for i in range(30):
                if (i in [0, 1, 8, 9, 10, 11, 18, 19, 20, 21, 28, 29]):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i in [2, 7, 12, 17, 22, 27]):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    peak.append(create_peak(35000, 1000))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 19):
            for i in range(30):
                if (i <= 1 or (i >= 8 and i <= 11) or i >= 18):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 2 or i == 7):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    peak.append(create_peak(35000, 1000))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        # ref3
        # blooming peak: peak_data = 4500, peak_dist = 300
        # reflector peak: peak_data = 40000, peak_dist = 300 
        elif (k == 25):
            for i in range(30):
                if (i <= 11 or (i >= 18 and i <= 21) or i >= 28):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 22 or i == 27):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(4500, 300))
                else:
                    peak.append(create_peak(40000, 300))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 26):
            for i in range(30):
                if (i in [0, 1, 8, 9, 10, 11, 18, 19, 20, 21, 28, 29]):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i in [2, 7]):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(4500, 300))
                elif (i >= 3 and i <= 6):
                    peak.append(create_peak(40000, 300))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                elif (i in [12, 17, 22, 27]):
                    for j in range(2):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(6500, 500))
                    peak.append(create_peak(4500, 300))
                elif (i in [13, 14, 15, 16]):
                    peak.append(create_peak(40000, 300))
                    for j in range(2):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(6500, 500))
                else:
                    peak.append(create_peak(40000, 300))
                    peak.append(create_peak(45000, 500))
                    peak.append(create_peak(48000, 100))
                    for j in range(1):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 27):
            for i in range(30):
                if (i in [0, 1, 8, 9, 10, 11, 18, 19, 20, 21, 28, 29]):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif (i in [2, 7, 12, 17]):
                    for j in range(2):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(6500, 500))
                    peak.append(create_peak(4500, 300))
                elif (i == 22 or i == 27):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(6500, 500))
                elif (i >= 3 and i <= 6):
                    peak.append(create_peak(40000, 300))
                    peak.append(create_peak(45000, 500))
                    peak.append(create_peak(48000, 100))
                    for j in range(1):
                        peak.append(create_peak(3000, 400))
                elif (i >= 23 and i <= 26):
                    peak.append(create_peak(45000, 500))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                else:
                    peak.append(create_peak(45000, 500))
                    for j in range(2):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(4500, 300))
                point = create_point(peak)
                f.write(point)
                peak = []
        # ref4
        # blooming peak: peak_data = 6500, peak_dist = 500
        # reflector peak: peak_data = 45000, peak_dist = 500 
        elif (k == 28):
            for i in range(30):
                if (i <= 1 or (i >= 8 and i <= 11) or i >= 18):
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                elif ((i >= 12 and i <= 17) or i == 2 or i == 7):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(6500, 500))
                else:
                    peak.append(create_peak(45000, 500))
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        elif (k == 0):
            for i in range(30):
                if (i >= 10 and i <= 20):
                    for j in range(3):
                        peak.append(create_peak(3000, 400))
                    peak.append(create_peak(2500, 1000))
                else:
                    for j in range(4):
                        peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        else:
            for i in range(30):
                for j in range(4):
                    peak.append(create_peak(3000, 400))
                point = create_point(peak)
                f.write(point)
                peak = []
        f.close()

# f.writelines(["00", data_b, data_b, data_b, data_b, "\n"])
# print(type(point_data_b))