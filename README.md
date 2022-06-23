DAY 39

Today you have five topics to work through, in which you’ll learn about GeometryReader, ScrollView, NavigationLink, and more.




Moonshot: Introduction


In this project we’re going to build an app that lets users learn about the missions and astronauts that formed NASA’s Apollo space program. You’ll get more experience with Codable, but more importantly you’ll also work with scroll views, navigation, and much more interesting layouts.

Yes, you’ll get some practice time with List, Text, and more, but you’ll also start to solve important SwiftUI problems – how can you make an image fit its space correctly? How can we clean up code using computed properties? How can we compose smaller views into larger ones to help keep our project organized?

As always there’s lots to do, so let’s get started: create a new iOS app using the App template, naming it “Moonshot”. We’ll be using that for the project, but first lets take a closer look at the new techniques you’ll need to become familiar with… 





Resizing images to fit the screen using GeometryReader


When we create an Image view in SwiftUI, it will automatically size itself according to the dimensions of its contents. So, if the picture is 1000x500, the Image view will also be 1000x500. This is sometimes what you want, but mostly you’ll want to show the image at a lower size, and I want to show you how that can be done, but also how we can make an image fit some amount of the user’s screen width using a new view type called GeometryReader.

First, add some sort of image to your project. It doesn’t matter what it is, as long as it’s wider than the screen. I called mine “Example”, but obviously you should substitute your image name in the code below.
Now let’s draw that image on the screen:

struct ContentView: View {
    var body: some View {
        Image("Example")
    }
}

Even in the preview you can see that’s way too big for the available space. Images have the same frame() modifier as other views, so you might try to scale it down like this:

Image("Example")
    .frame(width: 300, height: 300)

However, that won’t work – your image will still appear to be its full size. If you want to know why, take a close look at the preview window: you’ll see your image is full size, but there’s now a box that’s 300x300, sat in the middle. The image view’s frame has been set correctly, but the content of the image is still shown as its original size.

Try changing the image to this:

Image("Example")
    .frame(width: 300, height: 300)
    .clipped()

Now you’ll see things more clearly: our image view is indeed 300x300, but that’s not really what we wanted.
If you want the image contents to be resized too, we need to use the resizable() modifier like this:

Image("Example")
    .resizable()
    .frame(width: 300, height: 300)

That’s better, but only just. Yes, the image is now being resized correctly, but it’s probably looking squashed. My image was not square, so it looks distorted now that it’s been resized into a square shape.

To fix this we need to ask the image to resize itself proportionally, which can be done using the scaledToFit() and scaledToFill() modifiers. The first of these means the entire image will fit inside the container even if that means leaving some parts of the view empty, and the second means the view will have no empty parts even if that means some of our image lies outside the container.

Try them both to see the difference for yourself. Here is .fit mode applied:

Image("Example")
    .resizable()
    .scaledToFit()
    .frame(width: 300, height: 300)
And here is scaledToFill():
Image("Example")
    .resizable()
    .scaledToFill()
    .frame(width: 300, height: 300)

All this works great if we want fixed-sized images, but very often you want images that automatically scale up to fill more of the screen in one or both dimensions. That is, rather than hard-coding a width of 300, what you really want to say is “make this image fill 80% of the width of the screen.”

SwiftUI gives us a dedicated type for this called GeometryReader, and it’s remarkably powerful. Yes, I know lots of SwiftUI is powerful, but honestly: what you can do with GeometryReader will blow you away.
We’ll go into much more detail on GeometryReader in project 15, but for now we’re going to use it for one job: to make sure our image fills the full width of its container view.

GeometryReader is a view just like the others we’ve used, except when we create it we’ll be handed a GeometryProxy object to use. This lets us query the environment: how big is the container? What position is our view? Are there any safe area insets? And so on.

In principle that seems simple enough, but in practice you need to use GeometryReader carefully because it automatically expands to take up available space in your layout, then positions its own content aligned to the top-left corner.

For example, we could make an image that’s 80% the width of the screen, with a fixed height of 300:

GeometryReader { geo in
    Image("Example")
        .resizable()
        .scaledToFit()
        .frame(width: geo.size.width * 0.8, height: 300)
}

You can even remove the height from the image, like this:

GeometryReader { geo in
    Image("Example")
        .resizable()
        .scaledToFit()
        .frame(width: geo.size.width * 0.8)
}

We’ve given SwiftUI enough information that it can automatically figure out the height: it knows the original width, it knows our target width, and it knows our content mode, so it understands how the target height of the image will be proportional to the target width.

Tip: If you ever want to center a view inside a GeometryReader, rather than aligning to the top-left corner, add a second frame that makes it fill the full space of the container, like this:

GeometryReader { geo in
    Image("Example")
        .resizable()
        .scaledToFit()
        .frame(width: geo.size.width * 0.8)
        .frame(width: geo.size.width, height: geo.size.height)
}

