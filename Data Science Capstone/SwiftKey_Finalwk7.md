SwiftKey Word Prediction
========================================================
author: Emmanuel O Darko
date: 04/24/2021
autosize: true
font-import: http://fonts.googleapis.com/css?family=Risque
font-family: 'Risque'




Summary
========================================================

As new phones or electronics emerges, the need for completing task quickly is also rising. `Swiftkey` is a leading keyboard text prediction that predicts the next word or next phrase when one starts typing. The goal of this project is to predict a possible next word as users start typing in order to suggest or improve typing speed using `SwiftKey` data.


How Model was built
========================================================
The data was sampled and 5% was used, a bigram, trigram and quadgram of words were carried out
and the frequencies were carried out. when a user enters a word, say two words, the trigram dictionary is searched for the first two words matching the user input, the next higly frequent word is output as a prediction


How to use the App
========================================================

- Click on the link to the shiny.oi server
- Enter at least two word for predictions
- Click on submit for predicted word

<a href = "https://gmokyere.shinyapps.io/SwiftShiny/" > Run on shiny </a>


