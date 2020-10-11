iPhone Software Engineering Group 30

_Team Members_
s3786695 Ruby Rio
s3646348 Alexandar Kotevski
s3781718 Yashwin Sudarshan
s3781797 Alexander LoMoro

The project is working as expected with no build or runtime errors on Xcode 10.3.
The app has been designed for the iPhone SE (1st generation), however it will also work on other models.

_API Limitations_
The API we are using can only be accessed 5 times per minute, therefore you may experience issues when testing.
Please run the tests individually to avoid hitting the API limit, otherwise some tests will fail due to not being able to load any data from the API.
If you are accessing the API more than 5 times per minute, you will have to wait momentarily before being able to proceed. This is a limitation of the free API.

_UI Testing_
When running UI Tests for Recipe: Solved, we ask that you run these tests *individually*. As stated above, the API has a limitation of 5 hits per minute; when run all together, the UI Tests surpass this limit, causing the latter cases to fail as they cannot retrieve data due to the limitation being breached. In order to ensure that all tests pass successfully, please run each test on its own.
The UI tests were designed for the iPhone SE (1st generation), as per the assignment specification. Please make sure you have this device selected when running UI tests to ensure that all tests pass successfully.

https://github.com/rmit-S2-2020-iPhone/a1-s3646348_-s3786695_s3781797_-s3781718
