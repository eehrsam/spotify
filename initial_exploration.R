library(jsonlite)
library(data.table)
library(lubridate)
library(ggplot2)

my_streaming <- as.data.table(fromJSON("StreamingHistory.json"))

names(my_streaming)
str(my_streaming)

my_streaming[,.N,by="artistName"][order(-N)]
my_streaming[,.N,by="trackName"][order(-N)]
my_streaming[,.(min(endTime),max(endTime))] # listening from August 20 to November 17

my_streaming[msPlayed == min(msPlayed),.N,by="trackName"]


my_library_tracks <- as.data.table(fromJSON("YourLibrary.json")$tracks)
my_library_albums  <- as.data.table(fromJSON("YourLibrary.json")$albums)


my_streaming_2019 <- as.data.table(fromJSON("2019/StreamingHistory0.json"))

names(my_streaming)
str(my_streaming)

my_streaming_2019[,.N,by="artistName"][order(-N)]
my_streaming_2019[,.N,by="trackName"][order(-N)]
my_streaming_2019[,.(min(endTime),max(endTime))] # listening from August 20 to November 17

my_streaming[msPlayed == min(msPlayed),.N,by="trackName"]
my_streaming_2019 = my_streaming_2019[,newEndTime:= ymd_hm(endTime)]
my_library_tracks_2019 <- as.data.table(fromJSON("YourLibrary.json")$tracks)
my_library_albums_2019  <- as.data.table(fromJSON("YourLibrary.json")$albums)

ggplot(data = my_streaming_2019, aes(x = endTime, y = msPlayed))+
  geom_line(color = "#ffb3ff")


# start of plotting for visualizations 
my_streaming_2019 = my_streaming_2019[,newEndTime:= ymd_hm(endTime)]
my_streaming_2019 = my_streaming_2019[ ,EndTimeYMH:= round_date(newEndTime, unit='hour')]

theme =  theme_bw() +
  theme(axis.line = element_line(colour = "black"),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank()) 

leplot = ggplot(data = my_streaming_2019, aes(x = EndTimeYMH, y = msPlayed))+
geom_line(color = "#ffb3ff") # change this? 


aggStream = my_streaming_2019[,.N,by=EndTimeYMH]


ggplot(data = aggStream, aes(x = EndTimeYMH, y = N))+
  geom_point(color = "#ffb3ff") + theme # change this? 
leplot





