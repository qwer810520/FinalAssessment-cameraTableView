## 實作說明
### 前置作業
1. 一開始建立專案時一併開啟CoreData功能，一開始先在FinalAssessment_5.xcdatamodeld檔案裡面建立一個新的Model，並在裡面建立name(String型別)以及photo(Binart Data型別)最後設定Class名稱為photoMo。
![](https://github.com/qwer810520/FinalAssessment-cameraTableView/blob/master/FinalAssessment-5/Assets.xcassets/CoreData.imageset/CoreData.png)

### 首頁
- 首先先在storyboard裡面建立首頁TableView，並且cell裡面放進imageView(顯示照片)以及label(顯示文字)，並且加入NavigationController。
- 接下來建立一個新的MainTableViewController跟MianTableViewCell的檔案，並且跟storyBoard上的元件做連結，接下來在TableViewController建立一個變數陣列(PhotoMo型別)，用來儲存CoreData資料，再來寫一個function來載入CoreData的資料並且存入陣列裡面，並且在viewDidLoad()裡面去執行這個方法，接下來設定Cell的行數以及列數，最後設定Cell上的元件跟要顯示的資料做連結。
- 接著呼叫editActionsForRowAt的function來寫入分享以及刪除動作。

#### 頁面顯示
![](https://github.com/qwer810520/FinalAssessment-cameraTableView/blob/master/FinalAssessment-5/Assets.xcassets/1.imageset/1.PNG)

![](https://github.com/qwer810520/FinalAssessment-cameraTableView/blob/master/FinalAssessment-5/Assets.xcassets/1-2.imageset/1-2.PNG)

### 新增頁面
- 再來回到storyboard拉近一個ViewController，以及在首頁的NavigationController的右邊拉近一個新的Item，並且將scrollView元件先拉近ViewController裡面，接著在scrollView加進一個UIView，並在UIView再加入一個UIImageView跟TextField元件。
- 接著建立一個新的AddPhotoViewController的檔案並且設定與剛剛建立的ViewController連結，並將元件跟Controller的連結建立好，再來在Class呼叫UIImagePickerControllerDelegate跟UINavigationControllerDelegate協定。
- 接著在viewDidLoad裡面去呼叫手機內建相機功能，接著在viewDidLoad外寫入一個ImagePickerController的didFinishPickingMediaWithInfo的function來接收所拍攝的照片，並且將相片顯示在UIImageView上。
- 接著在Class那邊呼叫UITextFieldDelegate協定，接著在viewDidLoad裡面設定Delegate給AddPhotoViewController，並且在textFieldDidBeginEditing的function裡面設定scrollView往上移的250高度、以及在textFieldDidEndEditing的function寫入scrollView移回正常位置，最後在textFieldShouldReturn設定按下鍵盤Return要縮下鍵盤的動作。
- 最後在viewDidDisappear執行將所拍的照片以及文字存入CoreData裡面(因為在相機畫片被present出來時會呼叫到viewDidDisappear，所以我建立了一個Bool值的變數，一開始為false(不會執行存入動作)，當拍完照並且確定相片時變數就會變成true，當按下返回鍵首頁時就會執行儲存動作)。

#### 頁面顯示
![](https://github.com/qwer810520/FinalAssessment-cameraTableView/blob/master/FinalAssessment-5/Assets.xcassets/2.imageset/2.PNG)

![](https://github.com/qwer810520/FinalAssessment-cameraTableView/blob/master/FinalAssessment-5/Assets.xcassets/2-1.imageset/2-1.PNG)

### 顯示內容頁面
- 再回到StoryBoard裡，在建立一個新的ViewController，並且在裡面加入一個scrollView以及Label，並且在scrollView裡面拉近一個UIImageView元件，並設定所有相關的AutoLayout。
- 接著建立一個新的ShowDetailViewController檔案，並跟剛剛所建立的ViewController做元件以及Class上的連結，並建立兩個變數來存首頁丟過來的資料，一個變數selectPhoto(UIImage型別)，另一個變數selectName(String型別)。
- 接著回到MainTableView裡面宣告一個didSelectRowAt的function，並且跟ShowDetailViewController做連結，並將點選到Cell傳出的值先設定好，最後用Push的方式來轉場並傳出。
- 接著回到ShowDetailViewController，首先先在ViewDidAppear裡面將接收到的值傳到相對應的元件上去做顯示，接著在Class宣告UIScrollViewDelegate協定，並在viewDidLoad裡面宣告delegate給本身Class，並且設定scrollView放大的最大倍數為兩倍，最後呼叫viewForZooming的方法來設定要執行放大的UIImageView。

#### 頁面顯示
![](https://github.com/qwer810520/FinalAssessment-cameraTableView/blob/master/FinalAssessment-5/Assets.xcassets/3.imageset/3.PNG)

![](https://github.com/qwer810520/FinalAssessment-cameraTableView/blob/master/FinalAssessment-5/Assets.xcassets/3.imageset/3-1.PNG)



### 參考資訊
[iOS 10 App程式設計實力超進化實戰攻略：知名iOS教學部落格AppCoda作家親授實作關鍵技巧讓你不NG](http://www.books.com.tw/products/0010736555)

[Request Permission for Camera and Library in iOS 10 - Info.plist](http://stackoverflow.com/questions/39631256/request-permission-for-camera-and-library-in-ios-10-info-plist)