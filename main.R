suppressPackageStartupMessages({
  library(tercen)
  library(dplyr)
  library(data.table)
})

ctx <- tercenCtx()

df <- ctx %>% 
  select(.y, .ci, .ri) %>%
  as.data.table()

df[,{
    med <- median(.y)
    list(
      median = med,
      mad = median(abs(.y - med))
    )  
  },
   by = .(.ci, .ri)
] %>%
  as_tibble() %>%
  ctx$addNamespace() %>%
  ctx$save()
