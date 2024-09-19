import sys

def create_peak(peak_data, dist_data):
    peak_data_b = "".join(f"{peak_data:018b}")
    dist_data_b = "".join(f"{dist_data:014b}")
    peak = peak_data_b + dist_data_b
    return peak

def create_point(peak):
    point = "00" + peak[0] + peak[1] + peak[2] + peak[3] + "\n"
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

# f.writelines(["00", data_b, data_b, data_b, data_b, "\n"])
# print(type(point_data_b))