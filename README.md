# SearchMovie
Application for searching, watching and adding movies in Favourite Page.
## **This Application was based by free API service [OMDb](http://www.omdbapi.com).**
Current API easy for testing current type. For full functionallity was used short and full type of API. Short were used for displaying searching table view and display search result. Full were used for displaying full plot information about choosed movie. Full plot include everything, including different types of ratings, awards and etc.

### Important reminder. Current application using only Xcode based frameworks and kits such as UIKit and CoreData.

## **Main Objectives:**
1. Search Page. This page include table view which display image, title, type and release year of movie.
Current API give possibility to make request only 10 items:
<img src="https://user-images.githubusercontent.com/70747233/202728062-04d3cf18-9952-45f2-a403-f03fec056821.png" width="200">
2. Example of user request and result of it:
<img src="https://user-images.githubusercontent.com/70747233/202728100-952b7e02-b18e-48e3-85f8-1b0aaebc13e2.png" width="200">
3. Full plot page. This page consist of full information about movie: Director, Actors, Runtime, Countries, Plot, Ratings and etc. This page was made with ScrollView for more user convenience:
<img src="https://user-images.githubusercontent.com/70747233/202728122-8caf8f61-5bba-4001-a2f2-e9fe6abb5bcd.png" width="200">
4. Possible action with choosed movie. Add to favourite mean save full information about choosed movie in CoreData and display on next page. Open in Browser mean use SafariService which include integrated possibility to open object by link in safari inside applicatio. Share object mean to share object to messangeds, mail application, notes and etc:
<img src="https://user-images.githubusercontent.com/70747233/202728158-a554e752-5ab3-4d28-99fb-2ab97508e098.png" width="200">
5. Result of open link in Safari:
<img src="https://user-images.githubusercontent.com/70747233/202728133-b478c77c-4f75-467d-9476-ce38d2bf4030.png" width="200">
6. Favourite page. This page consist of image, title, rating by IMDb, year and movie runtime. All information are stored in core data and user can get either information about it without Internet connection:
<img src="https://user-images.githubusercontent.com/70747233/202728185-73389586-d422-4c5a-90c8-0a7a742a1b93.png" width="200">
7. Error debugging. In some ways were used Alert Controllers for show some errors of API, incorrect request and etc:
<img src="https://user-images.githubusercontent.com/70747233/202728175-b14c4a7b-ad95-49ea-ba56-52b92a3805d9.png" width="200">

### The objectives which we were achived:
- Using CoreData for saving,loading and deleting data from store. Images storing in Data format, other items in String;
- All User Interface were based and made on code. All user's elements were printed in classes. Storyboard did not used;
- Application using two types of API. Short type and Full. From short type user get IMDb ID and this id used in second API for getting full information;

### **Improvements for the future:**
- Add user's page with his own information;
- Make Setting Page to customize some user's interface elements;
- Add notifications, which will remind user to watch resently added movie in Favourite.
