The PhotoSearch.js file defines a reusable class of ajaxSearch objects, which implements an asynchronous JS and XML search mechanism. In order for an ajaxSearch object to work, you must already have a form field element that accepts a user's search strings. You must also have defined an action method that retrieves the user's search strings, executes the search, and generates code to display the search results.

To use the ajaxSearch class, create a new ajaxSearch object on the page where the searching takes place. Specify the following in the constructor parameters: 1) the name of the controller and 2) the action method that implements the searching mechanism, 3) the id of the form field element in which the user types in search terms, and 4) the id of the element which displays the search results on the page. The ajaxSearch object will detect any changes in the search form field, create new XHR objects upon changes, and update the search results accordingly.

In this project, an ajaxSearch object is used in the /users/index view to search for photos by tagged users' names and comment text. The ajaxSearch object could also feasibly be used to search for photos by their filenames, or to search for comments by the date they were created.
---

Also, a note on my implementation for Problem 1:
While coding the previous assignment, I reorganized my website so that each user's page (photos/index/id) displays simple thumbnails of that user's photos, and clicking on each photo redirects to the page for that particular photo (photo/view/id). The view page for an individual photo contains all the comments and tags.

For Problem 1, I made a design decision to link the search result thumbnails to photos/view/id rather than photos/index/id. This seemed to make more sense, given the layout of my website.