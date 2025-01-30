install.packages("jsonlite")
library(jsonlite)
library(stringr)

json.folder <- ".json"

json.file <- list.files(json.folder, full.names = TRUE)

file.name.parts<- str_split(json.file, "-", simplify=TRUE)

artist<-str_sub(file.name.parts[1], start=7L)
album<-file.name.parts[2]
song.name<-str_sub(file.name.parts[3], end=-6L)

print(artist)
print(album)
print(song.name)


json.data<-fromJSON(json.file)

average.loundess <- json.data$metadata$audio_properties$replay_gain
mean.spectral.engery <- json.data$lowlevel$spectral_rolloff$mean
danceability <- json.data$rhythm$danceability
bpm <- json.data$rhythm$bpm
musical.key <- json.data$tonal$key_key
key.scale <- json.data$tonal$key_scale
length <- json.data$metadata$audio_properties$length

music_features <- data.frame(
  Artist = artist ,
  Album = album ,
  Song = song.name ,
  Average_Loudness = average.loundess,
  Spectral_Energy_Mean = mean.spectral.engery,
  Danceability = danceability,
  BPM = bpm,
  Key = musical.key,
  Key_Scale = key.scale,
  Length_Seconds = length
)

dim(music_features)
View(music_features)


