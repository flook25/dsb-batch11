library(shiny)

ui <- fluidPage(
  titlePanel("Rock, Paper, Scissors Game"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Choose your move:"),
      actionButton("rock", "🪨 Rock"),
      actionButton("paper", "📄 Paper"),
      actionButton("scissors", "✂️ Scissors"),
      br(), br(),
      actionButton("reset", "🔁 Reset Game"),
      br(), br(),
      verbatimTextOutput("result"),
      verbatimTextOutput("score")
    ),
    
    mainPanel(
      h4("Game Log"),
      verbatimTextOutput("log")
    )
  )
)

server <- function(input, output, session) {
  choices <- c("rock", "paper", "scissors")
  score <- reactiveValues(player = 0, computer = 0, tie = 0, log = "")
  
  play_round <- function(player_choice) {
    computer_choice <- sample(choices, 1)
    
    outcome <- ""
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
    
    round_log <- paste0("You chose ", player_choice, ", computer chose ", computer_choice, " -> ", outcome)
    score$log <- paste(round_log, score$log, sep = "\n")
    
    return(round_log)
  }
  
  observeEvent(input$rock, {
    output$result <- renderText(play_round("rock"))
  })
  
  observeEvent(input$paper, {
    output$result <- renderText(play_round("paper"))
  })
  
  observeEvent(input$scissors, {
    output$result <- renderText(play_round("scissors"))
  })
  
  observeEvent(input$reset, {
    score$player <- 0
    score$computer <- 0
    score$tie <- 0
    score$log <- ""
    output$result <- renderText("Game reset. Let's play again!")
  })
  
  output$score <- renderText({
    paste0("Score -> You: ", score$player, " | Computer: ", score$computer, " | Ties: ", score$tie)
  })
  
  output$log <- renderText({
    score$log
  })
}

shinyApp(ui = ui, server = server)
