
# Mind Flayer

> “Yes, brain-eater. That’s what I said. Illithids relish the brains of humans and similar beings the way you eat the meat of cattle and fowl. To them, eating brains is a symbolic gesture. ... Being as intelligent as they are, endowed with psionic powers, and as physically weak as they are, the illithids believe that the mind is everything and all-important.” The githyanki tapped the yellowed skin of his temple with a bony finger. “To eat the brain of another race is the ultimate symbol of dominion over that race. They consume that which is important to them."
> 
> -- "The Ecology of the Mind Flayer" by Roger E. Moore, from Dragon Magazine #78, 1983


## "Wait, what?"

**Mind Flayer** is a simple web app that "eats" brain matter in the shape of parsable IRC logs, consuming that which is important, and returning useful information such as nice looking statistics, or an aggregated links list.


## "Why?"

Because it's useful. But mostly, because it's fun.


## "How?"

Our tentacled friend is powered by the eldritch forces of `Perl`, and the `Mojolicious` web framework. Feel free to do:


        perl Build.PL
        ./Build installdeps
        sqlite3 messages.db < schema/messages.sql
        perl script/schema.pl --db messages.db --dir ./lib
        morbo script/mindflayer.pl


## "I still think the name is weird..."

Yeah well, I call that mission accomplished!


