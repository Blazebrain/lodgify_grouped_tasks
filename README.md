# lodgify Grouped Tasks

Lodgify Grouped Tasks is a product offered by Lodgify, a company focused on building direct channel technology which empowers vacation rental owners and property managers to create a professional website and grow direct bookings, free from commissions. 

## Brief Desciption
Lodgify Grouped Tasks is built to enable the smooth coordination and management of assigned tasks within Lodgify. Supported by a robust API endpoint, it fetches a list of tasks which as been laid down in a particular time period. The endpoint returns the tasks in various states: Completed and Uncompleted Tasks. It has a progress loader which displays the current state of the Task Manager, taking the current state of all the tasks into consideration. When a task is marked done, it updates the state of the loader and increases it's value. The scalar value for this increase is gotten by getting the normalized value for the increase.

## Architectural Pattern Used
The codebase follows the MVVM architectural pattern, which ensures appropriate separation of concerns with the codebase. The MVVM here stands for Model - View - ViewModel. In this architectural pattern, the business logic guiding the various features for the product is placed into the ViewModel, the View would contain the UI code with little to no logic within it files. Lastly, the Models are used to convert the raw data coming from the endpoint into structured data objects that can be used within the application. 

## Why MVVM? 
For a project to be scalable, readable and maintanable, separation of concern is a key factor for consideration. From the way external data is fetched, to it's setup, and lastly how its consumed within the view files. Separation of concerns is a key principle when building maintanable and scalable codebases. Since Lodgify Grouped Tasks is built to last long and be highly maintanable, with the prospect of adding new features in the nearest future, MVVM comes out as the best architectural principle to achieve this task

## Folder Structure
- lib
    - app: The App folder contains configuration information for the entire codebase. Services, routes and loggers are declared and registered here .
    - model: The Model Folder contains the various models which converts data gotten from the endpoint, converting the data into structured, usable data that can be easily used.
    - services: The Services Folder contains files which serves as a point of contact between the application and third party tools/ data sources. E.g the Api Service folder provides an interface through which the app can make use of the dio package to make network requests.
    - ui: The UI folder contains the views and the shared components folder. These shared componennt may include reuasable widgets, snackbars, bottomsheets etc.
    - utils: The Utils folder contains files that perform specific task within the codebase, from api_assets to enums etc.

## Tools/Pacakges used
  - [dio](https://pub.dev/packages/dio): The Dio packages handles network connection to external APIs. It enables us receive data from API endpoints and make use of these data within the application.
  - [flutter_screenutil](https://pub.dev/packages/flutter_screenutil): Flutter Screenutil enhances responsiveness within the mobile application.
  - [logger](https://pub.dev/packages/logger): Logger provides a cleaner and smoother way to logging important information within the application.
  - [percent_indicator](https://pub.dev/packages/percent_indicator): Percent indicator grants us access to a linear loadeer with percent increment.
  - [stacked](https://pub.dev/packages/stacked): Stacked provides a unified interface for implementing MVVM architectual pattern
  - [stacked_services](https://pub.dev/packages/stacked_services): Stacked Services offers out-of-the-box, ready to use services perform specific functions in the app.
  - [window_size](https://github.com/google/flutter-desktop-embedding/tree/master/plugins/window_size): Window Size grants us access to controls which enables us set the minimum width and height the Desktop app can minimize to.
  - [stacked_generator](https://pub.dev/packages/stacked_generator): Stacked Generator allows us run the build runner in order to generate files based on annotations.

## Key things to note
  - The Guiding Formula to get the normalized value for the progress:  
    Nt = Vt * 100 / ∑(Vt)    
        Where :  
          Nt = normalizedValue  
          Vt = taskValue  
          ∑(Vt) = Sum of all tasksValue

        
## To run the app:
- Fork the repo.
- Clone the forked repo to your local machine
- Open up the cloned folder in
## To Contribute:
- Fork the repo.
- Clone your forked repo.
- Run the command flutter pub get to get dependencies.
- Build and run the application.
- Create a new branch.
- Make changes in that branch on your local machine.
- Commit and push changes to your forked repo.
- Make a Pull Request to the dev branch on the main repo.
- Tag or inform the Lead and await review and subsequent approval.

This codebase was created using Flutter version 2.10.4 and Dart version 2.16.2
