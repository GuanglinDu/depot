# depot
Demo depot in Agile Web Development with Rails 4 by Sam Ruby, Dave Thomas &amp; DHH

## Testing
The texts of the following 3 parts are from [A Guide to Testing Rails Applications](http://guides.rubyonrails.org/testing.html) .

### Unit Testing of Models
3.3 What to Include in Your Unit Tests
Ideally, you would like to include a test for everything which could possibly break. It's a good practice to have at least one test for each of your validations and at least one test for every method in your model.

### Functional Testing of Controllers
4.1 What to Include in your Functional Tests
You should test for things such as:
-  was the web request successful?
- was the user redirected to the right page?
- was the user successfully authenticated?
- was the correct object stored in the response template?
- was the appropriate message displayed to the user in the view?

### Integration Testing of Applications
