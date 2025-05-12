library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("✊📄✂️ Pao Ying Chub - Rock, Paper, Scissors"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Make your choice:"),
      actionButton("rock", "🪨 Rock"),
      actionButton("paper", "📄 Paper"),
      actionButton("scissors", "✂️ Scissors"),
      br(), br(),
      actionButton("reset", "🔁 Reset Game"),
      br(), br(),
      tags$h4("Result:"),
      verbatimTextOutput("result"),
      tags$h4("Score:"),
      verbatimTextOutput("score")
    ),
    
    mainPanel(
      h4("Game Log (Last 10 Rounds)"),
      verbatimTextOutput("log")
    )
  )
)

# Define Server Logic
server <- function(input, output, session) {
  choices <- c("rock", "paper", "scissors")
  emoji <- c(rock = "🪨", paper = "📄", scissors = "✂️")
  score <- reactiveValues(player = 0, computer = 0, tie = 0, log = character(0), result = "")
  
  play_round <- function(player_choice) {
    computer_choice <- sample(choices, 1)
    
    if (player_choice == computer_choice) {
      outcome <- "It's a tie!"
      score$tie <- score$tie + 1
    } else if (
      (player_choice == "rock" && computer_choice == "scissors") ||
      (player_choice == "scissors" && computer_choice == "paper") ||
      (player_choice == "paper" && computer_choice == "rock")
    ) {
      outcome <- "You win!"
      score$player <- score$player + 1
    } else {
      outcome <- "Computer wins!"
      score$computer <- score$computer + 1
    }
    
    round_log <- paste0("You: ", emoji[[player_choice]], 
                        " | Computer: ", emoji[[computer_choice]], 
                        " → ", outcome)
    score$log <- c(round_log, head(score$log, 9))  # Keep only last 10
    score$result <- round_log
  }
  
  observeEvent(input$rock, {
    play_round("rock")
  })
  
  observeEvent(input$paper, {
    play_round("paper")
  })
  
  observeEvent(input$scissors, {
    play_round("scissors")
  })
  
  observeEvent(input$reset, {
    score$player <- 0
    score$computer <- 0
    score$tie <- 0
    score$log <- character(0)
    score$result <- "Game reset. Let's play again!"
  })
  
  output$result <- renderText({ score$result })
  
  output$score <- renderText({
    paste0("You: ", score$player, 
           " | Computer: ", score$computer, 
           " | Ties: ", score$tie)
  })
  
  output$log <- renderText({
    paste(score$log, collapse = "\n")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
