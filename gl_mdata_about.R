
about <- read_csv("www/about.csv")
#about <- read_csv("www/about.csv", show_col_types = FALSE)

about$enlaces <- paste0("<a href='",about$enlaces, " 'target='_blank' >",about$enlaces,"</a>")










