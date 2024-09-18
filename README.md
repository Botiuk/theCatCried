# theCatCried

Built with: Rails 7.0.4, Ruby 3.2.2, postgres, Turbo, Stimulus, Bootstrap.

All interface text was made with I18n, available English and Ukraine locale. Language is automatically set based on the preferred locale of signed in user, or params locale from URL, or browser preferences, else use the default language. My native language is Ukrainian and this is the default language on the app.

The main goal of this application is to control and log all your earnings and expenses. This will allow you to analyze your budget and help you spend wisely.

When your login or sign up, you receive access to three main functions - category, operation, and report. The operation may be one of two types - earnings and expense. That's why, categories divided also to two types. First, you must create categories because they form a list from which you choose when creating a new operation. After that, you can create operations.

In the operations log and list of categories, you can to look for each record in detail, edit them, and delete them. But if the category is not empty, there are operation records associated with it, you can not delete her. First, you must change the category for this operation or operations.

In the operation logs is a function of search by category, which helps you look at records associated with it.

Reports show in visual form the cash flow in your wallet. You can create reports for a certain period of time for a single category or an entire type in the form of graphs by day and in form of charts by category.

The expression "the cat cried" is a Ukrainian phraseology that means a small amount of something. This phrase was chosen as funny for the first project on the Rails framework because it is a personal financial manager. The need for a new way of earning prompted me to start mastering a new profession. The phrase "money like a cat cried" is the most common use of this phraseology.