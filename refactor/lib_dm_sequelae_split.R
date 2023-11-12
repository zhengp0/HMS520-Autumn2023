library("data.table")
source("masked/get_draws.R")

get_dm_prev <- function(
  ...,
  gbd_id_dm_parent = 24632,
  gbd_id_dm_t1 = 24633
) {
  gbd_id <- list(
    dm_parent = gbd_id_dm_parent,
    dm_t1 = gbd_id_dm_t1
  )
  
  default_get_draws_args <- modifyList(
    list(
      gbd_id_type = "modelable_entity_id",
      random_epi = "epi",
      measure_id = 5,
      gbd_round_id = 7,
      decomp_step = "iterative"
    ),
    list(...)
  )
  
  draws <- lapply(
    gbd_id,
    function(x) .get_draws(gbd_id = x, default_args = default_get_draws_args)
  )
  
  # reshape prev_t1 and prev_parent
  col_names <- colnames(draws[["dm_t1"]])
  col_ids <- col_names[endsWith(col_names, "_id")]
  col_draws <- col_names[startsWith(col_names, "draw_")]
  for (dm_type in names(draws)) {
    draws[[dm_type]] <- melt(
      draws[[dm_type]],
      id.vars = col_ids,
      measure.vars = col_draws,
      variable.name = "draw_id",
      value.name = paste0("prev_", dm_type)
    )
  }
  
  # merge t1 and parent prevalence
  result <- merge(
    draws[["dm_parent"]],
    draws[["dm_t1"]],
    by = c(col_ids, "draw_id"),
    all = TRUE
  )
  
  # rule 1: prev_dm_parent >= prev_dm_t1
  result[prev_dm_parent < prev_dm_t1, prev_dm_parent := prev_dm_t1]
  
  # rule 2: when under age 15, it can only be type 1 diabetes
  under_15_age_group_ids <- .get_under_15_age_group_ids()
  result[, prev_dm_t1_ratio := prev_dm_t1 / prev_dm_parent]
  result[age_group_id %in% under_15_age_group_ids, prev_dm_t1_ratio := 1]
  
  # compute prev_dm_t1, prev_dm_t2
  result[, prev_dm_t1 := prev_dm_t1_ratio * prev_dm_parent]
  result[, prev_dm_t2 := (1 - prev_dm_t1_ratio) * prev_dm_parent]
  
  result
}

.get_draws <- function(..., default_args) {
  args <- modifyList(default_args, list(...))
  setDT(do.call(get_draws, args))
}

# TODO: make this more dynamic
.get_under_15_age_group_ids <- function() {
  c(2, 3, 388, 389, 238, 34, 6, 7)
}