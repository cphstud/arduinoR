library(DBI)
library(RMariaDB)
library(stringr)
library(stringi)
library(logr)

conarduino <- serialConnection(
  name = "mytest",
  #port = "cu.usbserial-146101",
  port = "cu.usbmodem146101",
  mode = "9600,n,8,1",
  newline = 1,
  translation = "cr",
  handshake = "xonxoff",
  buffersize = 4096
)

log_open("log.txt")

difflimit=75

open(conarduino)
close(conarduino)
options(digits.secs=2)  

dfnames=c("people","timestamp")
totaldf=as.data.frame(matrix(nrow=0,ncol=2))
colnames(totaldf)=dfnames
stoptime=Sys.time()+60
flush(conarduino)
while (Sys.time() < stoptime) {
  tmpdf=as.data.frame(matrix(nrow=1,ncol=2))
  colnames(tmpdf)=dfnames
  tmp=read.serialConnection(conarduino)
  count=calcdist(tmp)
  tmpdf$people=count
  tmpdf$timestamp=Sys.time()
  #collLine = paste(collLine,dist)
  totaldf = rbind(totaldf,tmpdf)
  #print(charToRaw(tmpvar))
  flush(conarduino)
  Sys.sleep(5)
}

close(conarduino)


calcdist <- function(rawin) {
  retval=0L
  v=as.numeric(unlist(stri_split(rawin,regex = "\n",omit_empty=T)))
  brutlist=sort(abs(unique(diff(v))))
  log_print(brutlist)
  retval=sum(brutlist > difflimit)
  #print(retval)
  return(round(retval/2))
}

log_close()
barplot(nrr)
