#  CoreML Notes

    This tutorial goes over some basics for CoreML which is machine learning.
    
    1. To start, we downloaded a model from developer.apple.com/machine-learning - Nick
    used the ResNet50 model - I did the same.
     
    2. The goal of this app is to display an image and then let the model help us
    detect what the image is (e.g. a cat or whatever)
    
    3. Embed the existing View Controller into a Navigation Controller.  Add a bar button
    item to the VC and make it a camera button.  Repeat for a Organize button.  Add an
    image view and set to 10 top, 10 left , 10 right and height = 300
    
    4. A table view is added that is 0 left, 0 right, 0 bottom, and 0 vertical spacing
    
    5. Then integrate the model just by drag and dropping the model from the file explorer
    into the project (be sure to use "copy").  In the right panel of XCode, you may need to
    click on this file click on the Target Membership checkbox.  Otherwise, XCode will complain
    that no target has been selected.

