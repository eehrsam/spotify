library(jsonlite)
library(data.table)


my_streaming <- as.data.table(fromJSON("StreamingHistory.json"))

names(my_streaming)
str(my_streaming)

my_streaming[,.N,by="artistName"][order(-N)]
my_streaming[,.N,by="trackName"][order(-N)]
my_streaming[,.(min(endTime),max(endTime))] # listening from August 20 to November 17

my_streaming[msPlayed == min(msPlayed),.N,by="trackName"]


my_library_tracks <- as.data.table(fromJSON("YourLibrary.json")$tracks)
my_library_albums  <- as.data.table(fromJSON("YourLibrary.json")$albums)


