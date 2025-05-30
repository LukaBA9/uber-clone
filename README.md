Hello fellow developers!
This is an Uber Clone built in xCode using SwiftUI and MapKit.
Its main purpose is to show the use of MapKit with SwiftUI in practice.

Tested on iPhone 16 Pro.
Unit Tests are being written as of 29.05.2025

The app grants you with a beutiful map view centered at your current position.

<img src="https://github.com/user-attachments/assets/9b5bb0eb-fc8c-4818-8048-768cb7ef74dc" width="245">

<img src="[https://github.com/user-attachments/assets/9b5bb0eb-fc8c-4818-8048-768cb7ef74dc](https://github.com/user-attachments/assets/06279e21-dbcb-4e03-8241-37be0aefda27)" width="245">
<img src="https://github.com/user-attachments/assets/4c75da2f-5d04-47d6-8904-8b4e1960b3c5" width="245">

The app shows you the most efficient route, and enables you to choose different vehicles based on your needs.
<img src="https://github.com/user-attachments/assets/0cc0b82f-69d1-4145-8925-9afd217a910b" width="245">

The app contains nice animations enhancing the UX.

<img src="https://github.com/user-attachments/assets/b0472014-44fa-41a3-9b58-c41e94f5cdba">

Highlight problems:
1. The app calculates where the route is and how it should render it manually, mainly to take advantage of animations.
2. When the user selects the location he was searching for, but while it is being selected, he changes his mind, he can just
   tap the input field again and the searching algorithms will be cancelled.

Thank you for reading this readme, If you feel like it, take a look at the code, it is moderatly abstract, and is very scalable.
