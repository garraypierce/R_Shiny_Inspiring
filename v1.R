library(shiny)
library(bslib)

# 勵志語錄資料 (你可以在這裡新增更多語錄)
quotes <- data.frame(
  quote = c(
    "成功不是終點，失敗也不是致命的，重要的是繼續前進的勇氣。",
    "每一個你不滿意的現在，都有一個你沒有努力的曾經。",
    "不要等待機會，而要創造機會。",
    "你的時間有限，不要浪費在別人的生活裡。",
    "夢想不會逃跑，逃跑的永遠是自己。",
    "今天的努力是明天的幸運。",
    "沒有比腳更長的路，沒有比人更高的山。",
    "當你感到疲憊時，記得你為何開始。",
    "每一次跌倒，都是一次學會站起來的機會。",
    "相信自己，你比想像中更強大。"
  ),
  author = c(
    "溫斯頓·邱吉爾",
    "佚名",
    "喬治·蕭伯納",
    "史蒂夫·賈伯斯",
    "佚名",
    "佚名",
    "汪國真",
    "佚名",
    "佚名",
    "佚名"
  ),
  stringsAsFactors = FALSE
)

ui <- page_fillable(
  theme = bs_theme(
    version = 5,
    bootswatch = "flatly",
    bg = "#0f0c29",
    fg = "#ffffff"
  ),
  
  tags$head(
    tags$style(HTML("
      body {
        background: linear-gradient(135deg, #0f0c29 0%, #302b63 50%, #24243e 100%);
        min-height: 100vh;
        font-family: 'Noto Sans TC', 'Microsoft JhengHei', sans-serif;
      }
      
      .quote-container {
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        min-height: 80vh;
        padding: 2rem;
        text-align: center;
      }
      
      .quote-card {
        background: rgba(255, 255, 255, 0.1);
        backdrop-filter: blur(10px);
        border-radius: 20px;
        padding: 3rem;
        max-width: 800px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.1);
        animation: fadeIn 1s ease-in-out;
      }
      
      @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
      }
      
      .quote-icon {
        font-size: 4rem;
        color: rgba(255, 215, 0, 0.8);
        margin-bottom: 1rem;
      }
      
      .quote-text {
        font-size: 2rem;
        font-weight: 300;
        line-height: 1.8;
        color: #ffffff;
        margin-bottom: 1.5rem;
        letter-spacing: 0.05em;
      }
      
      .quote-author {
        font-size: 1.2rem;
        color: rgba(255, 255, 255, 0.7);
        font-style: italic;
      }
      
      .timer-info {
        margin-top: 2rem;
        color: rgba(255, 255, 255, 0.5);
        font-size: 0.9rem;
      }
      
      .refresh-btn {
        margin-top: 1.5rem;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border: none;
        padding: 0.8rem 2rem;
        border-radius: 50px;
        color: white;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.3s ease;
      }
      
      .refresh-btn:hover {
        transform: scale(1.05);
        box-shadow: 0 5px 20px rgba(102, 126, 234, 0.5);
      }
      
      .title {
        font-size: 1.5rem;
        color: rgba(255, 255, 255, 0.9);
        margin-bottom: 2rem;
        letter-spacing: 0.1em;
      }
    "))
  ),
  
  div(class = "quote-container",
    h1(class = "title", "✨ 每日勵志語錄 ✨"),
    
    div(class = "quote-card",
      div(class = "quote-icon", "❝"),
      div(class = "quote-text", textOutput("quote_text", inline = TRUE)),
      div(class = "quote-author", textOutput("quote_author", inline = TRUE)),
      actionButton("refresh", "換一句", class = "refresh-btn"),
      div(class = "timer-info", 
        "每 10 分鐘自動更換 | 下次更換：",
        textOutput("countdown", inline = TRUE)
      )
    )
  )
)

server <- function(input, output, session) {
  
  # 儲存當前語錄索引
  current_index <- reactiveVal(sample(nrow(quotes), 1))
  
  # 倒數計時器 (600秒 = 10分鐘)
  timer <- reactiveVal(600)
  
  # 每秒更新倒數
  observe({
    invalidateLater(1000, session)
    isolate({
      t <- timer()
      if (t > 0) {
        timer(t - 1)
      } else {
        # 時間到，更換語錄
        current_index(sample(nrow(quotes), 1))
        timer(600)
      }
    })
  })
  
  # 手動刷新按鈕
  observeEvent(input$refresh, {
    current_index(sample(nrow(quotes), 1))
    timer(600)
  })
  
  # 顯示語錄
  output$quote_text <- renderText({
    quotes$quote[current_index()]
  })
  
  # 顯示作者
  output$quote_author <- renderText({
    paste("—", quotes$author[current_index()])
  })
  
  # 顯示倒數時間
  output$countdown <- renderText({
    t <- timer()
    mins <- floor(t / 60)
    secs <- t %% 60
    sprintf("%02d:%02d", mins, secs)
  })
}

shinyApp(ui = ui, server = server)