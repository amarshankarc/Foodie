# Foodie

A  Flutter project For Machine Test



## Project Overview

This Flutter project is designed to provide a seamless user experience for managing dishes and placing orders. It includes features such as user authentication, a user home screen displaying dish categories and dishes fetched from an API, a checkout screen for reviewing selected products, and a side navigation bar for user interaction.

## Features

### User Authentication Screen

- Implement Firebase Authentication for Google and Phone number authentication.
- Users can authenticate using their Google account or phone number.

### User Home Screen

- Upon successful authentication, users are redirected to the home screen.
- The home screen displays dish categories fetched from an API.
- Dish categories are presented in a slidable format for easy navigation.
- Each dish category includes a list of dishes.
- If a dish has addons, it displays the text "Customizations available".
- Users can adjust the quantity of dishes using the '+' and '-' buttons, with the cart icon updating accordingly.
- Currency displayed is INR (Indian Rupees) instead of SAR (Saudi Riyal).

### Checkout Screen

- Selected products from the home screen are listed in the Order Summary page.
- Users can review their selected products before placing an order.
- Clicking on the "Place Order" button prompts a dialogue confirming the successful placement of the order.
- Upon placing the order, users are redirected to the homepage with all selected products cleared.

### Side Navigation Bar

- The side navigation bar displays the Firebase username/phone and Firebase UID.
- Users have the option to logout from the application.

## Installation

To run this Flutter project, follow these steps:

1. Clone this repository to your local machine.
2. Ensure you have Flutter installed. If not, refer to the [official Flutter installation guide](https://flutter.dev/docs/get-started/install).
3. Navigate to the project directory in your terminal.
4. Run `flutter pub get` to install dependencies.
5. Connect your Flutter project to Firebase by following the instructions in the [Firebase documentation](https://firebase.flutter.dev/docs/overview).
6. Run `flutter run` to launch the application on your preferred device/emulator.

## Usage

1. Launch the application.
2. Authenticate using your Google account or phone number.
3. Explore dish categories and select dishes.
4. Adjust the quantity of selected dishes if necessary.
5. Proceed to the checkout screen to review your order.
6. Place the order and confirm the successful placement.
7. Navigate through the side navigation bar for additional options such as logout.

## Support

If you encounter any issues or have any questions regarding this project, feel free to [open an issue](https://github.com/amarshankc/Foodie/issues) on GitHub.

---
