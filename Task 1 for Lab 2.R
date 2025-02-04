install.packages("stringr") 
library(stringr)
help("stringr")
vignette("stringr")

#############################################step 1

music.folder<-list.dirs("MUSIC/") #this creates our vector with sub directories

#############################################step 2

slash.count <- str_count(music.folder, "/") #this counts our slashes and creates a vector for it

album.subdirectories<- music.folder[slash.count ==2] #this creates a vector with 2 slashes in our sub directories

print(album.subdirectories) #this prints out so that we can see all of our sub directories in our album

##############################################step 3

code.to.process<-c()

for(curr.album in album.subdirectories){
  
  files<- list.files(curr.album) #list.files creates our list of files in our curr.album and we assign files to this 
  
  wav.files <- files[str_count(files, ".wav") == 1] #we look in files vector to find the files that have .wav which are the songs and then we label those files wav.files
  
  for(song in wav.files){
    
    fixed.part <- "steaming\\_extractor\\_music.exe"
    track.file <- paste(curr.album , song , sep="/") #paste the current album sub directories and current tract title together
    
    
    artist.name <- (str_split(curr.album, "/", simplify=TRUE)[2])
    album.name <- (str_split(curr.album, "/", simplify=TRUE)[3])
    track.name <- str_split(song, "-", simplify=TRUE)[3]
    track.name <- str_sub(track.name, end=-5L)
    
    
    output.file <- paste(artist.name, "-", album.name, "-", track.name, ".json", sep="")
    
    
    command <- paste(fixed.part, ' "', track.file,'" "', output.file, '"', sep="")
    
    code.to.process<-c(code.to.process, command)
  }
  
}

writeLines(code.to.process, "batfile.txt")


