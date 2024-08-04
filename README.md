# SHIELD HEALTH APP
Database-driven app to be to keep track of daily intake to make sure we eat a properly to avoid malnutriton or obesity.The App contains pages like - Home, Sign In, Food page and Today's nutritional intake visualisation, has a Deep learning model to detect food through images and analysis the major nutrients.used Isar database for authentication

# UI
The mobile application was developed using Flutter, a cross-platform framework that enabled efficient development and deployment on both iOS and Android platforms. This choice ensured consistency in user experience across different devices and streamlined the development process.
User Interface (UI)
A visually appealing and intuitive UI was crafted using Flutter’s rich set of widgets. The layout prioritized clear navigation and easy accessibility to key features, ensuring a user-friendly experience.
Significant emphasis was placed on creating a user-friendly and intuitive experience. The app's design adhered to platform-specific guidelines, such as Material Design for Android and Human Interface Guidelines for iOS, ensuring familiarity and ease of use. Clear and concise instructions were provided throughout the app to guide users through the food logging process, enhancing overall usability.
Image Capture and Processing
The app incorporated a camera module to capture images of food items. Within the app, image preprocessing steps such as resizing and normalization were implemented to prepare the images for model input.
Model Integration
The TensorFlow Lite model for nutrition estimation was integrated into the app using Flutter's platform-specific channels. This integration enabled efficient on-device inference and real-time results.
Data Storage
A local database was implemented using Isar to store user information, food logs, and estimated nutritional values. This allowed for offline access to data and facilitated synchronization across devices.
User Authentication
A secure authentication system was implemented using standard authentication protocols to protect user data and privacy.

App Features 
Login and Registration :Users could create accounts and log in to access personalized features and track their dietary progress. This feature ensured a personalized experience for each user.

Nutrition Tracker :The app featured a visually engaging dashboard displaying daily, weekly, and monthly nutritional summaries. This provided users with valuable insights into their dietary patterns.

Image-Based Food Logging : Users could capture images of their meals, and the app would process these images using the integrated deep learning model to estimate their nutritional content.

Manual Food Entry : For food items not recognized by the model, a manual input option was provided. This allowed users to add nutritional information manually, ensuring comprehensive tracking.

Settings  : Users could customize the app's appearance, units of measurement, and notification preferences to suit their personal needs and preferences.


![image](https://github.com/user-attachments/assets/a25105f7-4672-4a29-a2ea-991804176738)
![image](https://github.com/user-attachments/assets/13399555-6081-4d53-a687-1e4b8f899fca)
![image](https://github.com/user-attachments/assets/5e139cfc-2cac-4090-9b87-5f67fb9a832b)
![image](https://github.com/user-attachments/assets/97b1b569-c95c-45ff-920b-0f8f9d477c90)

Food Image Recognition and Nutrition Tracking module
Machine learning modules for food recognition
Training Process
The dataset, consisting of 101,000 images, was divided into training and testing sets, with 80% (81,600 images) allocated for training and 20% (10,200 images) for testing. To ensure consistent input to the models, images were resized to 128x128 pixels and normalized. Data augmentation techniques, including random cropping, flipping, and rotation, were applied to the training images to prevent overfitting. Both the custom CNN and MobileNet_v3 models were trained using the Adam optimizer with a learning rate of 0.001. The training process spanned 20 epochs, with batch sizes of 32 images, and incorporated early stopping to halt training if the validation loss failed to improve for five consecutive epochs. This strategy optimized training time and prevented the development of overly complex models prone to overfitting. 

Custom CNN Architecture
The custom convolutional neural network (CNN) was designed to extract relevant features from food images and predict nutritional content. This architecture consisted of several components aimed at efficient feature extraction and classification. The network started with three convolutional layers, each employing a 3x3 filter size. The first layer used 32 filters, while the subsequent layers utilized 64 filters each, all activated using the ReLU function to introduce non-linearity. To downsample the feature maps and reduce computational complexity, max pooling layers with a 2x2 kernel were incorporated after the first and second convolutional layers. The output of the final convolutional layer was then flattened into a one-dimensional vector, preparing the data for fully connected layers. Following this, two dense layers with 128 neurons each were employed, also using the ReLU activation function. Finally, an output layer with 101 neurons, corresponding to the number of food categories, utilized a softmax activation function to generate class probabilities.

MobileNet_v2 Architecture
In addition to the custom CNN, MobileNet_v2 was implemented to explore a more efficient and potentially higher-performing architecture. MobileNet_v2, known for its lightweight design and accuracy, was fine-tuned specifically for nutrition estimation. The model’s architecture was adapted by replacing its final classification layer with a custom layer tailored to predict nutritional values. This pre-trained model provided a strong baseline, leveraging transfer learning to enhance performance on the specific task of food image classification.



