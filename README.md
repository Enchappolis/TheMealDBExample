# TheMealDBExample
> This is an example iOS app that fetches data from https://themealdb.com/api.php
>
> It uses 2 API endpoints. One for fetching desserts and one for showing their details.

### The app was built with
- SwiftUI
- Minimum deployment target of iOS 15.0
- Xcode 15.3
- MVVM
- Async/Await
- Image caching to memory and disk
- Designed with reusability and separation of concerns in mind
- Unit testing
- No third-party frameworks

### Note
The app has several limitations.
- It uses a deployment target of iOS 15. Newer iOS versions simplify navigation with features like NavigationStack, navigationDestination, and router pattern.
- The app simulates a restaurent app. The images in a restaurant menu rarely change. Therefore the app uses image caching to improve performance.
  But there needs to be a way to refresh the cached images. In a production app, it could be done by checking the date or by providing an refresh property in the json response.
  In this app, it is done by doing a pull-to-refresh.
- The API documentation does not specify the data type of each value in the json response object. 
  It was therefore assumed that all data types are of type String.
- The API also does not support pagination.

### Screen
![screenshots](https://github.com/user-attachments/assets/08bb743b-928f-46d8-afc2-bffd994ffc25)





