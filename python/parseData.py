import pandas
import json
import time

day = 4

def convertTime(t):
    try:
        pieces = t.split(":")
        hour = int(pieces[0])
        if (t.endswith("PM")):
            if hour != 12:
                hour += 12
        else:
            if (hour == 12):
                hour = 0
        tformat = "{}:{}".format(hour,pieces[1].split(' ')[0])
        return tformat
    except AttributeError:
        return None
    # dt = time.strptime(t,"%I:%M %r")
    # return dt.strftime("%H:%M")

def timeToFloat(t):
    if (t is None):
        return None
    comps = t.split(":")
    mins = int(comps[0])*60 + int(comps[1])
    return mins/float(24*60)

out = []

df = pandas.read_csv("../data/moonApril.csv");


for index, row in df.iterrows():
	obj = {}
	obj['riseTime'] = convertTime(row['Moonrise'])
	obj['risePerc'] = timeToFloat(obj['riseTime'])

	obj['setTime'] = convertTime(row['Moonset'])
	obj['setPerc'] = timeToFloat(obj['setTime'])

	obj['meridian'] = convertTime(row['Time'])
	obj['meridianPerc'] = timeToFloat(obj['meridian'])

	obj["illumination"] = float(str(row["Illumination"]).strip('%'))
	obj["type"] = row["Type"]
	obj["day"] = day
	day += 1
	day = day % 7
	out.append(obj)
	

with open('../data/phases.json', 'w') as json_file:
    json.dump({"data":out}, json_file, indent=2)
