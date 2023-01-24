import pandas as pd
import feather


df = feather.read_dataframe("~/foobar.feather")
df = df[8000:12000:]

#df = df.reset_index()
Ids = [[],[]]
for index, row in df.iterrows():
     Ids[0].append(row['titleUrl'][32::])
     Ids[1].append(row['channelUrl'][32::])
#df_extra_stats = pd.read_csv('cats.csv')

#frames = [df, df_extra_stats]
#result = pd.concat(frames, axis = 1)
#pd.DataFrame(data=result).to_csv("Youtube_full_stats.csv", index=False)

