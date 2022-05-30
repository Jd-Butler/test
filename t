import json
import pandas as pd


convthis = {"Interval" :[],	"MediType":[],	"userID":[], "tAnswered.count":[],"tAnswered.Sum":[], "tHandled.count":[],	"tHandled.sum":[],	"tTalkComplete.count":[],	"tTalkComplete.Sum":[],}

with open('test.json') as json_file:
    data = json.load(json_file)
    for p in data["results"]:
        convthis["Interval"].append(p["data"][0]["interval"])
        convthis["MediType"].append(p['group']["mediaType"])
        convthis["userID"].append(p['group']["userId"])
        convthis["tAnswered.count"].append(p["data"][0]['metrics'][0]['stats']["count"])
        convthis["tAnswered.Sum"].append(p["data"][0]['metrics'][0]['stats']["sum"])
        arrmpya = p['data'][0]['metrics']
        for i in arrmpya:
            if i['metric'] == "tTalkComplete":
                try:
                    convthis["tTalkComplete.count"].append(i['stats']["count"])
                    convthis["tTalkComplete.Sum"].append(i['stats']["sum"])
                except Exception:
                    convthis["tTalkComplete.count"].append(0)
                    convthis["tTalkComplete.Sum"].append(0)
            elif i['metric'] == "tHandle":
                try:
                    convthis["tHandled.count"].append(i['stats']["count"])
                    convthis["tHandled.sum"].append(i['stats']["sum"])
                except Exception:
                    convthis["tHandled.count"].append(0)
                    convthis["tHandled.sum"].append(0)





df = pd.DataFrame(dict([(k,pd.Series(v)) for k,v in convthis.items()]))
df.to_csv("convert_done.csv")
print(df)
            
    
