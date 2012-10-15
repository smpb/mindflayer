# Mind Flayer

> _“Yes, brain-eater. That’s what I said. Illithids relish the brains of humans and similar beings the way you eat the meat of cattle and fowl. To them, eating brains is a symbolic gesture. ... Being as intelligent as they are, endowed with psionic powers, and as physically weak as they are, the illithids believe that the mind is everything and all-important.”_ The githyanki tapped the yellowed skin of his temple with a bony finger. _“To eat the brain of another race is the ultimate symbol of dominion over that race. They consume that which is important to them."_
> 
> -- _"The Ecology of the Mind Flayer"_ by **Roger E. Moore**, from Dragon Magazine #78, 1983


## _"Wait, what?"_

**Mind Flayer** is a simple web app that "eats" brain matter in the shape of parsable IRC logs, consuming that which is important, and returning useful information such as nice looking statistics, or an aggregated links list.


## _"Why?"_

Because it's useful. But mostly, because it's fun.


## _"How?"_

Our tentacled friend is powered by the eldritch forces of `Perl`, and the `Mojolicious` web framework. Feel free to do:


    perl Build.PL
    ./Build installdeps
    sqlite3 messages.db < schema/messages.sql
    perl script/schema.pl --db messages.db --dir ./lib
    morbo script/mindflayer.pl


## _"I still think the name is weird..."_

Yeah well, I call that mission accomplished!


