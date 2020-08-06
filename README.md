# Barstool iOS Challenge

Completed Barstool iOS Challenge using MVVM and Coordinator patterns for a main structure with a following requirements.

Link to a Challenge `https://github.com/BarstoolSports/ios-challenge`

## Project Requirements

The goal of this project is to develop a small, 2-3 screen iOS app that consumes content from an HTTP endpoint, displays it in a grid, and allows tapping any content in the grid and viewing it on a detail screen.

> The project must be completed using **Swift 5**

1. Familiarize yourself with this HTTP endpoint which returns the most recent stories on www.barstoolsports.com: `https://union.barstoolsports.com/v2/stories/latest?type=standard_post&page=1&limit25`

2. Consume this endpoint via Alamofire (already included in the project as a CocoaPod) and display a 2 column grid where each tile has the main thumbnail and title of the story, the authors name, and the stories `brand_name` if it has one.

3. When tapping a tile, push a detail screen which consumes the HTTP endpoint `https://union.barstoolsports.com/v2/stories/{story_id}` and displays the story title, author, author image url, and story HTML (accessed from `story.post_type_meta.standard_post.content`)

#### Optional Additions

Although these additions are not necessary, they may help showcase your experience with other iOS frameworks:

1. Support infinite scroll on the main feed. You can adjust the `page=` in param in the first HTTP endpoint to receive subsequent pages of content.

2. Add a search bar to the main feed. The search can be done by filtering stories that are in memory or you can consume this HTTP endpoint to search across all Barstool content: `https://union.barstoolsports.com/v2/stories/search?query=patriots&page=1&limit=10`

3. Add 3-D touch support to the tiles so a user can "peek" at the underlying content before navigating to the detail screen.

4. Add a persistence layer so the content is cached and displays immediately upon quitting and reopening the app.

5. Add a pull-to-refresh control to the main feed and/or detail screen. The refresh action should trigger a request to the coorsponding HTTP endpoint and then reload the screen.
