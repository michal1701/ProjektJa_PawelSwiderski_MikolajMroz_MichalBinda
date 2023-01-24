# API client library
import isodate
import googleapiclient.discovery
import pandas as pd
from Stats_from_R import df, Ids

# API information
api_service_name = "youtube"
api_version = "v3"
# API key
KLUCZ_API = "AIzaSyCnygWdev9fpAY0fYyc2HGinK0qAwoi8w4"
# API client
youtube = googleapiclient.discovery.build(
    api_service_name, api_version, developerKey = KLUCZ_API)
# 'request' variable is the only thing you must change
# depending on the resource and method you need to use
# in your query

# Dictionary to store videos data
vid_info = {
    'id':[],
    'duration':[],
    'views':[],
    'likes':[],
    'favorites':[],
    'comments':[],
    'channelSubscribers':[]
}

# For loop to obtain the information of each video
for i in range(len(Ids[0])):
    vidId = Ids[0][i]
    channelId = Ids[1][i]
    print(vidId,channelId)
    # Getting stats of the video
    r1 = youtube.videos().list(
        part="statistics,contentDetails",
        id=vidId,
        fields="items(statistics," + \
                     "contentDetails(duration))"
    ).execute()

    print(r1)
    r2 = youtube.channels().list(
        part="statistics",
        id=channelId,
        fields="items(statistics)"
    ).execute()

    print(r2)
    # We will only consider videos which contains all properties we need.
    # If a property is missing, then it will not appear as dictionary key,
    # this is why we need a try/catch block
    try:
        duration = isodate.parse_duration(r1['items'][0]['contentDetails']['duration'])
        views = r1['items'][0]['statistics']['viewCount']
        likes = r1['items'][0]['statistics']['likeCount']
        favorites = r1['items'][0]['statistics']['favoriteCount']
        comments = r1['items'][0]['statistics']['commentCount']
        subscribers = r2['items'][0]['statistics']['subscriberCount']
        vid_info['id'].append(vidId)
        vid_info['duration'].append(duration)
        vid_info['views'].append(views)
        vid_info['likes'].append(likes)
        vid_info['favorites'].append(favorites)
        vid_info['comments'].append(comments)
        vid_info['channelSubscribers'].append(subscribers)
    except:
        vid_info['id'].append(float("nan"))
        vid_info['duration'].append(float("nan"))
        vid_info['views'].append(float("nan"))
        vid_info['likes'].append(float("nan"))
        vid_info['favorites'].append(float("nan"))
        vid_info['comments'].append(float("nan"))
        vid_info['channelSubscribers'].append(float("nan"))


print(vid_info)
vid_info = pd.DataFrame.from_dict(vid_info)
frames = [df, vid_info]
result = pd.concat(frames, axis = 1)
pd.DataFrame(data=result).to_csv("Youtube_full_stats3.csv", index=False)

