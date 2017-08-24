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
    
    6. I wanted to follow along during the hot dog test - I downloaded an icon from
    flaticon - here's the author's credit:
    Icons made by Freepik from www.flaticon.com is licensed by CC 3.0 BY
    
    7. I also didn't like how he created the tableView cell, so I added my tableView
    data source and delegate as extensions and registered the cell - used this for
    my information:
    https://medium.com/ios-seminar/why-we-use-dequeuereusablecellwithidentifier-ce7fd97cde8e
    
    8. I also added the camera image to the imageView as the default image since the UI looks
    wierd with nothing in that space when the app is launched.
    
    9. To use this on the phone, we'd need to add the privacy options as we did with the Collector.
    
    10. After all this, the text was too long, so Nick added a custom cell to the tableView - first drag a
    tableView cell onto the tableView.   Add an identifier (on the storyboard).
    
    11. Drag a label onto the cell with layout 0, 0, 0, 0
    
    12. Select the "automatically adjust font" - the reason for the custom cell is that you can't
    do this on a tableView cell otherwise.  Set the minimum font size to 4 - Select Autoshrink which
    then pops up the edit box for the minimum font size.
    
    13. Add a class for the cell.
    
    
