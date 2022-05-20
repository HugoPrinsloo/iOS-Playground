//
//  Markdown.swift
//  Playground App
//
//  Created by Hugo Prinsloo on 2022/05/19.
//

import SwiftUI



struct Markdown: View {
    var body: some View {
        Text(
        """
        #Why 🤷🏻‍♂️

        In this PR, we'll look at the changes made to cater for the experiment flow.

        **The Goal:** Users that select the `Remove background` onboarding goal should land on the photo picker where the user will choose the image they'd like to use, and once selected, land them in Canvas with the `Remove Background` tool active.


        More info about [the experiment](https://overhq.atlassian.net/browse/CST-864)


        ![Studio-Project-16](https://user-images.githubusercontent.com/80469971/169041541-4ab34e7c-c507-4641-b4ce-96a1b53189fb.png)



        #Let's chat code 👨🏻‍💻
        > AppNavigationCoordinator

        ### How do we land the user in the Photo Picker?

        We can pass in a  **starting point** when initializing `CreateTabViewController`

        <img width="500" src="https://user-images.githubusercontent.com/80469971/169046216-28aeaafa-7cf6-4654-8e1a-6a03c5c44a80.png">







        ### How do we land the user in Canvas with the RBG tool enabled?
        We can `showProjectEditor` with the `initialAction set to **removeBackground**

        <img width="700" src="https://user-images.githubusercontent.com/80469971/169045055-d1b77635-e20d-4014-8a4f-2a2b7a5bad2c.png">


        Changing the goal property to a `var` so that we can set the goal to `nil` once they landed in the goal flow to avoid this flow to happen each time the user starts a project with a photo
        <img width="200" alt="CleanShot 2022-05-18 at 14 46 06@2x" src="https://user-images.githubusercontent.com/80469971/169041828-3ec99c64-3ecd-4340-a2fa-c10f55e12a71.png">

        # Demo 🍿

        <img width="250" src="https://user-images.githubusercontent.com/80469971/169039144-020d6a18-f442-4990-83cc-ed02c4af7d65.gif">


        - [ ] UI tested on iPhone and iPad
        - [ ] UI approved by the designer in the squad or the design team in #review
        - [ ] Relevant card on the [iOS Releases Trello board](https://trello.com/b/uyt9vqXa/⚔%EF%B8%8F-ios-releases) created and attached to this PR

        ## Relevant Links
        [Jira](https://overhq.atlassian.net/browse/CST-1113?atlOrigin=eyJpIjoiYzgzMzljMDZhMzY1NGVjMjk5NWFiOTM3YWVmZDJiYWMiLCJwIjoiaiJ9)
        """
        )
    }
}

struct Markdown_Previews: PreviewProvider {
    static var previews: some View {
        Markdown()
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            
    }
}
