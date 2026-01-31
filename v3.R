library(shiny)
library(bslib)

# 勵志語錄資料 - 增加分類標籤
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
    "智者與河的故事",
    "驢子與枯井的故事",
    "竹子的啟示",
    "窮與沒錢的故事",
    "畫家與路人的故事"
  ),
  category = c(
    "勇氣", "自省", "行動", "時間", "夢想",
    "努力", "毅力", "初心", "成長", "自信",
    "渴望", "逆境", "耐心", "心態", "批評"
  ),
  stringsAsFactors = FALSE
)

ui <- page_fillable(
  theme = bs_theme(
    version = 5,
    bootswatch = "flatly",
    bg = "#0a0a0f",
    fg = "#ffffff"
  ),
  
  tags$head(
    # 引入優雅的中文字體
    tags$link(
      href = "https://fonts.googleapis.com/css2?family=Noto+Serif+TC:wght@300;400;500;600&family=LXGW+WenKai+TC:wght@300;400&display=swap",
      rel = "stylesheet"
    ),
    tags$style(HTML("
      /* ===== 全域樣式 ===== */
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }
      
      body {
        background: #0a0a0f;
        min-height: 100vh;
        font-family: 'LXGW WenKai TC', 'Noto Serif TC', serif;
        overflow-x: hidden;
      }
      
      /* ===== 動態背景 ===== */
      .bg-container {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        z-index: 0;
        overflow: hidden;
      }
      
      .bg-gradient {
        position: absolute;
        width: 100%;
        height: 100%;
        background: 
          radial-gradient(ellipse at 20% 20%, rgba(120, 80, 160, 0.15) 0%, transparent 50%),
          radial-gradient(ellipse at 80% 80%, rgba(80, 120, 180, 0.12) 0%, transparent 50%),
          radial-gradient(ellipse at 50% 50%, rgba(60, 60, 80, 0.1) 0%, transparent 70%);
      }
      
      /* 浮動光點 */
      .floating-orb {
        position: absolute;
        border-radius: 50%;
        filter: blur(60px);
        animation: float 20s infinite ease-in-out;
        opacity: 0.4;
      }
      
      .orb-1 {
        width: 400px;
        height: 400px;
        background: linear-gradient(135deg, #6366f1, #8b5cf6);
        top: -10%;
        left: -5%;
        animation-delay: 0s;
      }
      
      .orb-2 {
        width: 350px;
        height: 350px;
        background: linear-gradient(135deg, #0ea5e9, #06b6d4);
        bottom: -10%;
        right: -5%;
        animation-delay: -7s;
      }
      
      .orb-3 {
        width: 250px;
        height: 250px;
        background: linear-gradient(135deg, #f59e0b, #ef4444);
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        animation-delay: -14s;
        opacity: 0.2;
      }
      
      @keyframes float {
        0%, 100% { transform: translate(0, 0) scale(1); }
        25% { transform: translate(30px, -30px) scale(1.05); }
        50% { transform: translate(-20px, 20px) scale(0.95); }
        75% { transform: translate(20px, 30px) scale(1.02); }
      }
      
      /* 星星粒子 */
      .stars {
        position: absolute;
        width: 100%;
        height: 100%;
        background-image: 
          radial-gradient(2px 2px at 20px 30px, rgba(255,255,255,0.3), transparent),
          radial-gradient(2px 2px at 40px 70px, rgba(255,255,255,0.2), transparent),
          radial-gradient(1px 1px at 90px 40px, rgba(255,255,255,0.4), transparent),
          radial-gradient(2px 2px at 130px 80px, rgba(255,255,255,0.2), transparent),
          radial-gradient(1px 1px at 160px 120px, rgba(255,255,255,0.3), transparent);
        background-repeat: repeat;
        background-size: 200px 200px;
        animation: twinkle 8s infinite;
      }
      
      @keyframes twinkle {
        0%, 100% { opacity: 0.5; }
        50% { opacity: 1; }
      }
      
      /* ===== 主容器 ===== */
      .main-container {
        position: relative;
        z-index: 1;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        padding: 1.5rem;
      }
      
      /* ===== 標題區 ===== */
      .header {
        text-align: center;
        margin-bottom: 2rem;
      }
      
      .main-title {
        font-family: 'Noto Serif TC', serif;
        font-size: clamp(1.5rem, 4vw, 2.2rem);
        font-weight: 300;
        color: rgba(255, 255, 255, 0.9);
        letter-spacing: 0.3em;
        margin-bottom: 0.5rem;
        text-shadow: 0 0 40px rgba(139, 92, 246, 0.3);
      }
      
      .sub-title {
        font-size: 0.85rem;
        color: rgba(255, 255, 255, 0.4);
        letter-spacing: 0.2em;
        font-weight: 300;
      }
      
      /* ===== 卡片主體 ===== */
      .quote-card {
        position: relative;
        background: linear-gradient(
          135deg,
          rgba(255, 255, 255, 0.03) 0%,
          rgba(255, 255, 255, 0.08) 50%,
          rgba(255, 255, 255, 0.03) 100%
        );
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border-radius: 24px;
        padding: clamp(2rem, 5vw, 3.5rem);
        max-width: 850px;
        width: 100%;
        border: 1px solid rgba(255, 255, 255, 0.08);
        box-shadow: 
          0 25px 50px -12px rgba(0, 0, 0, 0.5),
          inset 0 1px 0 rgba(255, 255, 255, 0.1);
        animation: cardEnter 1s cubic-bezier(0.16, 1, 0.3, 1);
      }
      
      @keyframes cardEnter {
        from {
          opacity: 0;
          transform: translateY(40px) scale(0.95);
        }
        to {
          opacity: 1;
          transform: translateY(0) scale(1);
        }
      }
      
      /* 卡片頂部裝飾線 */
      .quote-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 50%;
        transform: translateX(-50%);
        width: 60%;
        height: 1px;
        background: linear-gradient(
          90deg,
          transparent,
          rgba(139, 92, 246, 0.5),
          rgba(236, 72, 153, 0.5),
          transparent
        );
      }
      
      /* ===== 分類標籤 ===== */
      .category-tag {
        display: inline-flex;
        align-items: center;
        gap: 0.4rem;
        padding: 0.4rem 1rem;
        background: linear-gradient(135deg, rgba(139, 92, 246, 0.2), rgba(236, 72, 153, 0.2));
        border: 1px solid rgba(139, 92, 246, 0.3);
        border-radius: 20px;
        font-size: 0.8rem;
        color: rgba(255, 255, 255, 0.8);
        margin-bottom: 1.5rem;
        letter-spacing: 0.1em;
      }
      
      .category-icon {
        font-size: 0.9rem;
      }
      
      /* ===== 引號裝飾 ===== */
      .quote-mark {
        font-family: Georgia, serif;
        font-size: 4rem;
        line-height: 1;
        color: rgba(139, 92, 246, 0.3);
        margin-bottom: -1rem;
        user-select: none;
      }
      
      /* ===== 語錄文字 ===== */
      .quote-wrapper {
        position: relative;
        min-height: 120px;
      }
      
      .quote-text {
        font-family: 'Noto Serif TC', serif;
        color: rgba(255, 255, 255, 0.95);
        margin-bottom: 1.5rem;
        animation: textFade 0.8s ease-out;
      }
      
      @keyframes textFade {
        from {
          opacity: 0;
          transform: translateY(10px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }
      
      /* 短語錄 */
      .quote-text.short {
        font-size: clamp(1.4rem, 3vw, 1.9rem);
        font-weight: 400;
        line-height: 2;
        letter-spacing: 0.08em;
        text-align: center;
      }
      
      /* 中等長度 */
      .quote-text.medium {
        font-size: clamp(1.1rem, 2.2vw, 1.35rem);
        font-weight: 400;
        line-height: 2.2;
        letter-spacing: 0.05em;
        text-align: justify;
        text-justify: inter-ideograph;
      }
      
      /* 長故事 */
      .quote-text.long {
        font-size: clamp(1rem, 1.8vw, 1.15rem);
        font-weight: 400;
        line-height: 2.4;
        letter-spacing: 0.03em;
        text-align: justify;
        text-justify: inter-ideograph;
      }
      
      /* ===== 作者區 ===== */
      .author-section {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 1rem;
        padding-top: 1.5rem;
        border-top: 1px solid rgba(255, 255, 255, 0.08);
        animation: authorFade 0.8s ease-out 0.3s both;
      }
      
      @keyframes authorFade {
        from { opacity: 0; }
        to { opacity: 1; }
      }
      
      .author-line {
        width: 30px;
        height: 1px;
        background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4));
      }
      
      .author-line:last-child {
        background: linear-gradient(90deg, rgba(255, 255, 255, 0.4), transparent);
      }
      
      .quote-author {
        font-family: 'LXGW WenKai TC', serif;
        font-size: 1rem;
        color: rgba(255, 255, 255, 0.6);
        font-style: normal;
        letter-spacing: 0.15em;
      }
      
      /* ===== 字數顯示 ===== */
      .char-count {
        text-align: center;
        font-size: 0.75rem;
        color: rgba(255, 255, 255, 0.3);
        margin-top: 1rem;
        letter-spacing: 0.1em;
      }
      
      /* ===== 按鈕區 ===== */
      .button-group {
        display: flex;
        justify-content: center;
        gap: 1rem;
        margin-top: 2rem;
        flex-wrap: wrap;
      }
      
      .action-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
        padding: 0.9rem 1.8rem;
        border-radius: 50px;
        font-family: 'LXGW WenKai TC', serif;
        font-size: 0.95rem;
        letter-spacing: 0.1em;
        cursor: pointer;
        transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
        border: none;
        outline: none;
      }
      
      .refresh-btn {
        background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 50%, #a855f7 100%);
        color: white;
        box-shadow: 0 4px 20px rgba(99, 102, 241, 0.4);
      }
      
      .refresh-btn:hover {
        transform: translateY(-3px) scale(1.02);
        box-shadow: 0 8px 30px rgba(99, 102, 241, 0.5);
      }
      
      .refresh-btn:active {
        transform: translateY(0) scale(0.98);
      }
      
      .secondary-btn {
        background: rgba(255, 255, 255, 0.05);
        color: rgba(255, 255, 255, 0.7);
        border: 1px solid rgba(255, 255, 255, 0.1);
      }
      
      .secondary-btn:hover {
        background: rgba(255, 255, 255, 0.1);
        color: white;
        transform: translateY(-2px);
      }
      
      .secondary-btn.active {
        background: linear-gradient(135deg, rgba(236, 72, 153, 0.2), rgba(239, 68, 68, 0.2));
        border-color: rgba(236, 72, 153, 0.4);
        color: #f472b6;
      }
      
      /* ===== 進度條 ===== */
      .progress-section {
        margin-top: 2rem;
        text-align: center;
      }
      
      .progress-bar-container {
        width: 100%;
        max-width: 300px;
        height: 3px;
        background: rgba(255, 255, 255, 0.1);
        border-radius: 3px;
        margin: 0 auto 0.8rem;
        overflow: hidden;
      }
      
      .progress-bar-fill {
        height: 100%;
        background: linear-gradient(90deg, #6366f1, #8b5cf6, #a855f7);
        border-radius: 3px;
        transition: width 1s linear;
      }
      
      .timer-text {
        font-size: 0.8rem;
        color: rgba(255, 255, 255, 0.4);
        letter-spacing: 0.15em;
      }
      
      .countdown {
        font-family: 'SF Mono', 'Consolas', monospace;
        color: rgba(255, 255, 255, 0.6);
      }
      
      /* ===== 收藏列表 Modal ===== */
      .favorites-panel {
        position: fixed;
        top: 0;
        right: -400px;
        width: 380px;
        max-width: 90vw;
        height: 100vh;
        background: linear-gradient(180deg, rgba(15, 15, 25, 0.98), rgba(10, 10, 15, 0.98));
        backdrop-filter: blur(20px);
        z-index: 1000;
        padding: 2rem;
        overflow-y: auto;
        transition: right 0.5s cubic-bezier(0.16, 1, 0.3, 1);
        border-left: 1px solid rgba(255, 255, 255, 0.1);
        box-shadow: -10px 0 40px rgba(0, 0, 0, 0.5);
      }
      
      .favorites-panel.open {
        right: 0;
      }
      
      .panel-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 2rem;
        padding-bottom: 1rem;
        border-bottom: 1px solid rgba(255, 255, 255, 0.1);
      }
      
      .panel-title {
        font-family: 'Noto Serif TC', serif;
        font-size: 1.3rem;
        color: rgba(255, 255, 255, 0.9);
        letter-spacing: 0.1em;
      }
      
      .close-btn {
        background: none;
        border: none;
        color: rgba(255, 255, 255, 0.5);
        font-size: 1.5rem;
        cursor: pointer;
        padding: 0.5rem;
        transition: color 0.3s;
      }
      
      .close-btn:hover {
        color: white;
      }
      
      .favorite-item {
        background: rgba(255, 255, 255, 0.03);
        border-radius: 12px;
        padding: 1.2rem;
        margin-bottom: 1rem;
        border: 1px solid rgba(255, 255, 255, 0.05);
        transition: all 0.3s ease;
      }
      
      .favorite-item:hover {
        background: rgba(255, 255, 255, 0.06);
        border-color: rgba(139, 92, 246, 0.3);
      }
      
      .favorite-quote {
        font-size: 0.9rem;
        color: rgba(255, 255, 255, 0.8);
        line-height: 1.8;
        margin-bottom: 0.8rem;
      }
      
      .favorite-author {
        font-size: 0.8rem;
        color: rgba(255, 255, 255, 0.4);
        text-align: right;
      }
      
      .empty-favorites {
        text-align: center;
        color: rgba(255, 255, 255, 0.4);
        padding: 3rem 1rem;
        font-size: 0.9rem;
        line-height: 1.8;
      }
      
      /* ===== 遮罩層 ===== */
      .overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.5);
        z-index: 999;
        opacity: 0;
        visibility: hidden;
        transition: all 0.3s ease;
      }
      
      .overlay.show {
        opacity: 1;
        visibility: visible;
      }
      
      /* ===== 快捷鍵提示 ===== */
      .shortcut-hint {
        position: fixed;
        bottom: 1.5rem;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        gap: 2rem;
        color: rgba(255, 255, 255, 0.3);
        font-size: 0.75rem;
        letter-spacing: 0.05em;
      }
      
      .shortcut-item {
        display: flex;
        align-items: center;
        gap: 0.5rem;
      }
      
      .key {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 24px;
        height: 24px;
        padding: 0 6px;
        background: rgba(255, 255, 255, 0.08);
        border-radius: 4px;
        font-family: 'SF Mono', 'Consolas', monospace;
        font-size: 0.7rem;
      }
      
      /* ===== 通知提示 ===== */
      .toast {
        position: fixed;
        bottom: 80px;
        left: 50%;
        transform: translateX(-50%) translateY(100px);
        background: rgba(20, 20, 30, 0.95);
        backdrop-filter: blur(10px);
        padding: 0.8rem 1.5rem;
        border-radius: 50px;
        color: white;
        font-size: 0.9rem;
        letter-spacing: 0.05em;
        opacity: 0;
        transition: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
        z-index: 2000;
        border: 1px solid rgba(255, 255, 255, 0.1);
      }
      
      .toast.show {
        opacity: 1;
        transform: translateX(-50%) translateY(0);
      }
      
      /* ===== 響應式設計 ===== */
      @media (max-width: 768px) {
        .main-container {
          padding: 1rem;
        }
        
        .quote-card {
          padding: 1.5rem;
          border-radius: 16px;
        }
        
        .quote-mark {
          font-size: 3rem;
        }
        
        .button-group {
          flex-direction: column;
          align-items: stretch;
        }
        
        .action-btn {
          width: 100%;
        }
        
        .shortcut-hint {
          display: none;
        }
        
        .favorites-panel {
          width: 100%;
          right: -100%;
        }
      }
      
      /* ===== 深色主題滾動條 ===== */
      ::-webkit-scrollbar {
        width: 6px;
      }
      
      ::-webkit-scrollbar-track {
        background: rgba(255, 255, 255, 0.05);
      }
      
      ::-webkit-scrollbar-thumb {
        background: rgba(255, 255, 255, 0.2);
        border-radius: 3px;
      }
      
      ::-webkit-scrollbar-thumb:hover {
        background: rgba(255, 255, 255, 0.3);
      }
    "))
  ),
  
  # 背景層
  div(class = "bg-container",
    div(class = "bg-gradient"),
    div(class = "floating-orb orb-1"),
    div(class = "floating-orb orb-2"),
    div(class = "floating-orb orb-3"),
    div(class = "stars")
  ),
  
  # 主內容
  div(class = "main-container",
    # 標題
    div(class = "header",
      h1(class = "main-title", "心靈驛站"),
      p(class = "sub-title", "DAILY INSPIRATIONS")
    ),
    
    # 語錄卡片
    div(class = "quote-card",
      # 分類標籤
      uiOutput("category_tag"),
      
      # 引號裝飾
      div(class = "quote-mark", "「"),
      
      # 語錄內容
      div(class = "quote-wrapper",
        uiOutput("quote_display")
      ),
      
      # 作者
      div(class = "author-section",
        span(class = "author-line"),
        span(class = "quote-author", textOutput("quote_author", inline = TRUE)),
        span(class = "author-line")
      ),
      
      # 字數
      div(class = "char-count", textOutput("char_count", inline = TRUE)),
      
      # 按鈕組
      div(class = "button-group",
        actionButton("refresh", 
          tagList(icon("rotate"), "換一則"),
          class = "action-btn refresh-btn"
        ),
        actionButton("favorite", 
          tagList(uiOutput("fav_icon", inline = TRUE), "收藏"),
          class = "action-btn secondary-btn"
        ),
        actionButton("show_favorites", 
          tagList(icon("heart"), "收藏夾"),
          class = "action-btn secondary-btn"
        )
      ),
      
      # 進度條
      div(class = "progress-section",
        div(class = "progress-bar-container",
          div(id = "progress-fill", class = "progress-bar-fill", style = "width: 100%;")
        ),
        div(class = "timer-text",
          "下一則：",
          span(class = "countdown", textOutput("countdown", inline = TRUE))
        )
      )
    )
  ),
  
  # 收藏面板遮罩
  div(id = "overlay", class = "overlay"),
  
  # 收藏面板
  div(id = "favorites-panel", class = "favorites-panel",
    div(class = "panel-header",
      span(class = "panel-title", "💜 我的收藏"),
      actionButton("close_panel", "×", class = "close-btn")
    ),
    uiOutput("favorites_list")
  ),
  
  # Toast 通知
  div(id = "toast", class = "toast", textOutput("toast_message", inline = TRUE)),
  
  # 快捷鍵提示
  div(class = "shortcut-hint",
    div(class = "shortcut-item",
      span(class = "key", "Space"),
      span("換一則")
    ),
    div(class = "shortcut-item",
      span(class = "key", "F"),
      span("收藏")
    ),
    div(class = "shortcut-item",
      span(class = "key", "L"),
      span("收藏夾")
    )
  ),
  
  # JavaScript
  tags$script(HTML("
    // 鍵盤快捷鍵
    document.addEventListener('keydown', function(e) {
      if (e.target.tagName === 'INPUT' || e.target.tagName === 'TEXTAREA') return;
      
      if (e.code === 'Space') {
        e.preventDefault();
        document.getElementById('refresh').click();
      } else if (e.key.toLowerCase() === 'f') {
        document.getElementById('favorite').click();
      } else if (e.key.toLowerCase() === 'l') {
        document.getElementById('show_favorites').click();
      } else if (e.key === 'Escape') {
        document.getElementById('close_panel').click();
      }
    });
    
    // 收藏面板控制
    Shiny.addCustomMessageHandler('togglePanel', function(open) {
      var panel = document.getElementById('favorites-panel');
      var overlay = document.getElementById('overlay');
      if (open) {
        panel.classList.add('open');
        overlay.classList.add('show');
      } else {
        panel.classList.remove('open');
        overlay.classList.remove('show');
      }
    });
    
    // 點擊遮罩關閉面板
    document.getElementById('overlay').addEventListener('click', function() {
      document.getElementById('close_panel').click();
    });
    
    // Toast 通知
    Shiny.addCustomMessageHandler('showToast', function(message) {
      var toast = document.getElementById('toast');
      document.getElementById('toast_message').innerText = message;
      toast.classList.add('show');
      setTimeout(function() {
        toast.classList.remove('show');
      }, 2500);
    });
    
    // 更新進度條
    Shiny.addCustomMessageHandler('updateProgress', function(percent) {
      document.getElementById('progress-fill').style.width = percent + '%';
    });
  "))
)

server <- function(input, output, session) {
  
  # 當前語錄索引
  current_index <- reactiveVal(sample(nrow(quotes), 1))
  
  # 收藏列表
  favorites <- reactiveVal(integer(0))
  
  # 計時器 (600秒 = 10分鐘)
  timer <- reactiveVal(600)
  total_time <- 600
  
  # Toast 訊息
  toast_msg <- reactiveVal("")
  
  # 每秒更新
  observe({
    invalidateLater(1000, session)
    isolate({
      t <- timer()
      if (t > 0) {
        timer(t - 1)
        # 更新進度條
        percent <- (t / total_time) * 100
        session$sendCustomMessage("updateProgress", percent)
      } else {
        current_index(sample(nrow(quotes), 1))
        timer(total_time)
      }
    })
  })
  
  # 手動刷新
  observeEvent(input$refresh, {
    current_index(sample(nrow(quotes), 1))
    timer(total_time)
  })
  
  # 收藏/取消收藏
  observeEvent(input$favorite, {
    idx <- current_index()
    fav <- favorites()
    
    if (idx %in% fav) {
      favorites(setdiff(fav, idx))
      session$sendCustomMessage("showToast", "已從收藏夾移除")
    } else {
      favorites(c(fav, idx))
      session$sendCustomMessage("showToast", "已加入收藏夾 💜")
    }
  })
  
  # 顯示收藏面板
  observeEvent(input$show_favorites, {
    session$sendCustomMessage("togglePanel", TRUE)
  })
  
  # 關閉收藏面板
  observeEvent(input$close_panel, {
    session$sendCustomMessage("togglePanel", FALSE)
  })
  
  # 獲取尺寸類別
  get_size_class <- function(text) {
    n <- nchar(text)
    if (n <= 100) "short"
    else if (n <= 200) "medium"
    else "long"
  }
  
  # 分類標籤
  output$category_tag <- renderUI({
    cat <- quotes$category[current_index()]
    icons <- list(
      "勇氣" = "🦁", "自省" = "🪞", "行動" = "🚀", "時間" = "⏰", "夢想" = "✨",
      "努力" = "💪", "毅力" = "🏔️", "初心" = "🌱", "成長" = "🌳", "自信" = "👑",
      "渴望" = "🔥", "逆境" = "🌊", "耐心" = "🎋", "心態" = "🧠", "批評" = "🎨"
    )
    icon <- icons[[cat]] %||% "💫"
    
    div(class = "category-tag",
      span(class = "category-icon", icon),
      cat
    )
  })
  
  # 顯示語錄
  output$quote_display <- renderUI({
    quote_text <- quotes$quote[current_index()]
    size_class <- get_size_class(quote_text)
    div(class = paste("quote-text", size_class), quote_text)
  })
  
  # 作者
  output$quote_author <- renderText({
    quotes$author[current_index()]
  })
  
  # 字數
  output$char_count <- renderText({
    paste0("共 ", nchar(quotes$quote[current_index()]), " 字")
  })
  
  # 收藏圖標
  output$fav_icon <- renderUI({
    if (current_index() %in% favorites()) {
      icon("heart", class = "fas", style = "color: #f472b6;")
    } else {
      icon("heart", class = "far")
    }
  })
  
  # 倒數計時
  output$countdown <- renderText({
    t <- timer()
    sprintf("%02d:%02d", floor(t / 60), t %% 60)
  })
  
  # Toast 訊息輸出
  output$toast_message <- renderText({
    toast_msg()
  })
  
  # 收藏列表
  output$favorites_list <- renderUI({
    fav <- favorites()
    
    if (length(fav) == 0) {
      return(div(class = "empty-favorites",
        p("🌙"),
        p("還沒有收藏任何語錄"),
        p("點擊「收藏」按鈕或按 F 鍵即可收藏")
      ))
    }
    
    tagList(
      lapply(fav, function(idx) {
        div(class = "favorite-item",
          div(class = "favorite-quote",
            substr(quotes$quote[idx], 1, 80),
            if (nchar(quotes$quote[idx]) > 80) "..." else ""
          ),
          div(class = "favorite-author",
            paste("—", quotes$author[idx])
          )
        )
      })
    )
  })
}

shinyApp(ui = ui, server = server)