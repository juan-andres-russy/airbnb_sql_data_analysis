## Librerias ----
library(dplyr)

## Carga de informacion ----
if (Sys.info()[1] == "Windows") {
  main_path = ""
}
raw_path = ""
create_path = ""

listings = read.csv(paste(main_path, raw_path, "listings.csv", sep = ""))
calendar = read.csv(paste(main_path, raw_path, "calendar.csv", sep = ""))
reviews  = read.csv(paste(main_path, raw_path, "reviews.csv", sep = ""))
neighbour = read.csv(paste(main_path, raw_path, "neighbourhoods.csv", sep = ""))
## Generacion de tablas ----
# Host
host = listings %>% select(host_id, host_name, host_since)
host <- host[!duplicated(host$host_id),]  # Eliminar duplicados (Host con muchas propiedades listadas)
write.csv(host, paste(main_path, create_path, "host.csv", sep = ''),
          row.names = FALSE)
# Listings
listings = listings %>% mutate(latitude_longitude = paste(longitude, ',', latitude, 
                                                   sep = ' ')) %>%
                        inner_join(neighbour, by = c("neighbourhood_cleansed" = "neighbourhood")) %>%
                        select(id, name, description, host_id, 
                               zip_code, latitude_longitude)

write.csv(listings, paste(main_path, create_path, "listings.csv", sep = ''),
          row.names = FALSE)
# Neighbourhood
write.csv(neighbour, paste(main_path, create_path, "neighbourhoods.csv", 
                           sep = ''), row.names = F)
# Users
users = reviews %>% select(reviewer_id, reviewer_name)
users = unique(users) # 264327 different users
users = rename(users, c(user_id = reviewer_id, user_name = reviewer_name))
write.csv(users, paste(main_path, create_path, "users.csv", sep = ''),
          row.names = F)
# Comment
# see https://stackoverflow.com/questions/64913456/generate-a-random-distribution-by-group-conditional-on-a-column
# for a MORE EFECTIVE SOLUTION
comment = reviews %>% select(-reviewer_name)

write.csv(comment, paste(main_path, create_path, "comment.csv", sep = ''),
          row.names = F)

# Reserve
reserve = calendar %>% select(listing_id, date, available, price)
users_vector = users$user_id
reserve$user_id = NA

reserve$user_id = lapply(1:nrow(reserve), function(x){
  av = reserve$available[i]
  if (av == 'f') {
    reserve$user_id[i] = sample(users_vector, 1)
  }
})
write.csv(reserve, paste(main_path, create_path, "reserve.csv", sep = ''),
          row.names = F)
