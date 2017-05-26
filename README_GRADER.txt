Wikipedia Reader

Samuel Davidson - u0835059

This is my Wikipedia reader, I had to make some slight modifications with the design spec as time allowed. I spent about 25 hours on this project. Which is about 2x - 2.5x the time it took me on the other projects. 

This application isn't overflowing with features, but I spent a lot of time on debugging, polish, and learning new iOS/swift features. I focused on the UI/UX of its core ideas rather than a bunch of random features to make the app seem larger.

Features & Capabilities:

	- Queue up Wikipedia articles by tapping their hyperlinks.
		* Queued articles are stored in a tree.
		* Articles will automatically be removed from the tree when you've finished with them and all their children have been viewed.

	- View the tree of articles queued by navigating to the "Article Queue".

	- Remove Articles from the queue by dragging left on listed articles and tapping "Delete".

	- Moving back and forth between articles preserves the state/scroll position within the web view.

	- Automatically traverse and clear your article queue by tapping "Next ..." on the left side of the top navigation bar.

	- Fully functional on any iPhone 5 through 7 Plus and supports multiple orientations.

	- Persistence between sessions.
		* Restores your article queue to the layout from the previous session.

	- Lock/Unlock an article from auto-deleting by long-pressing its row in the Article Queue list.

	- Super amazing awesome icon and launch image.