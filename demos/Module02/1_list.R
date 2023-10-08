# create a name card, with name, phone number and email
john <- list(
  name = "John",
  phone_number = c(2, 0, 6, 1, 2, 3, 1, 2, 3, 4),
  email = "john@gmail.com"
)

# peek into the list
str(john)

# access element(s) in the named card
john["name"]
john[["name"]]
john$name
john[[1]]

# change john's email to his uw email
john[["email"]] <- "john@uw.edu"
str(john)

# type of the list
typeof(john)

# remove John's phone number
john$phone_number <- NULL
str(john)

# convert list into a atomic vector
john_vec <- unlist(john)
typeof(john_vec)

# list of lists
lucy <- list(
  name = "Lucy",
  phone_number = rep(0, 10L),
  email = "lucy@uw.edu"
)

contacts <- list(
  john = john,
  lucy = lucy
)
str(contacts)

# length
length(contacts)
length(lucy)

# lapply
lapply(contacts, function(x) x$name)

# names
names(contacts)
names(contacts) <- c("contact1", "contact2")
str(contacts)
