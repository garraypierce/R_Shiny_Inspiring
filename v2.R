library(shiny)
library(bslib)

# 勵志語錄資料 (你可以在這裡新增更多語錄)
quotes <- data.frame(
  quote = c(
    # 短語錄 (100字以內)
    "成功不是終點，失敗也不是致命的，重要的是繼續前進的勇氣。",
    "每一個你不滿意的現在，都有一個你沒有努力的曾經。",
    "不要等待機會，而要創造機會。",
    "你的時間有限，不要浪費在別人的生活裡。",
    "夢想不會逃跑，逃跑的永遠是自己。",
    "今天的努力是明天的幸運。",
    "沒有比腳更長的路，沒有比人更高的山。",
    "當你感到疲憊時，記得你為何開始。",
    "每一次跌倒，都是一次學會站起來的機會。",
    "相信自己，你比想像中更強大。",
    
    # 小故事 (100-300字)
    "有個年輕人問智者：「如何才能成功？」智者帶他到河邊，突然把他的頭按入水中。年輕人拼命掙扎，終於掙脫。智者問：「在水裡時，你最想要什麼？」年輕人說：「空氣！」智者微笑：「當你渴望成功如同渴望空氣一樣強烈時，你就會成功。」成功不是靠運氣，而是靠那份永不放棄的渴望與決心。",
    
    "一位老農夫的驢子掉進枯井裡。老農夫想了很久，決定放棄救援，直接把井填平。當泥土落在驢子身上時，驢子起初很驚恐，但隨後牠做了一個決定：每次泥土落下，就抖落身上的土，然後踩上去。一鏟又一鏟，驢子不斷往上升。最後，牠跳出了井口。那些想埋葬你的困難，其實都是墊高你的階梯。",
    
    "竹子在前四年只長了三公分，但從第五年開始，每天以三十公分的速度瘋狂生長，僅用六週就長到了十五公尺。原來在前四年，竹子的根已經在土壤裡延伸了數百平方公尺。人生也是如此，不要擔心你的付出沒有回報，你現在做的每一件事，都是在扎根。時機一到，你會成長得比任何人都快。",
    
    "有個小男孩問父親：「爸爸，我們家很窮嗎？」父親說：「不，我們只是暫時沒有錢。窮是一種心態，而沒有錢只是一種狀態。狀態可以改變，但如果你認定自己窮，就會永遠窮。」多年後，這個男孩成為成功的企業家。他說：「父親那番話改變了我的一生。我從不認為自己是窮人，我只是還在通往富有的路上。」",
    
    "一位畫家把作品放在廣場上，請路人用紅筆圈出缺點。一天後，畫作被圈得滿滿的。他很沮喪。老師說：「再畫一幅，這次請路人圈出優點。」結果優點比缺點還多。老師說：「無論你做什麼，都會有人批評，也會有人欣賞。你要做的不是討好所有人，而是不斷精進，讓欣賞你的人越來越多。」"
  ),
  author = c(
    # 短語錄作者
    "溫斯頓·邱吉爾",
    "佚名",
    "喬治·蕭伯納",
    "史蒂夫·賈伯斯",
    "佚名",
    "佚名",
    "汪國真",
    "佚名",
    "佚名",
    "佚名",
    
    # 小故事作者/出處
    "智者與河的故事",
    "驢子與枯井的故事",
    "竹子的啟示",
    "窮與沒錢的故事",
    "畫家與路人的故事"
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
        max-width: 900px;
        box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        border: 1px solid rgba(255, 255, 255, 0.1);
        animation: fadeIn 1s ease-in-out;
      }
      
      @keyframes fadeIn {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
      }
      
      .quote-icon {
        font-size: 3rem;
        color: rgba(255, 215, 0, 0.8);
        margin-bottom: 1rem;
      }
      
      /* 短語錄樣式 (100字以內) */
      .quote-text.short {
        font-size: 2rem;
        font-weight: 300;
        line-height: 1.8;
        color: #ffffff;
        margin-bottom: 1.5rem;
        letter-spacing: 0.05em;
      }
      
      /* 中等長度樣式 (100-200字) */
      .quote-text.medium {
        font-size: 1.4rem;
        font-weight: 300;
        line-height: 2;
        color: #ffffff;
        margin-bottom: 1.5rem;
        letter-spacing: 0.03em;
        text-align: justify;
      }
      
      /* 長故事樣式 (200-300字) */
      .quote-text.long {
        font-size: 1.15rem;
        font-weight: 300;
        line-height: 2.2;
        color: #ffffff;
        margin-bottom: 1.5rem;
        letter-spacing: 0.02em;
        text-align: justify;
      }
      
      .quote-author {
        font-size: 1.1rem;
        color: rgba(255, 255, 255, 0.7);
        font-style: italic;
        padding-top: 1rem;
        border-top: 1px solid rgba(255, 255, 255, 0.2);
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
      
      .char-count {
        font-size: 0.8rem;
        color: rgba(255, 255, 255, 0.4);
        margin-top: 0.5rem;
      }
    "))
  ),
  
  div(class = "quote-container",
    h1(class = "title", "✨ 每日勵志語錄 ✨"),
    
    div(class = "quote-card",
      div(class = "quote-icon", "❝"),
      uiOutput("quote_display"),
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
  
  # 根據字數決定樣式類別
  get_size_class <- function(text) {
    char_count <- nchar(text)
    if (char_count <= 100) {
      return("short")
    } else if (char_count <= 200) {
      return("medium")
    } else {
      return("long")
    }
  }
  
  # 顯示語錄 (含動態樣式)
  output$quote_display <- renderUI({
    quote_text <- quotes$quote[current_index()]
    size_class <- get_size_class(quote_text)
    char_count <- nchar(quote_text)
    
    tagList(
      div(class = paste("quote-text", size_class), quote_text),
      div(class = "char-count", paste0("（", char_count, " 字）"))
    )
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