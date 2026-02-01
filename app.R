library(shiny)
library(bslib)

# 勵志語錄資料 - 增加分類標籤
quotes <- data.frame(
  quote = c(
    #20260201
    "在阿里山的茶園裡，一位年輕人看著老茶農只摘頂端的嫩芽，忍不住問：「伯伯，為什麼不一次多摘一些？這樣不是更快賣錢嗎？」老茶農笑著搖頭：「好茶不是摘得多，而是摘得對。春茶最嫩的那一兩葉，味道最純；如果貪心多摘，葉子老了，茶就苦了。採茶像談戀愛，不能急，一急就錯過最好的時機。」年輕人追問：「那您什麼時候才能喝到最好的茶？」老人指著山坡上那片還在霧中的茶樹：「不是我喝到，是茶自己成熟。我每天只做該做的事：修枝、除草、等露水乾、等雲散。最好的茶，是在對的季節、對的溫度、對的手法下，自然長出來的。你看那些急著催肥的茶園，葉子大而無味；我的茶雖然產量少，卻香得讓人記一輩子。」他遞給年輕人一杯熱茶：「人生也一樣。很多人想一次摘完所有果實，結果什麼都沒味道。真正的收穫，是每天只摘『對的那一芽』——今天多學一點、多愛一點、多堅持一點。別急，茶香會在該來的時候，悄悄溢出來。」",
    "一位教授將一枚金戒指丟進泥土裡，踩了幾腳，問學生：「它還值錢嗎？」學生說值。教授又把它丟進污水桶、丟進火裡燒，再問：「它現在還是金子嗎？」學生點頭。教授說：「只要你認清自己的本質是金子，外界的羞辱、困境或挫折，都只是表面的汙垢，洗掉就好，傷不到你的內在。」別讓別人的評價或暫時的失意，腐蝕了你對自我價值的認知。你是金子，就永遠不會因為掉進泥土而變成石頭。",
    "麻雀看著雄鷹在高空盤旋，嘲笑說：「上面風那麼大，又冷又危險，還要費力拍翅膀，哪像我在灌木叢裡有蟲吃又有窩睡？」雄鷹沒理會，只是振翅飛得更高，因為牠看見的是地平線的盡頭，而麻雀看見的只有那幾顆漿果。當你試圖改變、試圖飛得更高時，身邊一定會有平庸的聲音勸你留下。不要去爭辯，因為雄鷹不需要向麻雀解釋為什麼天空更值得嚮往。",
    "珍珠，其實是蚌的一場災難。當一顆粗糙的砂礫掉進蚌柔軟的肉裡，那種摩擦與疼痛是難以言喻的。蚌無法將砂礫吐出，只能選擇分泌出珍珠質，一層又一層地包裹這份痛苦。多年後，這份曾經的「創傷」，成了世人眼中最璀璨的寶藏。如果你現在正經歷某種無法擺脫的痛苦，請試著用你的溫柔與堅毅去包裹它。最終，那些讓你感到疼痛的磨難，都會成為你生命中最閃耀的珍珠。",
    "根據空氣動力學的理論，大黃蜂的翅膀相對於龐大且圓潤的身軀來說，其實太小了，在理論上牠應該是飛不起來的。但大黃蜂不知道這個理論，牠只知道自己必須飛去採蜜，於是牠用力振翅，最終牠飛起來了，且飛得比誰都勤快。如果你聽信了世界的「理論」與「限制」，你可能一輩子都飛不起來。別讓科學或別人的邏輯定義你的可能，有些奇蹟，只要你「不知道自己做不到」，就能發生。",
    # 20260131
    "兩個樵夫比賽砍柴，年輕的樵夫一整天不停歇，累得氣喘吁吁；年老的樵夫每砍一小時就休息十分鐘。 傍晚結算時，年老的樵夫砍的柴竟然比年輕的多出一倍。 年輕人不服氣：「我一直沒停，你一直在休息，怎麼可能比我多？」 老樵夫微笑說：「我休息的時候，其實是在磨我的斧頭。斧頭鈍了，再用力也是白費力氣。」磨刀不誤砍柴工。當你覺得生活讓你感到吃力時，停下來「磨亮」你的心智與技能，比盲目努力更有成效。",
    "教授拿起一杯水問學生：「這杯水有多重？」學生猜測從 200 克到 500 克不等。教授說：「水的重量不變，但取決於你拿多久。拿一分鐘沒問題；拿一小時肩膀會酸；拿一天，你的手臂會麻木癱瘓。」壓力與過去的包袱也是如此。拿著它並不可怕，可怕的是你忘了把它「放下」。放下不代表背叛過去，而是為了讓雙手有力氣去擁抱未來。",
    "一群青蛙在比賽爬高塔，圍觀的群眾都在喊：「太難了！絕對上不去的！」青蛙們一隻隻精疲力竭地掉下來，最後只剩一隻小青蛙爬到了頂端。大家驚奇地問牠秘訣，才發現原來那隻青蛙是個聾子。牠聽不到外面的否定，所以牠只聽見內心想登頂的聲音。有時候，為了保護你的夢想，你必須學會對那些說你「不行」的人裝聾作啞。",
    "一個孩子站在搖晃的吊橋前不敢前行，看著深谷瑟瑟發抖。 父親對他說：「孩子，你不需要看到橋的另一頭，你只需要看清你腳下那一步的木板，然後踩上去。」 當孩子一步接著一步，只專注於當下的那一小塊木板時，不知不覺，他已經站在了彼岸。恐懼往往來自於對「遠方」的過度想像。如果你覺得目標太遠、圍牆太高，就先專注於腳下那一步。只要在走，路就會出現。",
    "生物學家曾做過一個實驗：將跳蚤放進玻璃罐，跳蚤會輕易跳出。隨後，實驗者蓋上透明蓋子，跳蚤每次跳躍都會撞到蓋子。 一段時間後，即便拿掉蓋子，跳蚤也再也不會跳出罐口了——因為牠已經「學會」了高度的限制。很多時候，我們就像那隻跳蚤。過去的挫折成了我們頭頂看不見的蓋子，讓我們忘了自己其實擁有跳得更高、看更遠的能力。",
    "鐵達尼號不是撞上了海面上的冰塊，而是撞上了海面下看不見的巨大冰山。 人的能力也是如此，你現在表現出來的「行為」，只是露在水面上的 10%。而那些被壓抑的勇氣、創造力與韌性，都沉睡在深海之中。不要用那 10% 的現況來定義你自己。只要你願意挖掘，海面下還有 90% 的奇蹟等著被你喚醒。",
    "有兩個人生病住在同一個病房，其中一個人靠窗，每天他都會向室友描述窗外的景象： 「今天公園裡有孩子在放風箏，湖面上有天鵝在戲水，天氣好極了。」 另一位室友聽著聽著，心裡漸漸產生了希望，每天都期待著這段描述。 後來，靠窗的人出院了，另一人迫不及待地看向窗外，卻發現窗外只有一堵冷冰冰的磚牆。他這才明白，美好的風景不一定是在窗外，而是在一個人的心裡。如果你心中有光，即便面對殘牆，也能看見萬紫千紅。",
    "一位年輕的樂師問佛陀：「我每天修行非常刻苦，為什麼還是感覺不到進步？」 佛陀問他：「你彈琴時，如果琴弦調得太緊會怎樣？」 樂師答：「弦會斷。」 佛陀又問：「如果調得太鬆呢？」 樂師答：「彈不出聲音。」 佛陀微笑說：「修行與生活也是如此。太緊則累，太鬆則廢。唯有保持適度的張力，才能彈奏出美妙的樂章。」",
    
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
    "一位畫家把作品放在廣場上，請路人用紅筆圈出缺點。一天後，畫作被圈得滿滿的。他很沮喪。老師說：「再畫一幅，這次請路人圈出優點。」結果優點比缺點還多。老師說：「無論你做什麼，都會有人批評，也會有人欣賞。你要做的不是討好所有人，而是不斷精進，讓欣賞你的人越來越多。」",
    
    # 新增勵志小故事
    "愛迪生在發明燈泡前失敗了一萬次。有人問他：「失敗這麼多次不灰心嗎？」他笑著說：「我沒有失敗，我只是發現了一萬種不能用的材料。」每一次所謂的失敗，都是通往成功的必經之路。重點不是跌倒幾次，而是你願不願意再站起來。",
    "兩個推銷員被派到非洲賣鞋。第一個人抵達後發電報回公司：「這裡沒有市場，因為所有人都不穿鞋。」第二個人卻興奮地回報：「這裡商機無限，因為還沒有人穿鞋！」同樣的現實，不同的視角，造就截然不同的命運。你看到的是困難，還是機會？",
    "老鷹是世界上壽命最長的鳥類。但在牠 40 歲時，爪子會開始老化、喙會變得又長又彎，羽毛也會變得沉重。這時牠面臨兩個選擇：等死，或是經歷 150 天痛苦的「蛻變」。 牠必須用喙擊打岩石直到脫落，長出新喙後，再把老化的趾甲和羽毛一一拔掉。重生很痛，但不重生就是死路一條。如果你覺得現狀讓你窒息，或許是因為你需要一場徹底的「自我修剪」，拔掉那些限制你飛翔的老舊習慣。",
    "一位父親送兒子一塊手錶，說：「這是爺爺傳下來的，先去當鋪問問值多少錢。」當鋪給了一百元。父親又說：「去古董店問問。」古董店開價十萬。父親說：「記住，只有在對的地方，你的價值才會被看見。不要待在不懂得欣賞你的環境裡，那只會讓你低估自己。」",
    "暴風雨後的海灘上，成千上萬的海星被沖上岸。一個小男孩不斷撿起海星丟回海裡。路人說：「這麼多海星，你救得完嗎？這有什麼意義？」小男孩撿起一隻海星說：「對這一隻來說，很有意義。」改變世界不需要轟轟烈烈，有時只需要一個小小的善舉。",
    "馬戲團裡的大象，小時候被細繩綁住，掙脫不了。長大後力氣足以掙斷鐵鏈，卻仍被同一條細繩困住，因為牠已經相信自己掙脫不了。我們有多少潛能，是被過去的失敗經驗所束縛？真正困住你的，從來不是環境，而是你心中那道無形的圍牆。",
    "蝴蝶破繭時，有人出於好心幫牠剪開繭。結果蝴蝶出來後翅膀萎縮，永遠無法飛翔。原來，蝴蝶必須靠自己掙扎的過程，將體液擠入翅膀才能展翅。人生的掙扎與苦難，不是懲罰，而是讓我們茁壯的必要過程。",
    "一位老人在路邊賣氣球，生意不好時就放一個氣球上天。每次氣球升空，就會吸引孩子來買。一個黑人小孩問：「黑色的氣球也能飛嗎？」老人微笑著放了一個黑氣球，它同樣飛向天空。老人說：「孩子，氣球能不能飛，不是看顏色，而是看裡面有沒有氣。」決定你能飛多高的，是你內心的力量。",
    "一個人抱怨自己沒有鞋穿，直到他遇見一個沒有腳的人。那人坐在路邊，微笑著用雙手撐地前進，眼中沒有一絲怨恨。他突然明白：幸福不是擁有多少，而是計較多少。當你開始感恩已擁有的，你會發現自己比想像中富有。",
    "有人問農夫：「你每天都在做什麼？」農夫說：「春天播種，夏天耕耘，秋天收穫，冬天休息。」那人又問：「那什麼時候才能成功？」農夫笑說：「成功沒有捷徑，但有時刻表。你不能在冬天播種，也不能在春天收穫。做對的事，在對的時間，成功自然會來。」",
    "兩棵樹生長在懸崖邊。一棵抱怨風太大、土太少，最終枯萎。另一棵把根深深扎進岩縫，反而長得更加堅韌。多年後，它成了懸崖上最壯觀的風景。惡劣的環境不一定是詛咒，也可能是讓你與眾不同的祝福。",
    "三隻青蛙坐在荷葉上，其中一隻決定跳進水裡。請問荷葉上還有幾隻青蛙？答案是三隻。因為「決定」和「行動」是兩回事。這個世界上不缺有想法的人，缺的是把想法付諸行動的人。別只是想，去做吧。"
  ),
  author = c(
    #20260201
    "茶農的故事",
    "金戒指的故事",
    "麻雀與雄鷹的差別",
    "珍珠的由來",
    "大黃蜂飛行的故事",
    #20260131
    "樵夫比賽的故事",
    "手裡水的故事",
    "失聰青蛙的故事",
    "吊橋的故事",
    "跳蚤的故事",
    "冰山的故事",
    "窗外的故事",
    "琴弦的故事",
    
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
    "畫家與路人的故事",
    "愛迪生的燈泡",
    "非洲賣鞋的故事",
    "老鷹重生的故事",
    "手錶與價值的故事",
    "海星男孩的故事",
    "馬戲團大象的故事",
    "蝴蝶破繭的故事",
    "氣球老人的故事",
    "沒有鞋的人",
    "農夫的時刻表",
    "懸崖邊的兩棵樹",
    "三隻青蛙的故事"
  ),
  category = c(
    #20260201
    "等待",
    "本質",
    "格局",
    "磨難",
    "格局",
    #20260131
    "專注",
    "重量",
    "噪音",
    "勇氣",
    "框架",
    "潛力",
    "視角",
    "平衡",

    "勇氣", "自省", "行動", "時間", "夢想",
    "努力", "毅力", "初心", "成長", "自信",
    "渴望", "逆境", "耐心", "心態", "批評",
    "堅持", "視角", "重生", "價值", "善良",
    "潛能", "磨練", "內在", "感恩", "時機",
    "韌性", "行動"
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
      
      /* ===== 快捷鍵提示 (左側) ===== */
      .shortcut-hint {
        position: fixed;
        left: 1.5rem;
        top: 50%;
        transform: translateY(-50%);
        display: flex;
        flex-direction: column;
        gap: 0.5rem;
        z-index: 100;
      }
      
      .shortcut-panel {
        background: rgba(255, 255, 255, 0.03);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255, 255, 255, 0.06);
        border-radius: 12px;
        padding: 1rem 0.8rem;
        display: flex;
        flex-direction: column;
        gap: 0.6rem;
      }
      
      .shortcut-title {
        font-size: 0.65rem;
        color: rgba(255, 255, 255, 0.3);
        letter-spacing: 0.15em;
        text-transform: uppercase;
        margin-bottom: 0.3rem;
        padding-bottom: 0.5rem;
        border-bottom: 1px solid rgba(255, 255, 255, 0.06);
      }
      
      .shortcut-item {
        display: flex;
        align-items: center;
        gap: 0.6rem;
        padding: 0.3rem 0;
        transition: all 0.3s ease;
        border-radius: 6px;
        cursor: default;
      }
      
      .shortcut-item:hover {
        background: rgba(255, 255, 255, 0.05);
        padding-left: 0.4rem;
        padding-right: 0.4rem;
        margin-left: -0.4rem;
        margin-right: -0.4rem;
      }
      
      .shortcut-item:hover .key {
        background: rgba(139, 92, 246, 0.3);
        border-color: rgba(139, 92, 246, 0.5);
        color: rgba(255, 255, 255, 0.9);
      }
      
      .shortcut-item:hover .shortcut-label {
        color: rgba(255, 255, 255, 0.7);
      }
      
      .key {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 28px;
        height: 26px;
        padding: 0 8px;
        background: rgba(255, 255, 255, 0.06);
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 6px;
        font-family: 'SF Mono', 'Consolas', 'Monaco', monospace;
        font-size: 0.7rem;
        color: rgba(255, 255, 255, 0.5);
        box-shadow: 0 2px 0 rgba(0, 0, 0, 0.2);
        transition: all 0.3s ease;
      }
      
      .shortcut-label {
        font-size: 0.75rem;
        color: rgba(255, 255, 255, 0.4);
        letter-spacing: 0.05em;
        transition: color 0.3s ease;
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
      
      @media (max-width: 1100px) {
        .shortcut-hint {
          left: 0.8rem;
        }
        
        .shortcut-panel {
          padding: 0.7rem 0.5rem;
        }
        
        .shortcut-label {
          display: none;
        }
        
        .shortcut-title {
          font-size: 0.55rem;
          text-align: center;
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
  
  # 快捷鍵提示 (左側)
  div(class = "shortcut-hint",
    div(class = "shortcut-panel",
      div(class = "shortcut-title", "快捷鍵"),
      div(class = "shortcut-item",
        span(class = "key", "Space"),
        span(class = "shortcut-label", "換一則")
      ),
      div(class = "shortcut-item",
        span(class = "key", "F"),
        span(class = "shortcut-label", "收藏")
      ),
      div(class = "shortcut-item",
        span(class = "key", "L"),
        span(class = "shortcut-label", "收藏夾")
      ),
      div(class = "shortcut-item",
        span(class = "key", "Esc"),
        span(class = "shortcut-label", "關閉")
      )
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
      "渴望" = "🔥", "逆境" = "🌊", "耐心" = "🎋", "心態" = "🧠", "批評" = "🎨",
      "堅持" = "💎", "視角" = "👁️", "重生" = "🦅", "價值" = "⌚", "善良" = "🌟",
      "潛能" = "🐘", "磨練" = "🦋", "內在" = "🎈", "感恩" = "🙏", "時機" = "🌾",
      "韌性" = "🌲"
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