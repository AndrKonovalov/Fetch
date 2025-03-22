### Summary: Include screen shots or a video of your app highlighting its features




### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

Most of the time spent on UI layer, Since I'm not very familiar with complex swiftUI objects, I decied to learn something new. 

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

basic project struct setup      20 min
Swiftlint setup                 5 min 
git setup                       5 min
Network layer                   30 min 
Unit Tests for network layer    1.5 hours 
UI Layer Base setup             2.5 hours
UI Custom toolbar + scroll      6 hours 
UI animations fixes             1 hour
Update network layer 
with abstractions + ViewModel   1 hour 
Profiling + fix of performance  1.5 hour
                       

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I’ve decided not to use persistent local storage for caching recipes obtained from remote sources between app launches since it isn’t a requirement. The network workers are implemented as actors, and with such a simple networking layer, everything works smoothly. That said, integrating a datastore could complicate things a bit.

I’ve also chosen to invest significant time in developing an animated toolbar. I haven’t worked extensively with SwiftUI before, and I was eager to learn something new.

Decided not to implement searchbar and related logic, it will probably take another 3-4 hours, especially in combine with scrolling toolbar

Did not implement localization bundle, not required in this app. 

### Weakest Part of the Project: What do you think is the weakest part of your project?

Lack of persistancy storage. It would be interesting to se how newest swift wrapper around core data works with actors and async await 
MVVM arch is not the best solution. For this specific task it works perfect, but for a larger scale apps or complex views it will not works so great, business logic must be handled by a different layer. 

Usage of singletons also not the greates solution, but for simplicity I've decided to go with it. 

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
