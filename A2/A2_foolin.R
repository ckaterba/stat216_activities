url <- "https://raw.githubusercontent.com/ckaterba/ScratchLottoScrape/master/outputCSV/allScratchGames.csv"
download.file(url, "allScratchGames.csv")
df <- as_tibble(read.csv("allScratchGames.csv"))


