rm(list = ls())
library("shiny")
library("data.table")
library("ggplot2")


# prep -------------------------------------------------------------------------
module_dir <- "demos/Module06"
counts <- fread(file.path(module_dir, "data/counts.csv"))
state_map <- fread(file.path(module_dir, "data/state_map.csv"))

heat_map <- counts[, lapply(.SD, median), by = state_name, .SDcols = c("ifr", "mr")]
heat_map <- merge(heat_map, state_map, by = "state_name")

state_names <- unique(counts[["state_name"]])

variables <- list(
  time_series = c("cases", "deaths", "new_cases", "new_deaths", "ifr", "mr"),
  heat_map = c("ifr", "mr")
)

# define UI --------------------------------------------------------------------
ui <- fluidPage(
  navbarPage(
    "COVID Data Viewer",
    tabPanel(
      "Time series",
      sidebarPanel(
        selectInput(
          inputId = "state",
          label = "State",
          choices = state_names,
          selected = "Washington",
          multiple = TRUE
        ),
        selectInput(
          inputId = "variable_time_series",
          label = "Variable",
          choices = variables$time_series,
          selected = variables$time_series[1]
        ),
        checkboxInput(
          inputId = "y_log_scale",
          label = "log-scale Y",
          value = FALSE
        )
      ),
      mainPanel(plotOutput("plot_time_series"))
    ),
    tabPanel(
      "Heat map",
      sidebarPanel(
        selectInput(
          inputId = "variable_heat_map",
          label = "Variable",
          choices = variables$heat_map,
          selected = variables$heat_map[1],
        )
      ),
      mainPanel(plotOutput("plot_heat_map"))
    )
  )
)


# define server ----------------------------------------------------------------
server <- function(input, output) {
  get_time_series_info <- reactive({
    list(
      data = counts[state_name %in% input$state,],
      state = paste(input$state, collapse = " & "),
      variable = input$variable_time_series,
      y_log_scale = input$y_log_scale
    )
  })
  
  get_heat_map_info <- reactive({
    list(
      variable = input$variable_heat_map
    )
  })
  
  output$plot_time_series <- renderPlot({
    info <- get_time_series_info()
    
    fig <- ggplot(info$data) +
      geom_line(aes(x = date, y = .data[[info$variable]], color = state)) +
      ggtitle(info$state)
    
    if (info$y_log_scale) {
      fig <- fig + scale_y_log10()
    }
    fig
  })
  
  output$plot_heat_map <- renderPlot({
    info <- get_heat_map_info()
    
    ggplot(heat_map) +
      geom_polygon(aes(x = long, y = lat, group = group, fill = .data[[info$variable]]))
  })
}

shinyApp(ui = ui, server = server)

